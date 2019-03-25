# Augment the SAT data set with categorical variables

SATx <- mosaicData::SAT %>%
  mutate(frac_q = mosaic::ntiles(frac, n = 3, format = "interval"),
         expend_q = mosaic::ntiles(expend, n = 3, format = "interval"),
         ratio_q = mosaic::ntiles(ratio, n = 3, format = "interval"),
         salary_q  = mosaic::ntiles(salary, n  = 3,  format = "interval")
         )
save(SATx, file = "data/SATx.rda")
