Energy_bills <- readr::read_csv(
  system.file("raw_data/Utilities/utilities-up-to-date.csv", package = "SDSdata")
)
save(Energy_bills, file = "data/Energy_bills.rda")
