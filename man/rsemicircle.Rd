% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/semicircle.R
\name{rsemicircle}
\alias{rsemicircle}
\title{Random Samples from the Semicircle Distribution}
\usage{
rsemicircle(n, R, a = 0)
}
\arguments{
\item{n}{The number of random samples to generate.}

\item{R}{The radius of the semicircle.}

\item{a}{The shift parameter (default is 0).}
}
\value{
A numeric vector with \code{n} random samples from the semicircle distribution.
}
\description{
Generates \code{n} random samples from the semicircle distribution with radius \code{R} and shift \code{a}.
}
\examples{
rsemicircle(10, R = 1)
rsemicircle(5, R = 1)
}
\seealso{
\code{\link{semicircle}} for the full documentation on the Wigner semicircle distribution.
}
