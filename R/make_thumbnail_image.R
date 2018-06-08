#' Create a thumbnail image of a URL
#'
#' @param URL character string with the URL of the app
#' @param delay number of seconds to delay before snapping the thumbnail
#'
#' @export
make_thumbnail_image <- function(URL, delay = 25) {
  if (missing(URL)) stop("Must provide the URL to the app.")
  img_file <- paste0(tolower(basename(URL)), ".png")
  webshot::webshot(URL,
                   img_file,
                   cliprect = "viewport", delay = delay)
}
