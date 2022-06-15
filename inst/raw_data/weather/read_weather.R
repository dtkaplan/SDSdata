# Scrape data on weather in Saint Paul, MN

library(countyweather)

# NOAA Web Service Key Token for kaplan@macalester.edu
NOAA_key_token <- "cbjFhBGbXIKclgruVLziAsyMvfscfjsA"
options(noaakey = NOAA_key_token)

Ramsey_county_fips <- 27123

Ramsey_weather <- NULL

# Documentation of variable names in the weather files: ftp://ftp.ncdc.noaa.gov/pub/data/noaa/ish-format-document.pdf

for (year in 1992:2022) {
  cat(year, "\n")
  Surface <- try(
    countyweather:::int_surface_data(usaf_code = "726584", wban_code = "14927", year = year,
                                              var = c("wind_speed", "wind_direction", "air_pressure",
                                                      "temperature_dewpoint", "temperature", "AA1_depth", "AA1_period_quantity_hrs"))
  )

  if (! inherits(Surface, "try-error")) {
    Tmp <- Surface %>%
      filter( !is.na(wind_speed), !is.na(wind_direction), AA1_period_quantity_hrs != "24") %>%
      mutate(wind_speed = as.numeric(wind_speed) / 10,
             wind_direction = as.numeric(wind_direction),
             air_pressure = as.numeric(air_pressure) / 10,
             temperature = as.numeric(temperature) / 10,
             temperature_dewpoint = as.numeric(temperature_dewpoint) / 10,
             precip = as.numeric(AA1_depth) / 10)

    Ramsey_weather <- bind_rows(Ramsey_weather, Tmp)
  }
}

Ramsey_weather <-
  Ramsey_weather %>%
  mutate(precip = ifelse(precip > 100, NA, precip),
         precip_hrs = as.numeric(AA1_period_quantity_hrs),
         precip_rate = precip / precip_hrs,
         temperature = ifelse(temperature > 100, NA, temperature),
         temperature_dewpoint = ifelse(temperature_dewpoint > 99, NA, temperature_dewpoint)) %>%
  select(-AA1_depth, -AA1_period_quantity_hrs)

save(Ramsey_weather, file = "data/Ramsey_weather.rda")
