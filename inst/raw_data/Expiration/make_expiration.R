# Get the FEV data from Kevin Cummissky's github site
library(dplyr)
Expiration = read.table('http://jse.amstat.org/datasets/fev.dat.txt')
colnames(Expiration) = c("age", "volume", "height", "sex", "smoke")
Expiration <-
  Expiration %>%
  mutate(sex =  ifelse(sex, "male", "female"),
         smoke  = ifelse(smoke, "smoker",  "non-smoker"))
save(Expiration, file = "data/Expiration.rda")
