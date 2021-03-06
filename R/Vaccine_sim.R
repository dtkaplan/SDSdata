#' Simulated vaccine/flu/mortality data
#'
#' These data were generated with a structural causal model. See details.
#'
#' @docType data
#'
#' @usage data(Vaccine_sim)
#'
#' @format
#' A data frame object with one row for each (simulated) person:
#'
#' - `health`: whether the person was in poor health
#' - `vaccination` did the person get vaccinated
#' - `flu` did the person get the flu
#' - `mortality`: did the person die
#'
#' The symbol "o" in the data frame indicates negation. For example, the levels
#' of `Flu` are `"Yes"` and `"o"`, which means yes and no.
#'
#' @keywords datasets
#'
#' @details The data were generated with
#' `set.seed(102)`
#'
#' `acy_sim(Health ~ 0,`
#' -         `Vaccination ~ 1.73 - 3.47 * Health,`
#' -          `Flu ~ log(.21/.79) + (log(.2/.8) - log(.21/.79)) * Vaccination,`
#' -          `Death ~ -4.595 + 0.704*Flu + 2.86*Health -  0.3*Health*Flu,`
#' -          `Health = "Poor", Vaccination = "Received", Flu = "Yes",``
#' -          `Death = "Died", samp_n = 10000)`
#'
"Vaccine_sim"
