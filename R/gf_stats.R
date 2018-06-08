#' Graph basic descriptive statistics on a quantitative variable
#'
#' Creates a graphics layer displaying a point or interval statistic (as
#' from `dfstats`).
#'
#' @param object When chaining, this holds an object produced in the
#' earlier portions of the chain. Most users can safely ignore this argument. See details and examples.
#' @param formula A formula as with `dfstats` - quantitative response vs categorical
#' explanatory vars
#' @param data A data frame
#' @param stat A single statistic to be display, e.g., mean, ci.mean, median, ...
#' @param ... statistics to calculate (as with `df_stats`)
#'
#' @examples
#' gf_jitter(price ~ cut, data = tail(diamonds,1000), alpha = 0.1) %>%
#'   gf_stat(price ~ cut, stat = ci.mean)
#'
#' @export
gf_stat <- function(object, formula, data = NULL, stat = NULL, geom = gf_errorbar, ...) {

  if (inherits(object, "formula")) {
    formula <- object
    object <- NULL
  }

  if (inherits(object, "data.frame")) {
    data <- object
    object <- NULL
  }

  if (is.null(data)) {
    data <- object$data
  }

  Stat_res <- df_stats(formula, data, stat)

  gformula <- formula
  if (length(formula) == 2) remove <- NULL
  else remove <- all.vars(formula[[3]])
  stat_var_names <- setdiff(names(Stat_res), remove)
  if(length(stat_var_names) == 1)
    LHS <- parse(text = paste(stat_var_names, "+", stat_var_names))
  else
    LHS <- parse(text = paste(stat_var_names, collapse = "+"))

  gformula[2] <- LHS
  do.call(geom,
          c(list(object, gformula, data = Stat_res), ...))
}
