#' Embed Images Directly in HTML Document
#'
#' In HTML mode, knitr `include_graphics()` will generate a `<img src=  >` tag to include
#' an image file. To do this, the image file needs to be in a place where it is available
#' for display when the HTML is rendered in a browser. For images in  packages, this is
#' not going to work.
#'
#'
#' @param filepath character string with path to the image file. The image file
#' must be PNG or JPEG or something that works in HTML
#' @param width An optional character string specifying the width in some
#' valid HTML format, e.g. `"50%"``  or `"10px"`. Ignored in latex output.
#' @param height Like `width`
#' @param tex_width Optional character string giving width of image in a latex-suitable
#' format, e.g. "100pt". When `tex_width` is defined, it has priority over `width`.

#' @format Character string specifying output format from knitr processing. This
#' will be set automatically when run within knitr.
#' @param more_tags An optional character string containing more text to be inserted into the `<img>` tag.
#'
#' @return A character string containing an `<img>` tag with a b64 encoded image
#' as the value of the `src=` field.
#' @examples
#' \dontrun{
#' # in an inline knitr chunk ...
#' sds_image_from_file("myimage.png")
#' }


#' @export
sds_image_from_file <- function(filepath,
                                width="80%", height=NULL, tex_width = width,
                                format = ifelse(knitr::is_html_output(), "html", "latex"),
                                more_tags="") {
  if (format == "latex") {
    if (is.null(tex_width)) width_str <- ""
    else if (grepl("%", tex_width)) { # convert  from 0-100 percent for latex
      tex_width <- paste0(readr::parse_number(tex_width)/100, "\\textwidth")
    } else {
      width_str <- sprintf("[width=%s]",  tex_width)
    }


    str <- sprintf("\\includegraphics%s{%s}", width_str, filepath)
    return(I(str))
    #return(knitr::include_graphics(filepath))
  }
  if (!file.exists(filepath)) {
    warning("File ", filepath, " doesn't exist.")
  }
  shape_string <- ""
  if (!is.null(height))
    shape_string <- paste0(shape_string, " height='", height, "'")
  if (!is.null(width))
    shape_string <- paste0(shape_string, " width='", width, "'")

  html_string <- sprintf("<img src='%s' %s %s>",
                         filepath, shape_string, more_tags)

  I(markdown:::.b64EncodeImages(html_string))
}
