#' Render an image in either html or latex as appropriate.
#'
#' Insert an image as either html or latex
#'
#' @param img quoted relative path name of image
#' @param width number giving width as percent
#' @param height number giving height as percent
#' @param lwidth number for latex width, if you want a different width for latex and for html
#' @param lheight number for latex height, like `lwidth`
#' @param format either `"html"` or `"latex"`. Default uses `knitr::is_latex_output()`
#'
#'
#' @examples
#' sds_image("images/bogus", format = "latex", width = 50)
#'
#' @export

sds_image <- function(img, width=NULL, height=NULL, lwidth = width, lheight = height,
                      format = ifelse(knitr::is_latex_output(), "latex", "html")){

  if (format == "html") {
    wstring <- ifelse(is.null(width), "", sprintf("width='%s%%'", as.character(width)))
    hstring <- ifelse(is.null(height), "", sprintf("height='%s%%'", as.character(height)))
    sprintf("<img src='%s' %s %s>", img, wstring, hstring)
  } else {
    wstring <- ifelse(is.null(lwidth), "0.5", as.character(lwidth/100))
    sprintf("\\includegraphics[width=%s\\textwidth]{%s}", wstring, img)
  }

}
