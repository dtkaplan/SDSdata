#' Render a special character in either html or latex as appropriate.
#'
#' Given a character from a special unicode or other font, translate it into a tex command if needed.
#'
#' @param char the character, as a quoted string
#' @param format either `"html"` or `"latex"`. Default uses `knitr::is_latex_output()`
#' @param show if TRUE, return a vector showing the available characters. Not intended for use in documents, just to help identify
#' when a character you want to use is missing.
#'
#' @details The point of this function is to let you use native characters in html mode, but avoid characters that
#' latex doesn't recognize by using the corresponding latex command when in latex mode. Why not just use the latex command
#' in both cases. That's not a bad practice, but it causes problems when trying to create a Kindle edition, since Kindle doesn't
#' process latex.
#'
#' @examples
#' sds_character("♣", format = "latex")
#' sds_character(show = TRUE)
#'
#' @export

sds_character <- function(char, show = FALSE, format = ifelse(knitr::is_latex_output(), "latex", "html")){
  # for latex
  substitutions <- c(
    "●" = "$\\bullet$",
    "♣" = "$\\clubsuit$",
    "©" = "\\textcopyright",
    "☛" =  "$\\longrightarrow$",
    "←" = "$\\leftarrow$",
    "➔" = "$\\rightarrow$",
    "∞" = "$\\infty$",
    "±" = "$\\pm$",
    "≤" = "$\\leq",
    "≥" = "$\\geq"
  )

  if (show) return(substitutions)

  if (format == "html") return(char)

  if (char %in% names(substitutions)) substitutions[[char]]
  else "[Character not in substitutions list for latex]"
}

#' @export
sds_tilde <- function(width = 5) sds_image("images/tilde-small.png", width = width)
#' @export
sds_leftarrow <- function() sds_character("←")
#' @export
sds_rightarrow <- function() sds_character("➔")

