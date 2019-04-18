#' Utility bills over 20 years for a home
#'
#' Transcription of the energy bills received over a 20-year period from
#' 1999 to 2019 for a residence in Saint Paul,  Minnesota, USA. The data are mostly
#' right, but there are some transcription errors.
#'
#'
#' @docType data
#'
#' @usage data(Energy_bills)
#'
#' @format A data.frame object with one row for each monthly bill.
#'

#' - `month`, `day`, `year` -- numerical values indicating the date the bill was produced
#' - `temp` -- the average temperature for the period covered by the  bill, in degrees F
#' - `kwh` -- the number of kilowatt-hours of electricity used
#' - `ccf` -- the  amount of natural gas consumed, in cubic feet
#' - `thermsPerDay` -- the average amount  of natural gas consumed each day, in a unit called "therms"
#' - `dur` -- the number of days in  the period covered by the bill. Typically one month.
#' - `totalbill` -- the total amount, in USD, of the bill
#' - `gasbill` -- the part of `totalbill` attributable to natural gas use
#' - `elecbill` -- the part of `totalbill` attributable to electricity consumption
#'
#'
#' @keywords datasets
#'
#' @source  The data were transcribed from  monthly utility bills for Danny Kaplan's house
#' in Saint Paul, Minnesota, USA
#'
"Energy_bills"
