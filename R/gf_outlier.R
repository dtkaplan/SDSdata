#' Plot the outliers of a variable
#'
#' @param ... Like other gg_formula functions, the first argument can optionally be a gg object (usually via a pipe). There must always
#' be a formula, again as in other gg_formula commands.
#' @param size as in other ggplot2 geoms
#' @param color ditto
#' @param alpha ditto
#'
#'
#' This is just like gf_boxplot(), but doesn't draw the box!
#'
#' @export
gf_outlier <- function(...) {
  args <- list(...)

  Prev <- tilde <- NULL

  if (inherits(args[[1]], "gg")) {
    Prev <- args[[1]]
    args <- args[-1] # take it off the list
  }
  if (!inherits(args[[1]], "formula"))
    stop("Must provide a tilde expression")

  tilde <- args[[1]]
  args <- args[-1] # take it off the list

  if ("color" %in% names(args)) {
    color <- args[["color"]]
    args <- args[names(args) != "color"]
  } else {
    color = "blue"
  }

  if ("alpha" %in% names(args)) {
    alpha <- args[["alpha"]]
    args <- args[names(args) != "alpha"]
  } else {
    alpha = 1.0
  }

  if ("size" %in% names(args)) {
    size <- args[["size"]]
    args <- args[names(args) != size]
  } else {
    size = 0.5
  }

  suppressWarnings(
    gf_boxplot(Prev, tilde, outlier.color = color, outlier.alpha = alpha,
             color = color, fill=NA, outlier.size = size, outlier.fill = color,
             ...)
  )

}
