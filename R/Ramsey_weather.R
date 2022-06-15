#' Hourly weather records in Ramsey County, MN
#'
#' These data, covering the period from late September 1992 through mid June 2022, were scraped from
#' the NOAA weather site. Measurements are made roughly every hour, although there are gaps and occasions
#' when the measurements are much more frequent.
#'
#' @docType data
#'
#' @usage data(Ramsey_weather)
#'
#' @format A data.frame object with one row for measurement time
#'
#' - `usaf_station`: the USAF code for the weather station (constant)
#' - `wban_station`: the WBAN code for the weather station (constant)
#' - `date_time`: a POSIXct format date & time
#' - `latitude`: constant
#' - `longitude`: constant
#' - `wind_speed`: in miles-per-hour
#' - `wind_direction`: direction wind is coming from, as a compass reading: 0 - 360 degrees, with 0 meaning north
#' - `air pressure`: in hectopascals
#' - `temperature_dewpoint`: in degrees C
#' - `temperature`: in degrees C
#' - `precip`: amount of liquid precipitation, in mm, over the last interval
#' - `precip_hrs`: the length of the interval over which `precip` was accumulated
#' - `precip_rate`: a rate: `precip / precip_hrs`.
#'
#' @details Some of the precipitation measurements overlap in time. For instance, there might be a 6-hour interval over which
#' precipitation was summed, as well as 1-hour intervals containing precipation counted in the 6-hour interval. Use `precip_rate` as
#' an indicator of how hard it was raining during the interval covered.
#'
#'
#' @keywords datasets
#'
#' @source  See the script in `system.file(package = "SDSdata", "raw_data/weather/read_weather.R")`
#'
"Ramsey_weather"
