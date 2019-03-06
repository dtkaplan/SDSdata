#' Weather during the Cherry Blossom 10-miler
#'
#'
#'
#' @docType data
#'
#' @usage data(Race_weather)
#'
#' @format A data.frame object with one row for each year the  Cherry Blossom 10-miler
#' was held
#'
#' - `year`
#' - `month` Race is held on a Sunday in early April
#' - `day`
#' - `temp` Temperature in deg. F
#' - `humidity` Humidity in percent
#' - `wind_speed` Average wind speed
#' - `gust` Speed of wind gusts, if substantially different from `wind_speed`
#' - `precip` Precipitation during one hour, in  inches
#' - `clouds` Description of the sky
#'
#' @source Scraped from Weather Underground via URLs like
#' <https://www.wunderground.com/history/daily/us/dc/washington/KDCA/date/2010-4-11>
#'
#' @keywords datasets
#'
#'
"Race_weather"
