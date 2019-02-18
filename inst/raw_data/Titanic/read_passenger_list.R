#' Arranging the titanic passenger data
#'
library(readxl)
library(stringr)
library(lubridate)
library(dplyr)
site <- "http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic3.xls"
site <- "~/Downloads/titanic3.xls" # as long as I have it on disk

Raw <- readxl::read_excel(site)
classes <- c("First", "Second", "Steerage")
city <- c(C = "Cherbourg", S = "Southhampton", Q = "Queenstown")
Raw$boat <- gsub(" .*$", "", Raw$boat)
var_order = c("class", "survived", "sex", "age", "sibsp", "parch",
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

Titanic_boats <- tibble::tribble(
  ~ boat, ~ capacity, ~ side, ~ position, ~ launch_order, ~ launch_time,
  1, 40, "starboard", "bow", 5, "1:05",
  3, 65, "starboard", "bow", 3, "1:00",
  5, 65, "starboard", "bow", 2, "12:43",
  7, 65, "starboard", "bow", 1, "12:40",
  9,  65, "starboard", "stern", 10, "1:30",
  11, 65, "starboard", "stern", 11, "1:35",
  13, 65, "starboard", "stern", 12, "1:40",
  15, 65, "starboard", "stern", 13, "1:41",
  2, 40, "port",  "bow",   14, "1:45",
  4, 65, "port",  "bow",   16, "1:50",
  6, 65, "port",  "bow",  6, "1:10",
  8, 65, "port",  "bow",  4,  "1:00",
  10, 65, "port", "stern",  15,   "1:50",
  12, 65, "port", "stern",  9, "1:30",
  14, 65, "port", "stern",  8, "1:30",
  16, 65, "port", "stern",  7, "1:20",
  "A",  47, "starboard", "bow", 20,  "2:12",
  "B",  47, "port", "bow", 19, "2:14",
  "C",  47, "starboard", "bow",  17, "2:00",
  "D",  47, "port", "bow", 18, "2:05"
) %>%
  mutate(launch_time = paste("April 15, 2012", launch_time)) %>%
  mutate(launch_time = lubridate::mdy_hm(launch_time))

save(Titanic_passengers, file = "data/Titanic_passengers.rda")
save(Titanic_crew, file = "data/Titanic_crew.rda")
save(Titanic_boats, file = "data/Titanic_boats.rda")
