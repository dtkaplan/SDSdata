#' Blanks and spaces for student answers in documents
#'
#' @param prompts vector of character strings to prompt the answer
#' @param length length of blank in mm
#' @param underline the short character string to use in composing the underline.
#' @param breaks  number of line breaks following each prompt
#' Default: nonbreaking space followed by a period.
#'
#' @export
question_blank <- function(prompts = "", length = 3, underline = "  .",
                           breaks = 2) {
  blank <- paste0(rep(underline, length), collapse = "")
  spaces <- paste0(rep("      \n\n", breaks), collapse = "")
  paste(c(paste(prompts, "\t",  blank), ""), collapse  = spaces)
}

#' @export
word_pdf_links <- function() {
  stub_name <- tools::file_path_sans_ext(knitr::current_input())
  if (knitr::opts_knit$get('rmarkdown.pandoc.to') %in% c("html")) {
    glue::glue("Get formatted versions: [Word](word-versions/{stub_name}.docx) : [PDF](pdf-versions/{stub_name}.pdf)")
  } else {
    " "
  }
}
