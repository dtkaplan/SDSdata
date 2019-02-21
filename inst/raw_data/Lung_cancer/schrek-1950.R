# Reconstruction of raw data from Schrek et al. (1950)
# "Tobacco Smoking as an Etiologic Factor in Disease. I. Cancer"
# Cancer Res 1950;10:49-58.
# cancerres.aacrjournals.org/content/10/1/49

# From Table 3, comparing patients with lung, lip, and larynx/pharynx cancer with
# patients with cancer at other sites.

Schrek_table_3 <-
  tibble::tribble(
    ~ age, ~ number, ~ site, ~frac_smoking,
    20, 34, "other", 50,
    20, 2, "lip", 100,
    30, 10, "other", 40,
    30, 2, "larynx", 100,
    30, 1, "lip", 0,
    40, 171, "other", 57.9,
    40, 35, "lung", 77,
    40, 24, "larynx",  58,
    40, 47, "lip", 70,
    50,  192, "other", 49.5,
    50, 30, "lung", 67,
    50, 33, "larynx", 82,
    50, 48, "lip", 56,
    60, 62, "other", 40.3,
    60, 8, "lung", 63,
    60, 8, "larynx", 38,
    60, 14, "lip", 71,
    70, 17, "other", 18,
    70, 2, "larynx", 0,
    70, 4, "lip", 25
  )

one_cancer <- function(age, number, site, frac_smoking) {
  smoker <-  ifelse(seq(0,100, length = number) < frac_smoking,
                    "smoker", "nonsmoker")
  tibble::tibble(age = rep(age, number), site = site, smoker = smoker)
}

Schrek <- list()
for (k in 1:nrow(Schrek_table_3)) {
  Schrek[[k]] <- with(Schrek_table_3[k,  ], one_cancer(age, number, site, frac_smoking))
}

Schrek_1950 <- dplyr::bind_rows(Schrek) %>%
  mosaic::shuffle() %>% dplyr::select(- orig.id)
save(Schrek_1950,  file = "data/Schrek_1950.rda")


