library(tidyverse)
library(readxl)

world.pop = read_excel("data-raw/World_Population.xlsx", sheet = "ESTIMATES", skip = 16, trim_ws = TRUE)

WorldPopulation = world.pop %>%
  filter(str_detect(Type, "Country")) %>%
  select(matches(("^Region|^(19[5-9][0-9]|20[0-1][0-9]|2020)$"))) %>%
  rename(Country = "Region, subregion, country or area *")

usethis::use_data(WorldPopulation, overwrite = TRUE)
