# Reconstruction of the "raw" data from the UC Berkeley admissions case
# Reference: Sex Bias in Graduate Admissions: Data from Berkeley
# P. J. Bickel, E. A. Hammel and J. W. O'Connell
# Science
# New Series, Vol. 187, No. 4175 (Feb. 7, 1975), pp. 398-404

# The tabulated data comes from datasets::UCBAdmissions
Frame <- as.data.frame(datasets::UCBAdmissions, stringsAsFactors = FALSE)
Res <- list()

for (k in 1:nrow(Frame)) {
  Res[[k]] <- data_frame(admit = rep(tolower(Frame[k,1]), Frame[k,4]),
                         gender = tolower(Frame[k,2]),
                         dept = Frame[k, 3])
}

set.seed(101)
UCB_applicants <- bind_rows(Res) %>% mosaic::shuffle() %>%
  select( - orig.id)
save(UCB_applicants, file = "data/UCB_applicants.rda")
