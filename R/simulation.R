#' Specify and simulate data from structural equation model
#'
#' Create and run structural equation model using formulas for each node.
#'
#' @param starter an optional data frame defining exogenous values of the variables in the formulas.
#' @param ... Formulas specifying the model.
#' @param seed an optional random seed for use in `set.seed()`.
#'
#' @details There cannot be any cycles in the DAG (as the name DAG indicates.)
#' You can use `uniform()`, `gaussian()`, `discrete()`, or `toss_up` as random inputs. They correspond
#' respectively to `runif`, `rnorm`, `sample`, and Bernouilli trials.
#'
#' @examples
#' dag <- dag_system(A ~ uniform(), B ~ 3 + 10*A)
#' dag_simulate(dag, n = 5)

#' @export
dag_system <- function(..., seed = NULL) {
  if ( !is.null(seed)) set.seed(seed)
  # Nodes
  nodes <- list(...)
  # are they all formulas?
  res <- sapply(nodes, FUN = function(x) inherits(x, "formula"))
  if ( ! all(res)) stop("All arguments must be formulas.")
  # do they all have a left-hand side
  res <- sapply(nodes, FUN = function(x) length(x) == 3 && is.name(rlang::f_lhs(x)))
  if ( ! all(res)) stop("All formulas must be two sided, e.g. a ~ b, not just ~ b. The left hand side must be a name.")
  # extract the names of the nodes: the LHS for the formula
  node_names <- sapply(nodes, FUN = function(x) as.character(as.name(rlang::f_lhs(x))))
  names(nodes) <- node_names # label each formula
  # any repeats?
  repeats <- duplicated(node_names)
  if (any(repeats)) stop("Arguments must have unique names on LHS of formula. You've repeated",
                         paste(repeats[duplicated], collapse = ", "))
  # create a list of dependencies
  depends_on <- lapply(nodes, FUN = function(x) intersect(node_names, all.vars(rlang::f_rhs(x)) ))
  names(depends_on) <- node_names
  # does any node depend on itself? Stop if it does.
  res <- purrr::map2_lgl(depends_on, names(depends_on), function(x, y) y %in% x)
  if (any(unlist(res))) stop("Nodes cannot depend on themselves. You have ",
                             paste( lapply(nodes[res], capture.output) , collapse = ", "))

  right_order <- dag_depends_order(depends_on)

  nodes <- nodes[right_order]
  class(nodes) <- "sds_dag" # for other functions to make sure the formulas have been processed.

  nodes
}

#' @export
dag_simulate <- function(dag, n = 5, starter = NULL) {
  if ( ! inherits(dag, "sds_dag"))
    stop("Requires a dag as produced by dag_system().")

  # Create a data frame with the right number of rows.
  Res <- if (is.null(starter))
    data.frame(..starter.. = rep("", n), stringsAsFactors = FALSE)
  else
    starter

  # Some random number generators that know what n should be
  # uniform() and gaussian() have unit variance
  uniform <- function(min = -1.732, max = 1.732) runif(nrow(Res), min = min, max = max)
  gaussian <- function(sd = 1, mean = 0) rnorm(nrow(Res), mean = mean, sd = sd)
  discrete <- function(levels, prob = NULL)
    sample(levels, nrow(Res), replace = TRUE, prob = prob)
  toss_up <- function(levels = c("H", "T"), prob = 0.5, log_odds = NULL) {
    if (!is.null(log_odds)) prob <- exp(log_odds) / (1 + exp(log_odds))
    tmp <- as.integer(1 + runif(nrow(Res)) <= prob)
    levels[tmp]
  }

  vnames <- names(dag)

  for (k in 1:length(dag)) {
    if (vnames[k] %in% names(Res)) next

    expression <- rlang::f_rhs(dag[[k]])
    tmp <- rlang::eval_tidy(expression, data = Res)
    Res[[vnames[k]]] <- tmp
  }

  Res$..starter.. <- NULL

  Res
}



dag_depends_order <- function(nodes) {
  names(depends_order_helper(nodes))
}
depends_order_helper <- function(nodes) {
  if (length(nodes) == 0) return(NULL)
  if (length(nodes) == 1) return(nodes)
  # Find one that doesn't depend on any others
  counts <- purrr::map_int(nodes, length)
  if (!any(counts==0)) stop("There's a cycle or a missing node that's depended on by others.")
  first_ones <- which(counts == 0)
  at_head <- nodes[first_ones]
  names_at_head <- names(at_head)
  at_tail <- nodes[ - first_ones]
  if (length(at_tail) > 1) {
    # delete the dependencies on the head in the tail ones
    for (k in 1:length(at_tail)) {
      at_tail[[k]] <- setdiff(at_tail[[k]], names_at_head)
    }
  }
  at_tail <- depends_order_helper(at_tail)

  c(at_head, at_tail)

}
