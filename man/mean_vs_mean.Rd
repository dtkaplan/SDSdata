% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mean_fun.R
\name{mean_vs_mean}
\alias{mean_vs_mean}
\title{Piecewise linear functions based on means and medians}
\usage{
mean_vs_mean(formula, data = parent.env(), stat_fun = mean)
}
\arguments{
\item{formula}{a formula  y ~ x}

\item{data}{a data frame containing the variables in the formula}

\item{stat_fun}{either \code{mean} or \code{median} or another function defining "midpoint"}
}
\description{
Approximate a linear fit by the line connecting the midpoints
of the lower half of the data and the upper half of the data
}
\examples{
mean_vs_mean(mpg ~ hp, data = mtcars)
}
