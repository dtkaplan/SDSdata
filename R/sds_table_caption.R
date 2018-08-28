#' Adds a table caption for a markdown table or other content
#'
#'
#' @param caption the character string for the new word
#' @param name character string specifying reference label for the caption
#' @param format either `"html"` or `"latex"`. Default uses `knitr::is_latex_output()`
#'
#'
#' @examples
#' sds_table_caption("This can be the table caption!")
#'
#' @export

sds_table_caption <- function(caption, name = NULL, format = ifelse(knitr::is_latex_output(), "latex", "html")){
  if (format == "html") {
    res <- knitr::kable(as.data.frame(1)[-1], caption = caption, format = format)
  } else {
    if (is.null(name)) stop("Must assign caption name in sds_table_caption() in latex mode.")
    res <- sprintf('\\begin{table}
    \\caption{\\label{tab:%s}%s\\newline}
    \\end{table}', name, caption)
    attributes(res) <- list(format = "latex")
    class(res) <- "knitr_kable"
  }

  I(res)
}
