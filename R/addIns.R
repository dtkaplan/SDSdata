
sds_exercise <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  where <- rstudioapi::primary_selection(context)
  rstudioapi::insertText(where$range,
                         new_exercise_template(),
                         context$id)
}


