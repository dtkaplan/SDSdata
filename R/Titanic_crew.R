#' Crew on the Titanic
#'
#' @docType data
#'
#' @details `Titanic_crew` is a roster of 895 crew members and officers believed to be on the Titanic when she sank.
#'
#'
#'
#' @usage data(Titanic_passengers)
#'
#' @format  `Titanic_crew`: A data.frame object with one row for each crew member on the ship when she sank:
#'
#' - `crew`: The broad category of job held by the crewman
#' - `job`: A more specific description of the job
#' - `sex`: All the crew were male
#' - `survived`: Whether the crewmember survived the sinking. If so, 1. Otherwise, 0.
#' - `age`: The crewman's age, in years
#' - `boat`: For survivors, the lifeboat from which they were picked up
#' - `body`: For those whose body was recovered, the number assigned to the body. Missing for survivors or those whose body was never recovered.
#'
#' @keywords datasets
#'
#' @source  Scraped from <https://www.encyclopedia-titanica.org/titanic-passenger-lists/>.
#'
"Titanic_crew"

