#' Simulate ACY processes
#'
#' Generates samples from an ACY process. ACY refers to the paradigm where there
#' are multiple dicotomous variables and a causal DAG. In `acy_sim`, the DAG is implemented
#' by formulas, with the response variable on the left and the value to be calculated.
#' on the right.
#'
#' @details The calculated values are log odds. In the output, these will be converted to
#' 0,1 dicotomous variables. Exogenous variables should be set to a constant log odds.
#' (0 will give an equal prob of a 1/0 outcome.) Endogenous variables should be a mathematical
#' function of the exogenous and (sometimes) other endogenous variables.
#'
#' A label name can be an element of `...` or `story`. This label will be used to denote
#' the observed value if the underlying variable is 1. (`o` or 0 is used otherwise.)
#'
#' @param story Optional list containing formulas and/or label names
#' @param ... more formulas describing the process and/or label names
#' @param samp_n Integer giving the number of rows in the output
#'
#' @examples
#' acy_sim(x ~ 0, y ~ x, samp_n = 20)
#' acy_sim(X ~ 0, Y ~ 10* X - 1, Z ~ - 3 + 10 * Y, X = 1, Y = "murder", Z = "telegraph", samp_n = 50)
#'
#' @export
acy_sim <- function(story = NULL, ..., samp_n = 5) {
  # split ... into initial conditions and processes
  arguments <- c(story, list(...))
  formulas <- unlist(lapply(arguments, FUN = function(x) inherits(x, "formula")))
  influences <- arguments[formulas]
  action_names <- arguments[ ! formulas]


  # get all the variables
  vars <- unique(unlist(lapply(influences, FUN = all.vars)))
  # check that there is just one variable on the left side of all formulas
  left <- lapply(influences, FUN = function(x) all.vars(rlang::f_lhs(x)))
  left_count <- unlist(lapply(left, length))
  if (any(left_count != 1)) stop("Formulas must have a single variable on the LHS.")
  if ( ! all(vars %in% left)) {
    missing <- setdiff(vars, left)
    stop("All variables mnust have a formula. Missing: ", paste(paste0("'",missing,"'"), collapse = ", " ))
  }
  # Get the call for each formula, that is the LHS
  right <- lapply(influences, FUN = function(x) rlang::f_rhs(x))

  # Initialize the output data frame as log odds for each var/row
  res <- values <- as.data.frame(matrix(0, nrow = samp_n, ncol = length(vars) ))
  names(res) <- names(values) <- vars

  for (k in seq_along(left)) {
    new <- eval(right[[k]], envir = values)

    # if it's a scalar, then duplicate it for each row
    if (length(new) == 1) new <- rep(new, nrow(values))
    # Convert the log odds to a value
    x <- exp(new)
    prob <- x / (1 + x)
    values[[k]] <- as.integer(prob > runif(length(x)))
    action_levels <-
      if (vars[k] %in% names(action_names)) {
        label <- action_names[[vars[k]]]
        if (is.numeric(label)) c(0, label)
        else factor(c("o", label), labels = c("o", label))
      } else {
        factor(c("o", vars[k]), labels = c("o", vars[k]))
      }
    res[[k]] <- action_levels[1 + values[[k]]]
  }

  res
}
