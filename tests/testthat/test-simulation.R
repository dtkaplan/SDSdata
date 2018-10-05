context("simulation")

test_that("Can correctly structure formulas", {
  expect_error(dag_system(~ a, ~ b))
  dag_system(A ~ unif(), B ~ A + gauss())
  expect_error(dag_system(A ~ 1, B ~ A + 2, A ~ B + 3))
  # nodes can't depend on themselves
  expect_error(dag_system(A ~ 1, B ~ A + B))
})

test_that("Notes are ordered correctly for execution", {
  sys <- dag_system(B ~ A + C, C ~ A, D ~ C + B, A ~ 1)
})

test_that("Detects cycles", {
  sys <- dag_system(B ~ C, C ~ A, A ~ B + D, D ~ 1)
})

test_that("Can simulate a dag", {
  dag <- dag_system(A ~ 1, B ~ 2)
  dag_simulate(dag, n = 3)
  dag <- dag_system(A ~ unif(), B ~ 3 + A)
  dag_simulate(dag, n = 3)
  dag <- dag_system(A ~ unif(), B ~ 3 + A, C ~ cos(5 * B - A  + gauss()))
  dag_simulate(dag, n = 3)

})

test_that("Random number generators work", {

})
