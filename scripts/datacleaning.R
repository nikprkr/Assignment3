
library(tidyverse)
library(reshape2)
library(lubridate)

dir.create("./data")
dir.create("./data/raw")
dir.create("./data/clean")
dir.create("./output")
dir.create("./output/fig")
dir.create("./output/tab")
dir.create("./documentation")
dir.create("./paper")
dir.create("./scripts")

url_lookup_table<- "https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv?raw=true"
url_global<- "https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv?raw=true"

lookup_table <- read_csv(url_lookup_table)
global_data<- read_csv(url_global)

global_data<- rename(global_data, "Combined_Key" = "Country/Region")

combined_table <- left_join(global_data, lookup_table, "Combined_Key")

cases <- combined_table %>%
  select(Country_Region,UID,iso2,iso3,Population, everything(),-code3,-FIPS, -Admin2, -Lat.x,-Lat.y, -Province_State,-Long_, -`Province/State`,-Long, -iso2,-iso3,-UID) %>%
  group_by(Combined_Key) %>%
  summarise_at(vars("1/22/20":"2/24/22"), sum, na.rm=TRUE)

population <- combined_table %>%
  select(Country_Region,UID,iso2,iso3,Population, everything(),-code3,-FIPS, -Admin2, -Lat.x,-Lat.y, -Province_State,-Long_, -`Province/State`,-Long, -iso2,-iso3,-UID) %>%
  group_by(Combined_Key) %>%
  summarise_at(vars(Population), mean, na.rm=TRUE)

combined_table_clean <- left_join(cases, population, "Combined_Key") %>%
  select(Combined_Key, Population, everything())

data_long<- combined_table_clean %>% 
  pivot_longer(
    cols = "1/22/20":"2/24/22",
    names_to = "date", 
    values_to = "count"
  )

library(lubridate)

data_long$date<- as_date(data_long$date, format="%m/%d/%y")
data_long$ref_date <- c("01/22/2020")
data_long$ref_date <- as_date(data_long$ref_date, format="%m/%d/%y")
data_long$numdays <- as.numeric(difftime(data_long$date, data_long$ref_date, units = "days")) 

#create a table with the aggregate case count

aggregate_cases<- data_long %>%
  group_by(Combined_Key, date) %>%
  summarise_at(vars(count), max, na.rm=TRUE) %>%
  group_by(date) %>%
  summarise_at(vars(count), sum, na.rm=TRUE)

aggregate_cases <- data.frame(aggregate_cases)

#cases per 100,000

data_long_percapita <- data_long %>%
  mutate(perht= Population/100000)

data_long_percapita<- data_long_percapita %>%
  mutate(count_perht= (count/perht))

data_long_percapita <- data.frame(data_long_percapita)

# connect to Spark server

library(sparklyr)

sc <- spark_connect(master = "local",
                    version = "2.3")

#move data to Spark 

cases_counts <- copy_to(sc, aggregate_cases, overwrite = T)
cases_percapita <- copy_to(sc, data_long_percapita, overwrite = T)

# filter data in Spark

cases_percapita_filtered <- cases_percapita %>%
  filter(Combined_Key == "US" |Combined_Key=="Germany" |Combined_Key=="China"|Combined_Key=="United Kingdom"| Combined_Key=="Brazil"| Combined_Key=="Mexico"| Combined_Key=="Japan")
  
sdf_describe(cases_percapita_filtered, cols = c("Population", "count"))

ggplot(data = cases_counts, aes(x = date, y = log(count), group=1))+
  theme_minimal()+
  geom_line() +
  xlab("date") +
  ylab("log number of cases")+
  labs(title="Cumulative Global COVID-19 Cases", subtitle = "(1/22/2020 - 2/23/2022)")

ggplot(data = cases_percapita, aes(x = date, y = count_perht,color=Combined_Key))+
  theme_minimal()+
  geom_line() +
  xlab("date") +
  ylab("cases per 100,000 people")+
  labs(title="COVID-19 Cases per 100,000 people - Developed Nations", subtitle = "(1/22/2020 - 2/23/2022)")

## regression - log of number of cases using: country, population size and day since the start of the pandemic. 

#create a variable that is the number of days since collection began. as.duration(elapsed.time) / ddays(1)
#How do you convert lists to data frames in Spark
#install broom package
#save the spark objects on the spark server - spark_write_parquet(okc_train,"data/okc-train.parquet")
#view data on Spark after making changes - sdf_describe(okc_train, cols = c("age", "income"))
#"use this" package

model <- ml_linear_regression(cases_percapita,log(cases_percapita$count + 1) ~ cases_percapita$Population, cases_percapita$Combined_Key, cases_percapita$date)



#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