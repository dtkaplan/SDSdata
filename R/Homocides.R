#' Country-by-country homocide data
#'
#' @docType data
#'
#' @details The data have been put together from <https://www.gapminder.org/data/>
#'
#' @usage data(Homocides)
#'
#' @format A data.frame object with one row for each of about 287 countries in various years
#' from 1800 to 2015. (Not all countries are represented for all years. Similarly, some variables
#' have non-missing data for only a few years.) The unit of observation is a country in a year.
#'
#' - `country`: The name of the country
#' - `year` the year of the observation
#' - `population` the estimated population
#' - `total_deaths` the total number of homicides. (Only for years 2002 and 2004.)
#' - `rate_females` the female homocide rate, age adjusted, per 100,000 people
#' - `rate_males` like `rate_females`
#' - `rate_over_60` like `rate_females` but gives the rate for people over age 60 (males and females)
#' - `rate_15_29` like `rate_over_60` but for people aged 15 to 29 years
#'
#'
#' @keywords datasets
#'
#' @source  The data themselves were scraped from the [Gapminder site](https://www.gapminder.org/data/) on July 25, 2019. Gapminder
#' organizes the data in separate columns for each year. These have been gathered together so that
#' the unit of observation is a country in a year.
"Homocides"
