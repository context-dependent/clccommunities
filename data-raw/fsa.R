## code to prepare `DATASET` dataset goes here


fsa_shp <- readr::read_rds("data-raw/fsa_shp.rds")

fsa_data <- fsa_shp %>%
    sf::st_set_geometry(NULL) %>%
    as.data.frame() %>% 
    tibble::as_tibble()

usethis::use_data(fsa_data, overwrite = TRUE)
usethis::use_data(fsa_shp, overwrite = TRUE)