test_that("CountryPopulation returns a plot for a valid country", {

  country <- "China"

  plot <- CountryPopulation(country)

  expect_type(plot, "list")
})

test_that("CountryPopulation returns an error for an invalid country", {

  invalid_country <- "Invalid Country Name"

  expect_error(CountryPopulation(invalid_country), "Error: Country")
})
