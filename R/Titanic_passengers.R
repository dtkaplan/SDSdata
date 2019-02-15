#' Passengers and crew on the Titanic
#'
#' @docType data
#'
#' @details The `Titanic_passengers` data frame is a roster of 1309 passengers on the steamship Titanic.
#' At the time of the sinking, there were approximately 2400 people on board the ship. Of these, approximately
#' 1330 were passengers, together with approximately 895 crew. The passenger list includes approximately
#' 42 people who were servants of other passengers.
#'
#' @usage data(Titanic_crew)
#'
#' @format `Titanic_passengers`: A data.frame object with one row for each passenger
#'
#' - `class`: The passenger's cabin class. Values first, second, or steerage.
#' - `survived`: Whether the passenger survived the sinking. Values: 1 if survived, 0 otherwise
#' - `sex`: the passenger's sex, `female` or `male`
#' - `age`: the age of the passenger (in years). Infants under 1 have a fractional year, others are truncated or rounded
#' to the nearest integer.
#' - `sibsp`: the number of siblings (including the spouse, if any) travelling with the passenger
#' - `parch`: the number of parents or children travelling with the passenger.
#' - `fare`: the fare paid for the passenger's ticket, GBP
#' - `embarked`: where the passenger got on to the Titanic: Southhampton, Cherbourg, Queenstown
#' - `boat`: the life boat in which the passenger was found
#' - `body`: the number assigned when the body was recovered. Empty for survivors or those whose body was never found.
#' - `cabin`: the passenger's cabin number
#' - `ticket`: the passenger's ticket number. (Passengers travelling together might have shared a ticket.)
#' - `destination`: the home or destination town for the passenger
#' - `name`: The passenger's name
#'
#' @keywords datasets
#'
#' @seealso Titanic_crew
#'
#' @source  <http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.xls> There are a number of
#' other potential sources for passenger lists, for instance <https://www.encyclopedia-titanica.org/titanic-passenger-lists/>.
#'
"Titanic_passengers"

