#' Format data frames nicely for SDS book
#'
#' Creates HTML or Latex markup with a footnote showing how many rows
#' there are in total.
#'
#' @param data the data frame to be displayed
#' @param show_n how many lines to display (default 6. Use `Inf` for all rows.)
#' @param nrows an integer specifying how many rows the from the data frame should be displayed in the footnote. Set to `Inf` to suppress footnote.
#' @param format either `"html"` or `"latex"`. Default will use `knitr::is_latex_output()` to decide.
#' @param caption string to pass as a caption to the table
#' @param ... additional arguments to `kableExtra::kable_styling()`, e.g. `"striped"`, `"hover"`
#' @examples
#' sds_table(mtcars, "striped", "hover")
#' sds_table(mtcars, show_n = 3, caption="Data about cars")
#' @export
sds_table <- function(data, show_n = 6L, nrows = nrow(data),
                      format=ifelse(knitr::is_latex_output(), "latex", "html"), caption="", ...) {
  res <-
    knitr::kable(head(data, min(c(nrows, show_n))),
                 format = format, caption=caption, row.names = FALSE) %>%
    kableExtra::kable_styling(full_width = FALSE, ...)
  if (nrows > show_n) {
    res <- res %>%
      kableExtra::footnote(general_title = sprintf("... and so on for %s rows altogether.",
                                                   prettyNum(nrows, big.mark = ",")),
                                                   general = "")
  }
  res
}
