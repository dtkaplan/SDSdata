# Read one person's results from the Cherry  Blossom site

library(rvest)
library(dplyr)

get_many <- function(names) {
  res <- list()
  for  (k in 1:nrow(names)) {
    result <- try(
      one_person(first  = tolower(names$first[k]), last = tolower(names$last[k])))
    if ( ! inherits(result, "try-error")) res[[k]] <- result
    Sys.sleep(3)

    if (k == 10 || (k %% 100) == 0) save(res, file = paste0("result", k, ".rda"))
    cat("person ", k, "\n")
  }


  res
}


one_person <- function(first="anne", last = "schwartz", sex = "F") {
  url = "http://www.cballtimeresults.org/runners/{first}-{last}"
  page <- glue::glue(url)
  pg <- read_html(page)
  tab <- html_table(pg, fill=TRUE)[[1]]
  tab$sex <- sex
  tab$unique_id <- date()

  tab
}

read_1999 <- function(year = 1999) {
  women <- readLines(glue::glue("{year}-f.htm"))
  women <- women[-(1:2)]
  men <- readLines(glue::glue("{year}-f.htm"))
  men <- men[-(1:2)]
  women_names <- substr(women, 16,  41)
  men_names <- substr(men, 16, 41)

  together  <- c(women_names, men_names)
  to2 <-  gsub("^ +", "", together)
  to2 <- gsub("[ 0-9]+$", "", to2)

  last_pattern <- "[^ ]([a-zA-Z-]*)$"
  first_name = gsub(last_pattern, "", to2)
  last_name <- substr(to2, nchar(first_name), 100)
  first_name <- gsub(" +$", "", first_name)
  last_name <- gsub("^ +", "", last_name)
  names <- data.frame(first = first_name, last = last_name,
                      stringsAsFactors = FALSE)


  names
}

# names <- <- read_1999()

# Convert 5:23:41 to seconds
hhmmss2s <-  function(x) {
  x <- gsub("[^0-9:]", "", x)
  three <- strsplit(x, ":", fixed = TRUE)
  unlist(lapply(three, FUN = function(x) {
    if (length(x) == 3) sum(parse_number(x) * c(3600, 60, 1))
    else sum(parse_number(x) * c(60, 1))
  }))
}

# Runners with 10 or more records
foo <- lapply(Cohort_1999,  FUN = function(x) if(is.null(x)) 0 else nrow(x))
goo <- which(unlist(foo)  > 10)
Tmp<- bind_rows(Cohort_1999[goo])
Devoted_runners <- Tmp %>%
  rename(age  = Age, time = Time, division = Division,
                           name = Name) %>%
  filter(  ! grepl("5K",Race)) %>%
  mutate(year = parse_number(gsub(" .*$", "", Race))) %>%
  mutate(seconds = hhmmss2s(time)) %>%
  select(-Race, -unique_id, -Pace)
save(Devoted_runners, file = "data/Devoted_runners.rda")
