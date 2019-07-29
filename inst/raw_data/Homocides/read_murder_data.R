# Murder data from Gapminder

library(mosaic)
library(readr)
library(rlang)

gapminder_files <- list(`homocide-60+.txt` = "rate_over_60",
                        `homocide-15-29.txt` = "rate_15_29",
                        `men_murder_rates.txt` = "rate_males",
                        `women_murder_rates.txt` = "rate_females",
                        `population.txt` = "population",
                        `violent_deaths.txt` = "total_deaths",
                        `birth_rate.txt` = "birth_rate",
                        `surface_area.txt` = "surface_area",
                        `population_15_19.txt` = "population_15_19",
                        `female_15_19.txt` = "females_15_19",
                        `male_15_19.txt` = "males_15_19",
                        `sl_uem_neet_zs.csv` = "youth_unemployment")

res = list()
for (k in 1:length(gapminder_files)) {
  file_name <- names(gapminder_files)[k]
  variable_name <- gapminder_files[[k]]
  delimiter <- ifelse(grepl("\\.csv$", file_name), ",", "\t")
  The_data <- readr::read_delim(file_name,
                         delimiter, escape_double = FALSE, trim_ws = TRUE)
  if (k == 12) browser()
  if (any(grepl("^X", names(The_data)))) {
    browser()
    names(The_data) <- gsub("^X", "", names(The_data))
  }
  names(The_data)[1] <- "country"

  res[[k]] <- foo <- The_data %>%
    tidyr::gather(key=year, value  = !!variable_name, -country)
}

All <- res[[1]]
for (k in 2:length(res)) {
  All <- All %>% full_join(res[[k]])
}
Homocides <- All %>% filter(year != "Totalt") %>%
  mutate(year = as.numeric(year),
         surface_area = as.numeric(surface_area))

save(Homocides, file = "Homocides.rda")



