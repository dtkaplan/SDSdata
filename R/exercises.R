#' Insert an exercise from a file
#'
#' Each exercise is contained in its own file, with a unique ID. This function
#' reads the file for that ID, knits the contents, and returns the knitted contents.
#' Typically this will be used to insert the exercise into an Rmd file.
#' If not specified, argument `show_answer` will be read from `options("show_answer")`.
#'
#' @param id the unique ID of the exercise file. Don't include the file type suffix ".Rmd" in the id.
#' @param directory the directory where the exercise file is to be found
#' @param verbose Include the YAML information
#' @param prob_name Character string naming the problem, e.g. `"Prob 1.3"`
#' @param show_answer if TRUE, include the answer comments from the file.
#'
#' @details
#' When output is in html, use the `answer-fragment` class in CSS to format
#' the answers.
#'
#' @examples
#' the_testing_dir <- system.file("Test_exercises", package = "SDSdata")
#' include_exercise("beech-run-mug", directory = the_testing_dir, format = "latex")
#'
#' @export
include_exercise <- function(id, show_answer = getOption("show_exercise", TRUE),
                             verbose = TRUE,
                             directory = "Exercises",
                             prob_name = "Problem XX",
                             format = ifelse(knitr::is_latex_output(), "latex", "html")) {
  content <- readLines(paste0(directory, "/", id, ".Rmd"))
  yaml_stuff <- get_yaml_header(content)
  content <- kill_yaml_header(content)
  if ( ! show_answer) { # delete the answer comments}
    content <- gsub("-A-.+$", "", content, perl = TRUE)
    content <- kill_answer_block(content)
  }
  # replace the answer markup with the appropriate latex/html constructs.
  inline_pattern <- "-A-([[:space:]]*)(.*)"
  answer_start_pattern <- "<\\!\\-\\-answer\\-start\\-\\->"
  answer_end_pattern <- "<\\!\\-\\-answer\\-end\\-\\->"
  # Fill in the problem name.
  content <- gsub("(\\(ref:.*\\)) Exercise in file .*$",
                  paste("\\1", prob_name),
                  content, perl = TRUE)

  # prob_markup <- glue::glue("**{prob_name}** ")
  # using prob_name instead of prob_markup
  content <-
    paste(
      gsub("TITLE GOES HERE:?", prob_name, content),
      collapse = "\n")

  content <- knitr::knit(text = content, rmarkdown::md_document())



  if (format == "latex") {
    # Can't use HTML markup because it will be deleted
    content <- gsub(inline_pattern,
                    "Ans: [\\2] ",
                    #"INLINE-ANSWER-START\\2INLINE-ANSWER-END",
                    content, perl = TRUE)
    content <- gsub(answer_start_pattern,
                    #"\\\\begin{quotation}\\\\em ",
                    "BLOCK-ANSWER-START",
                    content)
    content <- gsub(answer_end_pattern,
                    #"\\\\end{quotation}",
                    "BLOCK-ANSWER-END",
                    content)
  }  else if (format == "html") {
    content <- gsub("-A-([[:space:]]*)(.*)$",
                    "<span class = 'answer-fragment'> \\2 </span>",
                    content, perl = TRUE)
    content <- gsub(answer_start_pattern,
                    "<div class='answer-fragment'>",
                    content, fixed = TRUE)

    content <- gsub(answer_end_pattern, "</div>", content,
                    fixed = TRUE)
  } else {
    stop("Unknown output format for problem file.")
  }



    # if (format == "html") {
    #   res <- knitr::knit(text = content, rmarkdown::md_document())
    #   writeLines(res, con = "testing.md")
    # } else if (format == "latex") {
    #   writeLines(content, con = "testing.Rmd")
    #   res <- knitr::knit("testing.Rmd", rmarkdown::latex_fragment(keep_tex = TRUE))
    # }

  if (verbose) {
    yaml_stuff <- gsub("\\[|\\]", "", yaml_stuff)
    keepers <- grep("id|topics|chapter|version|depends", yaml_stuff)
    yaml_addon <- paste0(paste0("* ", yaml_stuff[keepers]), collapse = "\n")

    content <- paste0(content, "\n\n", yaml_addon)
  }


  return(paste(content, "\n\n"))

  #
  # res
}

kill_answer_block <- function(str) {
   starts <- grep("<\\!\\-\\-answer\\-start\\-\\->", str)
   if (length(starts) == 0) return(str)
   ends <- grep("<\\!\\-\\-answer\\-end\\-\\->", str)
   if (length(starts) != length(ends) || any(starts >= ends))
     stop("Unmatched answer-block delimiter.")
   line_numbers <- integer(0)
   for (k in 1:length(starts)) {
     line_numbers <- c(line_numbers, starts[k]:ends[k])
   }
   str[-line_numbers]
}

new_exercise_template <- function() {
  exercise_id <- make_random_id()
  contents <- readLines(system.file("exercise_template_1.Rmd", package = "SDSdata"))
  contents <- gsub("date:", paste("date:", Sys.Date()), contents)
  contents <- gsub("id:", paste("id:", exercise_id), contents)
  contents <- gsub("XXAXX", exercise_id, contents)
  res <- paste(contents,  collapse = "\n")


  attributes(res) <- list(file_name = paste0(exercise_id, ".Rmd"))
  res
}
get_yaml_header <- function(txt) {
  dashes <- which(grepl("^---$", txt))
  if (length(dashes) == 2 && dashes[1] == 1) return(txt[2:(dashes[2]-1)])
  else if (length(dashes) == 0) return(NULL)
  else stop("Yaml must be at the top of the file, delimited by a pair of lines consisting only of '---' on line 1 and after the yaml content.")
}
kill_yaml_header <- function(txt) {
  dashes <- which(grepl("^---$", txt))
  if (length(dashes) == 2 && dashes[1] == 1)
  return(txt[(dashes[2]+1):length(txt)])
  else if (length(dashes) == 0) return(txt)
  else stop("Yaml must be at the top of the file, delimited by a pair of lines consisting only of '---' on line 1 and after the yaml content.")
}

animal_words <- c("ant", "bear", "bee", "bird", "camel", "cat", "cheetah", "chicken",
  "cow", "crocodile", "deer", "dog", "dolphin", "duck", "eagle",
  "elephant", "fish", "fly", "fox", "frog", "giraffe", "goat", "goldfish",
  "hamster",  "horse", "kangaroo", "kitten", "lamb", "lion", "lobster",
  "monkey", "octopus", "owl", "panda", "pig", "puppy", "rabbit", "rat",
  "seal", "shark", "sheep", "snail", "snake", "spider", "squirrel", "tiger", "turtle",
  "wolf", "zebra", "calf", "doe", "buck", "girl", "boy", "child", "pine", "birch", "maple", "elm", "larch",
  "aspen", "fir", "spruce", "walnut", "oak", "ash", "beech", "falcon")

verb_words <- c(
  "beat", "become", "begin", "bend","bet", "bid", "bite",
  "blow",  "break", "bring", "build", "burn", "buy",  "catch", "chew", "choose",
  "come",  "cost", "cut", "dig","dive",
  "do","draw",  "dream",  "drive",  "drink",    "eat",   "fall",  "feel", "fight",
  "find", "fly", "forget", "forgive", "freeze", "get", "give", "go",
  "grow", "hang",  "have",  "hear",   "hide",    "hit",
  "hold",  "hurt",  "keep",  "know",  "iron", "jump", "light",  "lay",  "lead","leave",  "lend", "let", "lie", "lose",
  "make", "mean",  "meet", "pay","put", "read","ride", "ring","rise",  "run","say",
  "see",  "sell","send",  "show",   "shut",  "sing",
  "sit", "sleep",  "speak", "spend", "stand",   "swim",  "take", "talk", "teach",
  "tear",  "tell", "think",  "throw", "toss", "understand", "walk",  "wake",  "wear",   "win", "write"
  )

house_words <- c(
  "blanket", "clock", "candy", "plant", "cotton", "linen", "map", "knife", "lamp", "magnet", "mug", "glasses",
  "radio", "rug", "saucer", "saw", "shirt", "sheet", "shoe", "socks", "pants", "dress", "sofa", "painting",
  "pen", "pencil", "piano", "plate", "bowl", "table", "chair", "vase", "stove", "oven", "ring", "door",
  "window", "drawer", "bed", "futon", "pot", "book", "bottle", "knob", "coat", "jacket", "dish", "fork", "spoon", "scarf", "gloves",
  "roof", "room", "closet", "kitchen", "kayak", "canoe")

make_random_id <- function(){
  paste(
    sample(animal_words, 1),
    sample(verb_words, 1),
    sample(house_words, 1),
    sep = "-"
  )
}
