# Murder data from Gapminder

library(readr)
library(rlang)

gapminder_files <- list(`homocide-60+.txt` = "rate_over_60",
                        `homocide-15-29.txt` = "rate_15_29",
                        `men_murder_rates.txt` = "rate_males",
                        `women_murder_rates.txt` = "rate_females",
                        `population.txt` = "population",
                        `violent_deaths.txt` = "total_deaths")

res = list()
for (k in 1:length(gapminder_files)) {
  file_name <- names(gapminder_files)[k]
  variable_name <- gapminder_files[[k]]
  The_data <- read_delim(file_name, 
                         "\t", escape_double = FALSE, trim_ws = TRUE) 
  names(The_data)[1] <- "country"
  res[[k]] <- foo <- The_data %>%
    tidyr::gather(key=year, value  = !!variable_name, -country)
}

All <- res[[1]]
for (k in 2:length(res)) {
  All <- All %>% full_join(res[[k]])
}
Homocides <- All %>% filter(year != "Totalt") %>%
  mutate(year = as.numeric(year))

save(Homocides, file = "Homocides.Rda")



