#' Set up script for documents in the SDS book
#'
#' Loads various packages and sets parameters.
#'
#' @param ... additional arguments. Not used currently.
#' @export
sds_setup <- function(...) {
  library(SDSdata)
  library(mosaic)
  library(mosaicCore)
  library(mosaicModel)
  library(NHANES)
  library(ggformula)
  ggplot2::theme_set(theme_bw())
}
