# Reading and cleaning the fuel economy data

# Source: https://www.fueleconomy.gov/feg/download.shtml
# 2019 file: https://www.fueleconomy.gov/feg/epadata/19data.zip
# Unzips to 2019 FE Guide for DOE - release dates before 12-5-2018- no sales - 12042018public.xlsx
# but I saved it to Fuel_economy_2019.xlsx

Cars = readxl::read_excel("inst/raw_data/Fuel_economy/Fuel_economy-2019.xlsx")
foo <-
  Cars %>%
  dplyr::select(
    mpg_city = "City Unrd Adj FE - Conventional Fuel",
    mpg_hwy = "Hwy Unrd Adj FE - Conventional Fuel",
    mpg_comb = "Comb Unrd Adj FE - Conventional Fuel",
    CO2city = "City CO2 Rounded Adjusted",
    CO2hwy = "Hwy CO2 Rounded Adjusted",
    CO2combined = "Comb CO2 Rounded Adjusted (as shown on FE Label)",
    power = "Rated Motor Gen Power (kW)",
    model_year = "Model Year",
    class = "Carline Class Desc",
    valves_exhaust = "Exhaust Valves Per Cyl",
    valves_intake = "Intake Valves Per Cyl",
    start_stop = "Stop/Start System (Engine Management System)  Description",
    cyl_deact = "Cyl Deact?",
    vol_passengers2D = "2Dr Pass Vol",
    vol_passengers4D = "4Dr Pass Vol",
    vol_passengersH = "Htchbk Pass Vol",
    vol_luggage2D = "2Dr Lugg Vol",
    vol_luggage4D = "4Dr Lugg Vol",
    vol_luggageH = "Htchbk Lugg Vol",
    fuel = "Fuel Usage  - Conventional Fuel",
    drive = "Drive Desc",
    n_gears = "# Gears",
    n_cyl = "# Cyl",
    displacement = "Eng Displ",
    transmission = "Trans",
    lockup_torque_converter = "Lockup Torque Converter",
    air_aspiration = "Air Aspiration Method Desc",

    manufacturer = "Mfr Name",
    division = "Division",
    EPA_fuel_cost = "Annual Fuel1 Cost - Conventional Fuel",
    model = "Carline") %>%
  mutate(row = row_number())
foo <- foo %>%
  mutate(vol_passenger = ifelse(is.na(vol_passengers2D),
                                ifelse(is.na(vol_passengers4D),
                                       vol_passengersH, vol_passengers4D),
                                vol_passengers2D)) %>%
  mutate(vol_luggage = ifelse(is.na(vol_luggage2D),
                                ifelse(is.na(vol_luggage4D),
                                       vol_luggageH, vol_luggage4D),
                                vol_luggage2D)) %>%
  mutate(doors = ifelse(!is.na(vol_passengers2D), 2,
                        ifelse(!is.na(vol_passengers4D), 4, NA))) %>%
  mutate(hatchback = !is.na(vol_passengersH))

MPG <- foo
save(MPG, file = "data/MPG.rda")
# Add doors to be 2, 4 and hatch to be Y/N. Then you can look at the fuel economy as
# a function of the number of doors, which is likely correlated with the overall fuel economy
# because of size, weight,

# Grab a subset of the original data for a tidy-data problem.
MPG_doors <- Cars %>% dplyr::select(`Mfr Name`, Carline, `2Dr Pass Vol`, `4Dr Pass Vol`, `Htchbk Pass Vol`,
                `2Dr Lugg Vol`, `4Dr Lugg Vol`, `Htchbk Lugg Vol`) %>%
  filter(!(is.na(`2Dr Pass Vol`) & is.na(`4Dr Pass Vol`))) %>%
  group_by(`Mfr Name`) %>%
  filter(row_number() <= 2 | !is.na(`Htchbk Lugg Vol`)) %>%
  arrange(`Mfr Name`)
