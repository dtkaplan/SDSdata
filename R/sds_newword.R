#' Define a new word in the text.
#'
#' Given a character from a special unicode or other font, translate it into a tex command if needed.
#'
#' @param str the character string for the new word
#' @param format either `"html"` or `"latex"`. Default uses `knitr::is_latex_output()`
#'
#'
#' @examples
#' sds_newword("log likelihood", format = "latex")
#'
#' @export

sds_newword <- function(str, format = ifelse(knitr::is_latex_output(), "latex", "html")){
  if (format == "html") return(sprintf("***%s***", str))
  else sprintf("\\underline{%s}", str)
}
