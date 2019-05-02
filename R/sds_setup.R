#' Set up script for documents in the SDS book
#'
#' Loads various packages and sets parameters.
#'
#' @param ... additional arguments. Not used currently.
#' @export
sds_setup <- function(...) {
  library(SDSdata)
  library(MASS)
  library(tufte)
  library(mosaic)
  library(mosaicCore)
  library(mosaicModel)
  library(NHANES)
  library(ggformula)
  #library(quickDAG)
  library(rpart)
  library(randomForest)
  library(kernlab)
  library(tibble)
  library(dplyr)
  library(tidyr)
  knitr::opts_chunk$set(fig.align=FALSE, echo = FALSE, message = FALSE, warning = FALSE, out.width = "80%")
  ggplot2::theme_set(theme_bw())
}
