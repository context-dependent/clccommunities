---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# clccommunities

<!-- badges: start -->
<!-- badges: end -->

The goal of `clccommunities` is to make it easy to identify postal codes in low income or rural communities. 

## Installation

You can install the latest version of the `clccommunities` package from [GitHub](https://github.com). 

``` r
# Run this line once to install the devtools package
# install.packages("devtools") 

# Run this line once to install or update the clccommunities package
devtools::install_github("context-dependent/clccommunities")
```

## Define Low Income and Rural Communities in Existing Data



```r
library(tidyverse)
library(clccommunities)
## basic example code

ontario_schools_plus <- ontario_schools %>% 
  
  mutate(
    clc_low_income = clc_calculate_low_income(postal_code), 
    clc_rural = clc_calculate_rural(postal_code)
  )

ontario_schools_plus %>% 
  count(clc_low_income) %>% 
  knitr::kable()
```



|clc_low_income                        |    n|
|:-------------------------------------|----:|
|Low Income (LIM-AT prev. = 19.3%)     | 1252|
|Not Low Income (LIM-AT prev. < 19.3%) | 4598|
|(Missing)                             |   22|

```r

ontario_schools_plus %>% 
  count(clc_rural) %>% 
  knitr::kable()
```



|clc_rural           |    n|
|:-------------------|----:|
|Not Rural (SAC < 4) | 5135|
|Rural (SAC = 4)     |  715|
|(Missing)           |   22|

## Add All Columns from the Reference Dataset to Existing Data


```r
# Run this once to install the tidyverse family of packages.
# install.packages("tidyverse")

library(tidyverse)
library(clccommunities)

ontario_schools_community_data <- add_community_data(ontario_schools, postal_code)

# Run this once to install the skimr package (not necessary, but helpful in general)
# install.packages("skimr")

skimr::skim_without_charts(ontario_schools_community_data)
```


Table: Data summary

|                         |                             |
|:------------------------|:----------------------------|
|Name                     |ontario_schools_community... |
|Number of rows           |5872                         |
|Number of columns        |42                           |
|_______________________  |                             |
|Column type frequency:   |                             |
|character                |28                           |
|numeric                  |14                           |
|________________________ |                             |
|Group variables          |None                         |


**Variable type: character**

|skim_variable             | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|region                    |         0|          1.00|  11|  14|     0|        5|          0|
|board_number              |         0|          1.00|   6|   6|     0|       85|          0|
|board_name                |         0|          1.00|   7|  56|     0|       85|          0|
|board_type                |         0|          1.00|  10|  27|     0|        8|          0|
|board_language            |         0|          1.00|   6|   7|     0|        2|          0|
|school_number             |         0|          1.00|   6|   6|     0|     5872|          0|
|school_name               |         0|          1.00|   4|  82|     0|     5327|          0|
|school_level              |         0|          1.00|   8|  10|     0|        3|          0|
|school_language           |         0|          1.00|   6|   7|     0|        2|          0|
|school_type               |         0|          1.00|   6|  19|     0|        6|          0|
|school_special_conditions |         0|          1.00|   4|  32|     0|       14|          0|
|suite                     |      5729|          0.02|   1|  40|     0|      121|          0|
|po_box                    |      5736|          0.02|   2|  16|     0|      109|          0|
|street                    |         5|          1.00|   1|  47|     0|     5201|          0|
|city                      |         8|          1.00|   3|  19|     0|      759|          0|
|province                  |         4|          1.00|   7|   7|     0|        1|          0|
|postal_code               |        13|          1.00|   6|   6|     0|     4404|          0|
|phone                     |       441|          0.92|  12|  12|     0|     4839|          0|
|fax                       |       905|          0.85|  12|  12|     0|     4510|          0|
|grade_range               |         0|          1.00|   3|  20|     0|       24|          0|
|date_open                 |         0|          1.00|  18|  18|     0|      399|          0|
|email                     |      2590|          0.56|  11|  50|     0|     3057|          0|
|website                   |       921|          0.84|   7| 113|     0|     4610|          0|
|board_website             |         1|          1.00|   8|  63|     0|       84|          0|
|fsa                       |        13|          1.00|   3|   3|     0|      495|          0|
|clc_rural_label           |        22|          1.00|   5|   9|     0|        2|          0|
|clc_low_income_label      |        22|          1.00|  10|  14|     0|        2|          0|
|female                    |        22|          1.00|   3|   5|     0|      470|          0|


**Variable type: numeric**

|skim_variable                  | n_missing| complete_rate|     mean|       sd|     p0|      p25|      p50|      p75|      p100|
|:------------------------------|---------:|-------------:|--------:|--------:|------:|--------:|--------:|--------:|---------:|
|population_2016                |        22|             1| 37491.18| 22444.44| 671.00| 21653.00| 32345.00| 46943.00| 111372.00|
|lim_at_prevalence              |        22|             1|     0.15|     0.07|   0.03|     0.10|     0.14|     0.18|      0.48|
|lim_at_count                   |        22|             1|  5122.37|  3289.21|  65.00|  2845.00|  4480.00|  6545.00|  21755.00|
|sac_rural_category             |        22|             1|     1.68|     1.36|   1.00|     1.00|     1.00|     1.00|      6.00|
|clc_rural_indicator            |        22|             1|     0.12|     0.33|   0.00|     0.00|     0.00|     0.00|      1.00|
|clc_low_income_indicator       |        22|             1|     0.21|     0.41|   0.00|     0.00|     0.00|     0.00|      1.00|
|black                          |        22|             1|  1727.05|  2589.03|   0.00|   235.00|   730.00|  2055.00|  16270.00|
|indigenous                     |        22|             1|  1122.08|  1639.52|  10.00|   300.00|   585.00|  1195.00|  14815.00|
|unemployment_rate              |        22|             1|     0.08|     0.02|   0.02|     0.06|     0.08|     0.09|      0.15|
|youth_15_to_24                 |        22|             1|  4764.18|  3028.71|  75.00|  2675.00|  3950.00|  5870.00|  16795.00|
|youth_15_to_29                 |        22|             1|  7099.93|  4356.32| 100.00|  4140.00|  5890.00|  8840.00|  23220.00|
|french_speakers                |        22|             1|  4389.29|  5630.43|  20.00|  1690.00|  2705.00|  4610.00|  44930.00|
|french_first_official_language |        22|             1|  1589.97|  3532.85|  10.00|   305.00|   490.00|  1015.00|  28210.00|
|immigrant                      |        22|             1| 10705.35| 11907.31|  85.00|  2780.00|  5975.00| 14405.00|  62100.00|

## Making a Simple Choropleth 

FSA polygons are available in the `fsa_shp` package data.
The initial installation process for the `sf` 
([Simple Features](https://r-spatial.github.io/sf/)) package is 
slightly more involved than the process for the other packages used in these examples.
You will need to first install the geospatial libraries that `sf` interfaces with on your computer. 


```r

library(sf)
library(tidyverse)
library(clccommunities)

schools_per_fsa <- ontario_schools %>% 
  
  add_community_data(postal_code) %>% 
  group_by(fsa) %>% 
  summarize(
    n_schools = n()
  )
  
schools_per_fsa_shp <- fsa_shp %>% 
  
  left_join(fsa_data, by = "fsa") %>% 
  filter(province == "Ontario") %>% 
  left_join(schools_per_fsa, by = "fsa") %>% 
  mutate(
    n_schools = coalesce(n_schools, 0)
  )

n_schools_range <- range(schools_per_fsa_shp$n_schools)

schools_per_fsa_shp %>% 
  
  ggplot() + 
  geom_sf(aes(fill = n_schools), colour = NA) + 
  scale_fill_viridis_b(
    guide = guide_colorbar(
      title = "# of Schools", 
      barheight = 12, 
      barwidth = 0.5
    ), 
    breaks = seq(0, 65, by = 10)
  ) + 
  theme_void() 
```

<img src="man/figures/README-example-choropleth-1.png" title="plot of chunk example-choropleth" alt="plot of chunk example-choropleth" width="100%" />

## Using package data outside of R

To use these data outside of the R environment, write the `fsa_data` object to a 
csv file, which you can open in Excel, Google Sheets, or any other program. 

```r
library(readr)
library(clccommunities)

write_csv(fsa_data, "path/to/destination-folder/file-name-of-your-choice.csv")
```

## Data Sources

[June 2021 Ontario Public School Address File](https://data.ontario.ca/dataset/ontario-public-school-contact-information) 

[2016 Census Profiles](https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/download-telecharger/comp/page_dl-tc.cfm?Lang=E)

[2016 Census Boundary Files](https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm)

[2016 Geographic Attribute File](https://www12.statcan.gc.ca/census-recensement/2011/geo/ref/att-eng.cfm)


