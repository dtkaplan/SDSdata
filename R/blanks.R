#' Blanks and spaces for student answers in documents
#'
#' @param prompts vector of character strings to prompt the answer
#' @param length length of blank in mm
#' @param underline the short character string to use in composing the underline.
#' @param breaks  number of line breaks following each prompt
#' Default: nonbreaking space followed by a period.
#'
#' @export
question_blank <- function(prompts = "", length = 25, underline = "  .",
                           breaks = 2) {
  blank <- paste0(rep(underline, length), collapse = "")
  spaces <- paste0(rep("      \n\n", breaks), collapse = "")
  paste(c(paste(prompts, "\t",  blank), ""), collapse  = spaces)
}
