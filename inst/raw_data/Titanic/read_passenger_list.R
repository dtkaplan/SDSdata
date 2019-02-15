#' Arranging the titanic passenger data
#'
library(readxl)
library(stringr)
site <- "http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.xls"
site <- "~/Downloads/titanic3.xls" # as long as I have it on disk

Raw <- readxl::read_excel(site)
classes <- c("First", "Second", "Steerage")
city <- c(C = "Cherbourg", S = "Southhampton", Q = "Queenstown")
var_order = c("class", "survived", "sex", "age", "parch",
              "embarked", "boat", "body", "cabin", "ticket", "fare", "destination", "name")
Raw$class <- classes[Raw$pclass]
Raw$embarked <- city[Raw$embarked]
Raw$destination <- Raw$home.dest
Titanic_passengers <- Raw[var_order]



#' Setting up the crew list
crew <- readLines("inst/raw_data/Titanic/crew_list.txt")
# get rid of the photograph lines
crew <- crew[! grepl("Photograph", crew)]
name_lines <- grep("[A-Z]{3,}", crew)
names <- gsub("\t*[0-9]{2}.*$", "", crew[name_lines])
ages <- gsub("[^0-9]{2}", "", crew[name_lines]) %>% gsub("[\tw ]", "", .) %>% readr::parse_number()
squad <- gsub("^.*\t", "", crew[name_lines])
embarked <- gsub("\t.*$", "", crew[name_lines + 1])
job <- gsub("^[.A-Za-z ]*\t", "", crew[name_lines + 1]) %>%
  str_extract(., "[\t123A-Za-z ]*")  %>%
  gsub("(\t| $)", "", .) %>%
  gsub("[0-9A-Z]{1,3}$", "", .)

drop <- c("(Delivery trip only)", "Deserted", "Discharged", "Failed to Join Ship",
          "Left Ship Sick", "Left with Consent", "Transferred")
to_be_dropped <- embarked %in% drop

body <- str_extract(crew[name_lines + 1], "\\[[0-9]{1,3}\\]") %>%
  str_extract(., "[0-9]{1,3}") %>%
  readr::parse_number()

boat <- str_extract(crew[name_lines + 1], "[\\[.]*\t.{1,3}$") %>%
  gsub("\t", "", .)
boat[grepl("\\[", boat)] <- NA

Titanic_crew <- tibble::tibble(crew = squad, job = job, age = ages, boat = boat, body = body, name = names)
Titanic_crew <- Titanic_crew[!to_be_dropped,]
Titanic_crew$sex <- "male"
Titanic_crew$survived <- as.numeric(!is.na(Titanic_crew$boat))
Titanic_crew$class <- "crew"

save(Titanic_passengers, file = "data/Titanic_passengers.rda")
save(Titanic_crew, file = "data/Titanic_crew.rda")

