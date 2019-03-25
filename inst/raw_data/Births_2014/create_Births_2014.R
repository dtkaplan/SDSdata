# Simplify natality2014::Natality_2014_100k

precare_levels = c(1, 2, 3, 4, rep("5+", 6), rep("never", 6))
previs_levels = c("never", rep("<5", 4), rep("5+", 5), rep("10+",  5), rep("15+", 100)  )
cig_levels = c(0, rep("<5", 4), rep("<10", 5), rep("<20", 10), rep("20+", 1000))
cig_order = c(0, "<5", "<10", "<20", "20+")

Births_2014 <- natality2014::Natality_2014_100k %>%
  select(mager, fagecomb, uop_induc, dbwt, ab_aven1, combgest, sex, apgar5, pay, me_rout,
         pwgt_r, dwgt_r, m_ht_in, cig_0, cig_1, cig_2, cig_3, wic,
         precare, previs, dplural) %>%
  rename(age_mother = mager, age_father = fagecomb, induced = uop_induc, baby_wt = dbwt,
         ventilator = ab_aven1, delivery = me_rout, mother_wt_before = pwgt_r,
         gestation = combgest, plurality = dplural,
         mother_wt_delivery = dwgt_r,
         mother_height = m_ht_in, prenatal_visits = previs) %>%
  mutate(pay = ifelse(pay %in% c("private", "self-pay"), "private", "government")) %>%
  mutate(precare = precare_levels[precare]) %>%
  mutate(precare = ordered(precare, levels = c(1,2,3,4,"5+",  "never"))) %>%
  mutate(sex = as.character(sex)) %>%
  mutate(plurality = as.character(plurality)) %>%
  rename(month_start_prenatal = precare) %>%
  mutate(prenatal_visits = ifelse(is.na(prenatal_visits), NA, previs_levels[prenatal_visits])) %>%
  mutate(cig_0  = ifelse(is.na(cig_0), NA, cig_levels[cig_0 + 1])) %>%
  mutate(cig_1  = ifelse(is.na(cig_1), NA, cig_levels[cig_1 + 1])) %>%
  mutate(cig_2  = ifelse(is.na(cig_2), NA, cig_levels[cig_2 + 1])) %>%
  mutate(cig_3  = ifelse(is.na(cig_3), NA, cig_levels[cig_3 + 1])) %>%
  mutate(cig_0 = ordered(cig_0, levels = cig_order)) %>%
  mutate(cig_1 = ordered(cig_1, levels = cig_order)) %>%
  mutate(cig_2 = ordered(cig_2, levels = cig_order)) %>%
  mutate(cig_3 = ordered(cig_3, levels = cig_order))

save(Births_2014, file = "data/Births_2014.rda")
