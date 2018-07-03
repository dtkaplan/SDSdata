context("ACY")

test_that("labels are correctly generated", {
  set.seed(101)
  murder_story <- list(Butler ~ 2,
                       Son ~ -1 + Butler,
                       Outcome ~ -1 + 2* Son,
                       Niece ~ Outcome,
                       # labels
                       Butler = "telegram", Son = "poison",
                       Outcome = 1, Niece = "inherits")
  res <- acy_sim(story = murder_story, samp_n = 30)
  expect_true("telegram" %in% res$Butler)
  expect_true("poison" %in% res$Son)
  expect_true("inherits" %in% res$Niece)
  expect_true(is.numeric(res$Outcome))
  expect_true(1 %in% res$Outcome)
})

test_that("Missing formulas prompt error message", {
  set.seed(101)
  murder_story <- list(
                       Son ~ -1 + Butler,
                       Outcome ~ -1 + 2* Son,
                       Niece ~ Outcome,
                       # labels
                       Butler = "telegram", Son = "poison",
                       Outcome = 1, Niece = "inherits")
  expect_error(acy_sim(story = murder_story, samp_n = 30))

})

test_that("Formulas alter probabilities appropriately", {
  set.seed(101)
  this_story <- list(A ~ -1, B ~ 0 + A, C ~ 1 + 10*B, A = 1, B = 1, C = 1)
  res <- acy_sim(story = this_story, samp_n = 10000)
  expect_true(sum(res$A) < 3000)
  expect_true(sum(res$B) < 6000)
  expect_true(sum(res$C) > 8000)

})
