#' Insert an exercise from a file
#'
#' Each exercise is contained in its own file, with a unique ID. This function
#' reads the file for that ID, knits the contents, and returns the knitted contents.
#' Typically this will be used to insert the exercise into an Rmd file.
#'
#' @params id the unique ID of the exercise file
#' @directory the directory where the exercise file is to be found
#' @show_answer if true, include the answer comments from the file
#'
#' @export
include_exercise <- function(id, show_answer = TRUE, directory = "Exercises/") {
  content <- readLines(paste0(directory, id, ".Rmd"))
  yaml_stuff <- get_yaml_header(content)
  content <- kill_yaml_header(content)
  if ( ! show_answer) { # delete the answer comments}
  content <- gsub("-A-.+$", "", content, perl = TRUE)
  } else {
  content <- gsub("-A-([[:space:]]*)(.*)$",
  ">> \\2",
  content, perl = TRUE)
  }
  knitr::knit(text = content)
}

new_exercise_template <- function() {
  contents <- readLines(system.file("exercise_template_1.Rmd", package = "SDSdata"))
  contents <- gsub("date:", paste("date:", Sys.Date()), contents)
  contents <- gsub("id:", paste("id:", make_random_id()), contents)
  paste(contents,  collapse = "\n")

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
  "wolf", "zebra", "calf", "doe", "buck")

verb_words <- c(
  "beat", "become", "begin", "bend","bet", "bid", "bite",
  "blow",  "break", "bring", "build", "burn", "buy",  "catch", "choose",
  "come",  "cost", "cut", "dig","dive",
  "do","draw",  "dream",  "drive",  "drink",    "eat",   "fall",  "feel", "fight",
  "find", "fly", "forget", "forgive", "freeze", "get", "give", "go",
  "grow", "hang",  "have",  "hear",   "hide",    "hit",
  "hold",  "hurt",  "keep",  "know",  "iron", "light",  "lay",  "lead","leave",  "lend", "let", "lie", "lose",
  "make", "mean",  "meet", "pay","put", "read","ride", "ring","rise",    "run","say",
  "see",  "sell","send",  "show",   "shut",  "sing",
  "sit", "sleep",  "speak", "spend", "stand",   "swim",  "take",  "teach",
  "tear",  "tell", "think",  "throw", "understand",   "wake",  "wear",   "win", "write"
  )

house_words <- c(
  "blanket", "clock", "plant", "cotton", "linen", "map", "knife", "lamp", "magnet", "mug", "glasses",
  "radio", "rug", "saucer", "saw", "shirt", "sheet", "shoe", "socks", "pants", "dress", "sofa", "painting",
  "pen", "pencil", "piano", "plate", "bowl", "table", "chair", "vase", "stove", "oven", "ring", "door", "window", "drawer")

make_random_id <- function(){
  paste(
    sample(animal_words, 1),
    sample(verb_words, 1),
    sample(house_words, 1),
    sep = "-"
  )
}
