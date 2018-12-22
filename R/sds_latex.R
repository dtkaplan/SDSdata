#' Utilities for combining  latex environments into markdown
#'
#' @param environment The name of the latex environment, e.g. `"fullwidth"`
#' @param position Either `"begin"`` or  `"end"` to mark the beginning or end of an environment
#'
#' @examples
#' sds_latex("fullwidth", "begin")
#'
#' @export
sds_latex <- function(environment,  position = c("begin", "end")) {
  position <- match.arg(position)
  if (knitr::is_latex_output())  paste0("\\", position, "{", environment, "}")
  else ""
}
