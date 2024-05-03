#' A line Graph of average population
#'
#' Because this is a very simple function, my explanation is short. These
#' paragraphs should explain everything you need to know.
#'
#' This is still in the description part of the documentation and and it
#' will be until we see something that indicates a new section.
#'
#' @param x A real country that exists in the table WorldPopulation.
#' @return a line graph of the Countries average population from 1950 to 2020.
#' @examples
#' function("China") #will give you a line graph of China's average population
#' @export
CountryPopulation = function(x){
  library(tidyverse)
  library(cowplot)
  library(ggplot2)
  WorldPopulation.long = pivot_longer(WorldPopulation,
                                      cols = 2:ncol(WorldPopulation),
                                      names_to = "Year",
                                      values_to = "Population")

  WorldPopulation.long$Population = as.double(WorldPopulation.long$Population)
  WorldPopulation.long$Year = as.integer(WorldPopulation.long$Year)

  WorldPopulation.graph = WorldPopulation.long %>%
    filter(Country == x)

  if (nrow(WorldPopulation.graph) == 0) {
    stop(paste("Error: Country", x, "not found in the dataset."))
  }

  pop.over.time = ggplot(WorldPopulation.graph, aes(x = Year, y = Population)) +
    geom_line() +
    labs(title = x,
         x = 'Year',
         y = 'Population')
  pop.over.time + theme_cowplot()
}
