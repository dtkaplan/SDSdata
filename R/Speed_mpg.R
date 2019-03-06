#' Fuel economy as a function  of vehicle  speed
#'
#' Fuel economy of a 2009 Toyota RAV-4 driving on Interstate Highway 40 in Texas in early March, 2019. The car was held steady  at
#' each speed using the car's "cruise control."  The highway had  some gentle ups  and downs.
#' All of the data at one speed were collected consecutively, approximate every 4 seconds. Data
#' was recorded only after the car had been held  steadily at speed for at least 15 seconds.
#'
#' @docType data
#'
#' @usage data(Speed_mpg)
#'
#' @format A data.frame object with one row for each observation
#'
#' - `order` measurements were collected consecutively at  each speed. The entry with order 1
#' was the first measurement, order 2 was the second,  and so on.
#' - `speed` the speed (miles per hour) at which the vehicle was travelling. Measured  from the car's speedometer.
#' - `mpg`  "Instantaneous" fuel economy (miles per gallon) according to the car's dashboard
#' reading. In fact, the reading averages over approximately a second of travel.

#'
#' @source D.T. Kaplan
#'
#' @keywords datasets
#'
#'
"Speed_mpg"
