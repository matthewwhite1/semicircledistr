% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/semicircle.R
\name{psemicircle}
\alias{psemicircle}
\title{Cumulative Probability of the Semicircle Distribution}
\usage{
psemicircle(x, R, a = 0)
}
\arguments{
\item{x}{A numeric vector of quantiles.}

\item{R}{The radius of the semicircle.}

\item{a}{The shift parameter (default is 0).}
}
\value{
A numeric vector with the cumulative probability values for each input value of \code{x}.
}
\description{
Computes the cumulative probability for the semicircle distribution at \code{x}.
}
\examples{
psemicircle(0, R = 1)
psemicircle(c(0, 0.5, 1), R = 1)
}
\seealso{
\code{\link{semicircle}} for the full documentation on the Wigner semicircle distribution.
}
