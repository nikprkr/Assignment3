# Assignment3

## Project Description

We're exploring data containing COVID-19 case counts for Germany, China, Japan, United Kingdom, US, Brazil, Mexico. We calculate the number of cases and rate of cases (cases/population) by country and day then produce a graph for the change in the number of cases and another for the change in rate by country. We then explore the influence of country, population, and the number of days since the panedemic began to determine their influence on overall case counts. 

## Folder Structure

All scripts can be found in the scripts folder. 

## Session Information

R version 3.6.0 (2019-04-26)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 18.04.2 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/openblas/libblas.so.3
LAPACK: /usr/lib/x86_64-linux-gnu/libopenblasp-r0.2.20.so

locale:
 [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8        LC_COLLATE=C.UTF-8    
 [5] LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8    LC_PAPER=C.UTF-8       LC_NAME=C             
 [9] LC_ADDRESS=C           LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] texreg_1.38.6   sparklyr_1.7.5  lubridate_1.8.0 reshape2_1.4.4  forcats_0.5.1   stringr_1.4.0   dplyr_1.0.8    
 [8] purrr_0.3.4     readr_2.1.2     tidyr_1.2.0     tibble_3.1.6    ggplot2_3.3.5   tidyverse_1.3.1

loaded via a namespace (and not attached):
 [1] httr_1.4.2         bit64_4.0.5        vroom_1.5.7        jsonlite_1.8.0     modelr_0.1.8      
 [6] StanHeaders_2.18.1 assertthat_0.2.1   stats4_3.6.0       cellranger_1.1.0   yaml_2.2.0        
[11] r2d3_0.2.3         pillar_1.7.0       backports_1.1.4    glue_1.6.2         digest_0.6.18     
[16] rvest_1.0.2        colorspace_1.4-1   htmltools_0.3.6    plyr_1.8.4         pkgconfig_2.0.2   
[21] rstan_2.18.2       broom_0.7.12       haven_2.4.3        scales_1.0.0       processx_3.5.3    
[26] tzdb_0.3.0         generics_0.0.2     ellipsis_0.3.2     withr_2.5.0        cli_3.2.0         
[31] magrittr_2.0.3     crayon_1.5.1       readxl_1.3.1       evaluate_0.15      ps_1.3.0          
[36] fs_1.5.2           fansi_0.4.0        xml2_1.3.3         pkgbuild_1.0.3     tools_3.6.0       
[41] loo_2.1.0          prettyunits_1.0.2  hms_1.1.1          lifecycle_1.0.1    matrixStats_0.54.0
[46] munsell_0.5.0      reprex_2.0.1       callr_3.7.0        compiler_3.6.0     forge_0.2.0       
[51] rlang_1.0.2        grid_3.6.0         rstudioapi_0.13    htmlwidgets_1.3    base64enc_0.1-3   
[56] rmarkdown_1.12     gtable_0.3.0       curl_3.3           inline_0.3.15      DBI_1.0.0         
[61] R6_2.4.0           gridExtra_2.3      knitr_1.38         bit_4.0.4          utf8_1.1.4        
[66] rprojroot_1.3-2    stringi_1.4.3      parallel_3.6.0     Rcpp_1.0.1         vctrs_0.4.0       
[71] dbplyr_2.1.1       tidyselect_1.1.2   xfun_0.30         
