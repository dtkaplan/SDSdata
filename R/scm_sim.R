#' Simulate structural equation processes
#'
#' Generates samples from a structural causal model (SCM).  In `scm_sim`, the DAG is implemented
#' by formulas, with the response variable on the left and the value to be calculated.
#' on the right.
#'
#' @details You can set the exogenous random component of any variable by using
#' the desired `r____()` random number generator with `samp_n` as the value of size.
#'
#' A label name can be an element of `...` or `story`. This label will be used to denote
#' the observed value if the underlying variable is 1. (`o` or 0 is used otherwise.)
#'
#' @param story Optional list containing formulas and/or label names
#' @param ... more formulas describing the process and/or label names
#' @param samp_n Integer giving the number of rows in the output
#'
#' @examples
#' sem_sim(X ~ rnorm(samp_n), Y ~ 10 + runif(samp_n) + 5 * X, samp_n = 20)
#' sem_sim(X ~ 0, Y ~ 10* X - 1, Z ~ - 3 + 10 * Y, X = 1, Y = "murder", Z = "telegraph", samp_n = 50)
#'
#' @export
sem_sim <- function(story = NULL, ..., samp_n = 5) {
  # split ... into initial conditions and processes
  arguments <- c(story, list(...))
  formulas <- unlist(lapply(arguments, FUN = function(x) inherits(x, "formula")))
  influences <- arguments[formulas]
  action_names <- arguments[ ! formulas]


  # get all the variables except for `samp_n`
  vars <- unique(unlist(lapply(influences,
                               FUN = function(x) setdiff(all.vars(x), "samp_n"))))
  # check that there is just one variable on the left side of all formulas
  left <- lapply(influences, FUN = function(x) all.vars(rlang::f_lhs(x)))
  left_count <- unlist(lapply(left, length))
  if (any(left_count != 1)) stop("Formulas must have a single variable on the LHS.")
  if ( ! all(vars %in% left)) {
    missing <- setdiff(vars, left)
    stop("All variables mnust have a formula. Missing: ",
         paste(paste0("'",missing,"'"), collapse = ", " ))
  }
  # Get the call for each formula, that is the LHS
  right <- lapply(influences, FUN = function(x) rlang::f_rhs(x))

  # Initialize the output data frame as log odds for each var/row
  res <- values <- as.data.frame(matrix(0, nrow = samp_n, ncol = length(vars) ))
  names(res) <- names(values) <- vars

  for (k in seq_along(left)) {
    values[[k]] <- eval(right[[k]], envir = values)
  }

  values
}
