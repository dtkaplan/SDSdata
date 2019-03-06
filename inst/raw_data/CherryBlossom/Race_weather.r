Race_weather <- tibble::tribble(
  ~ year, ~ month, ~ day, ~ temp, ~ humidity, ~wind_speed,  ~ gust,  ~ precip, ~ clouds,
  2017, 4, 2, 46, 63, 9, 0, 0, "fair",
  2016, 4, 3, 37, 42, 15, 30, 0.1, "partly cloudy",
  2015, 4, 12, 51, 52, 0, 0, 0, "fair",
  2014, 4, 6, 43, 51, 8, 0, 0, "fair",
  2013, 4, 7, 44,  68, 15, 0, 0, "partly cloudy",
  2012, 4, 1,  48, 77, 6, 0, 0,  "cloudy",
  2011, 4, 3, 44, 60, 9, 0, 0, "fair",
  2010, 4, 11, 50,  71, 6, 0, 0, "fair",
  2009, 4, 5, 47, 41, 17, 23, 0, "fair",
  2008, 4, 6, NA, NA, NA, NA, NA, NA,
  2007, 4, 1, NA, NA, NA, NA, NA, NA,
  2006, 4, 2, NA, NA, NA, NA, NA, NA,
  2005, 4, 3, 45, 49, 21, 28, 0, "cloudy/windy",
  2004, 4, 4, NA, NA, NA, NA, NA, NA,
  2003, 4, 3, NA, NA, NA, NA, NA, NA,
  2002, 4, 7, NA, NA, NA, NA, NA, NA,
  2001, 4, 8, 46, 96, 5, 0, 0, "cloudy",
  2000, 4, 9, 36, 52, 17, 31, 0, "cloudy",

)
save(Race_weather, file = "data/Race_weather.rda")
