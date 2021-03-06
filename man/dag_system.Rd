% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulation.R
\name{dag_system}
\alias{dag_system}
\title{Specify and simulate data from structural equation model}
\usage{
dag_system(..., seed = NULL)
}
\arguments{
\item{...}{Formulas specifying the model.}

\item{seed}{an optional random seed for use in \code{set.seed()}.}

\item{starter}{an optional data frame defining exogenous values of the variables in the formulas.}
}
\description{
Create and run structural equation model using formulas for each node.
}
\details{
There cannot be any cycles in the DAG (as the name DAG indicates.)
You can use \code{uniform()}, \code{gaussian()}, \code{discrete()}, or \code{toss_up} as random inputs. They correspond
respectively to \code{runif}, \code{rnorm}, \code{sample}, and Bernouilli trials.
}
\examples{
dag <- dag_system(A ~ uniform(), B ~ 3 + 10*A)
dag_simulate(dag, n = 5)
}
