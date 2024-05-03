library(tidyverse)
library(rvest)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'

page = read_html(url)

table = page %>%
  html_nodes('table') %>%
  .[[4]] %>%
  html_table() %>%
  .[-c(1), ]

table$Matches = as.numeric(gsub(",", "",table$Matches))
table$`Totalattendance †` = as.numeric(gsub(",", "",table$`Totalattendance †`))
table$Averageattendance = as.numeric(gsub(",", "",table$Averageattendance))

World_Cup = table %>%
  select(Year, Hosts, Matches, `Totalattendance †`, Averageattendance) %>%
  filter(Year <= year(now()))

colnames(World_Cup) = c('Year', 'Hosts', 'Matches', 'Totalattendance', 'Averageattendance')

World_Cup = World_Cup %>%
  mutate(
    WorldCup = paste0(Hosts, Year),
    WorldCup = gsub("\\s", "", WorldCup)
  ) %>%
  select(-Year,-Hosts)

World_Cup$WorldCup[17] <- str_replace(World_Cup$WorldCup[17], "\\s", "")

usethis::use_data(World_Cup, overwrite = TRUE)
