#' Piecewise linear functions based on means and medians
#'
#' Approximate a linear fit by the line connecting the midpoints
#' of the lower half of the data and the upper half of the data
#'
#' @param formula a formula  y ~ x
#' @param data a data frame containing the variables in the formula
#' @param stat_fun either `mean` or `median` or another function defining "midpoint"
#'
#' @examples
#' mean_vs_mean(mpg ~ hp, data = mtcars)
#' @export
mean_vs_mean <- function(formula, data = parent.env(), stat_fun = mean) {
  explanatory <- formula[[3]]
  response <- formula[[2]]
  data <- data %>% mutate(.gp. = ntiles(!!explanatory, n = 2))
  Midpoints <-
    data %>%
    group_by(.gp.) %>%
    summarise(x = stat_fun(!!explanatory), y = stat_fun(!!response))
  deltax <- diff(Midpoints$x)
  deltay <- diff(Midpoints$y)
  startx <- Midpoints$x[1]
  starty <- Midpoints$y[1]
  slope <- deltay / deltax
  intercept <- - startx * slope + starty
  line_formula <- sprintf("m * %s + b", as.character(explanatory) )

  F <- function(x) { }
  body(F) <- parse(text = line_formula)
  L <- list(m = slope, b = intercept)
  L <- c(alist(explanatory = ), L)
  names(L)[1] <- as.character(explanatory)
  formals(F) <- L
  environment(F) <- baseenv()

  F
}

#' @export
val_by_group <- function(formula, data = parent.env(), stat_fun = mean ) {
  # Just one explanatory group
  explanatory <- formula[[3]]
  response <- formula[[2]]
  Midpoints <-
    data %>%
    group_by_(as.character(explanatory)) %>%
    summarise(y = stat_fun(!!response))
  group_names <- Midpoints[[as.character(explanatory)]]
  yvals <- paste0("c(",
                  paste(
                    paste(paste0('"', group_names, '"'), "=", Midpoints$y),
                    collapse=", ")
                  ,")[as.character(", as.character(explanatory), ")]")
  yvals <- parse(text = yvals)

  F <- function(x) {}
  body(F) <- yvals
  L <- alist(x = )
  names(L) <- as.character(explanatory)
  formals(F) <- L

  F
}

