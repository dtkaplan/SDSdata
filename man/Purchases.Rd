% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Purchases.R
\docType{data}
\name{Purchases}
\alias{Purchases}
\title{Credit card transaction data}
\format{An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 74 rows and 6 columns.}
\usage{
Purchases
}
\description{
These are credit card transactions made between April and July, 2018 at
grocery stores and gas stations. They are used with permission of the purchaser(s),
whose identity is redacted for privacy reasons.
}
\details{
A data frame object with one row for each purchase
\itemize{
\item \code{type}: all the transactions were purchases
\item \code{date} the date the transaction occurred
\item \code{posted} the date the transaction was reported to the credit-card company
\item \code{amount}: the amount of the purchase in USD.
\item \code{merchant} string descripting the location
\item \code{merchant_type}: character string either grocery store or gasoline station
}
}
\keyword{datasets}
