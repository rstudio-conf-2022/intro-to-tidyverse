# Pollution data for session 05 (group_by() and summarize())

# Libraries
library(readxl)
library(tidyverse)

url_data <- 
  "https://cdn.who.int/media/docs/default-source/air-pollution-documents/air-quality-and-health/who_aap_2021_v8_new.xlsx?sfvrsn=a8dc3f2_3"
file_raw <- here::here("slides/data-raw/session05/pollution.xlsx")
file_out <- here::here("slides/data/session05/pollution.csv")

cities <- c("Seoul", "Dubai", "Casablanca")
years <- 2019:2020
# ==============================================================================

download.file(url_data, file_raw)

pollution <- 
  read_excel(file_raw, sheet = 2) %>% 
  janitor::clean_names() %>% 
  filter(city_or_locality %in% cities, measurement_year %in% years) %>% 
  select(
    city = city_or_locality,
    year = measurement_year,
    amount = pm10_mg_m3
  ) %>% 
  write_csv(file_out)
