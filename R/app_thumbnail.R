#' Generate HTML (or Latex?) to show an image as a link to an app (or other webpage)
#'
#' @param URL character string giving link to the app
#' @param img character string locating the image
#' @param caption character string setting the caption to display under the thumbnail
#'
#' @export

app_thumbnail <- function(URL, img, caption=NULL) {
  htmltools::div(class = "col-sm-4",
      htmltools::a(class = "thumbnail", title = caption, href = URL,
        htmltools::img(src = img),
        htmltools::div(class = ifelse( !is.null(caption), "caption", ""),
            ifelse(!is.null(caption), caption, "")
        )
      )
  )
}


