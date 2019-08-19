#' Format data frames nicely for SDS book
#'
#' Creates HTML or Latex markup with a footnote showing how many rows
#' there are in total.
#'
#' @param data the data frame to be displayed
#' @param show_n how many lines to display (default 6. Use `Inf` for all rows.)
#' @param nrows an integer specifying how many rows the from the data frame should be displayed in the footnote. Set to `Inf` to suppress footnote.
#' @param row.names whether to show the rownames in the table (def: FALSE)
#' @param footnote character string to be placed at the bottom of the table in place of the usual "... and so on for __ rows."
#' @param format either `"html"` or `"latex"`. Default will use `knitr::is_latex_output()` to decide.
#' @param caption string to pass as a caption to the table
#' @param align optional column alignment instructions passed to `kable`
#' @param in_margin If TRUE, format table to go in margin for LaTeX Tufte-style layout. BUT UNFORTUNATELY, THIS
#' WORKS ONLY IN INLINE MODE, while htmlformats DON'T work in inline mode.
#' @param label reference label for bookdown, e.g. "my-table" to empower reference with tab:my-table". By
#' default, grabbed from chunk name.
#' @param ... additional arguments to `kableExtra::kable_styling()`, e.g. `"striped"`, `"hover"`
#'
#' @details `sds_table()` can access the knitr chunk label and the value of `in_margin`. Don't output
#' the value directly from the chunk. Instead, assign the output of `sds_table()` to a variable
#' and use an inline expression to insert that variable.


#' @examples
#' sds_table(mtcars, "striped", "hover")
#' sds_table(mtcars, show_n = 3, caption="Data about cars")
#' @export
sds_table <- function(data, show_n = 6L, nrows = nrow(data),
                      row.names = FALSE, footnote = NULL,
                      format=ifelse(knitr::is_latex_output(), "latex", "html"),
                      caption=NULL,
                      align = NULL,
                      in_margin = knitr::opts_current$get("in_margin"),
                      label = knitr::opts_current$get("label"),
                      ...) {
  if (is.null(in_margin)) in_margin <- FALSE
  # Save caption for later use if table is to be in marging
  save_caption <- NULL
  if (in_margin && format == "latex") {
    save_caption <- caption
    caption <- NULL
  }
  res <-
    knitr::kable(head(data, min(c(nrows, show_n))),
                 format = format, caption=caption, row.names = row.names, align = align) %>%
    kableExtra::kable_styling(full_width = FALSE, ...)

  if (is.null(footnote) && nrows > show_n) {
      footnote <- sprintf("... and so on for %s rows altogether.", prettyNum(nrows, scientific = FALSE, big.mark = ","))
  }
  res <- res %>%
      kableExtra::footnote(general_title = "", general = footnote)
  if (is.null(caption)) {
    # remove the float in latex and center properly
    res <- gsub("\\\\begin\\{table\\}\\[H\\]", "\\\\begin\\{center\\}", res)
    res <- gsub("\\\\end\\{table\\}", "\\\\end\\{center\\}", res)
    #res <- gsub("\\\\centering", "", res) # kill the centering
     # if (format == "latex")
     #   res <- paste0("{", res, "}", collapse = "\n") # keep the centering local.
  }
  if (in_margin) {
    if (format == "latex") {
      res <- gsub("\\\\begin\\{table\\}\\[H\\]", "", res)
      res <- gsub("\\\\end\\{table\\}", "", res)
      if (is.null(label)) label <- "bogus-label"
      res <- paste(sprintf("\\captionof{table}{\\label{tab:%s}%s}\\vspace{1em}",
                           label,
                           save_caption), res)
      return(margin_note(I(res)))
    } else if (format == "html") {
        # Haven't gotten marginal tables to work in html format
        return(res)
    } else {
      return(res)
    }
  }
  res
}

#' For pretty printing knitr tables
#'
#' @export
#'
nice_table <- function(x, options) {
  res <- do.call(SDSdata::sds_table,
                 list(data=x,
                      nrows=ifelse("nrow" %in% names(options),
                                   options$nrow, nrow(x)),
                      show_n=ifelse("show_n" %in% names(options),
                                    options$show_n, 6),
                      caption = options$caption,
                      in_margin = options$in_margin
                 )
  )
  knitr::asis_output(res) # so it prints as markup
}

# Only works within a document with knitr available
#'
#' @export
#'
use_nice_table <- function() {
  registerS3method("knit_print", "tbl", SDSdata::nice_table)
  registerS3method("knit_print", "tbl_df", SDSdata::nice_table)
  registerS3method("knit_print", "data.frame", SDSdata::nice_table)
}

#' Is the document in Tufte format?
#'
#' A kluge
#' since there's no official way to test during compilation)
#' @export

is_tufte_format <- function() {
  !is.null(knitr::opts_hooks$get("fig.margin"))
}

#' A margin note that will work in gitbook or tufte
#'
#' @export
margin_note <- function(text,  icon="[Click to see note.]") {
  if (is_tufte_format()){
    tufte::margin_note(text, icon=icon)
  } else {
    sprintf("^[%s]", text)
  }
}
