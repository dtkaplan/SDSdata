
sds_exercise <- function(directory = "Exercises") {
  # is there an Exercises directory?
  tmp <- list.dirs(path = directory)
  if (length(tmp) == 0) stop("No directory <", directory, "> in which to create the file.")

  while (TRUE) {
    doc_contents <- new_exercise_template()
    new_file_name <- paste(directory, attr(doc_contents, "file_name"), sep = "/")
    tmp <- list.files(path = new_file_name)
    if (length(tmp) == 0) { # clear to create the file
      writeLines(doc_contents, con = new_file_name)
      if (!rstudioapi::isAvailable())
        return()
      if (!rstudioapi::hasFun("navigateToFile"))
        return()
      rstudioapi::navigateToFile(new_file_name)
      break;
    }


  }


  # context <- rstudioapi::getActiveDocumentContext()
  # context$path <- full_name
  # where <- rstudioapi::primary_selection(context)
  # rstudioapi::insertText(where$range,
  #                        doc_contents,
  #                        context$id)
  #
}


