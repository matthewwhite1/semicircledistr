#' Wigner Semicircle Distribution
#'
#' The Wigner Semicircle Distribution
#'
#' Density, distribution function, quantile function, and random generation for the semicircle distribution with parameters radius `R` and shift `a`.
#'
#' This distribution is used to model random variables that follow the shape of a semicircle.
#'
#' @name semicircle
#' @usage
#' dsemicircle(x, R, a = 0)
#' psemicircle(x, R, a = 0)
#' qsemicircle(p, R, a = 0)
#' rsemicircle(n, R, a = 0)
#'
#' @param x A numeric vector of quantiles.
#' @param R The radius of the semicircle (positive number).
#' @param a The shift parameter (default is 0).
#' @param p A numeric vector of probabilities (for \code{qsemicircle}).
#' @param n The number of random samples to generate (for \code{rsemicircle}).
#'
#' @details
#' The semicircle distribution is defined over the interval \eqn{[a - R, a + R]}, where
#' `R` is the radius and `a` is the shift. The probability density function is:
#'
#' \deqn{f(x) = \frac{2}{\pi R^2} \sqrt{R^2 - (x - a)^2},}
#' for \eqn{|x - a| \leq R}, and 0 otherwise.
#'
#' The cumulative distribution function is the integral of the density function.
#'
#' The quantile function gives the smallest value `x` such that the cumulative probability
#' `F(x)` is greater than or equal to a given probability `p`.
#'
#' @return
#' \describe{
#'   \item{\code{dsemicircle}}{Returns the density at each quantile.}
#'   \item{\code{psemicircle}}{Returns the cumulative probability at each quantile.}
#'   \item{\code{qsemicircle}}{Returns the quantiles corresponding to each probability.}
#'   \item{\code{rsemicircle}}{Returns random samples from the semicircle distribution.}
#' }
#'
#' @seealso \code{\link{dsemicircle}}, \code{\link{psemicircle}}, \code{\link{qsemicircle}}, \code{\link{rsemicircle}}
#'
#' @examples
#' # Compute the density at x = 0 for a semicircle with radius 1
#' dsemicircle(0, R = 1)
#'
#' # Compute the cumulative probability at x = 0 for a semicircle with radius 1
#' psemicircle(0, R = 1)
#'
#' # Compute the quantile for probability p = 0.75 for a semicircle with radius 1
#' qsemicircle(0.75, R = 1)
#'
#' # Generate 1000 random samples from a semicircle with radius 1
#' random_samples <- rsemicircle(1000, R = 1)
#' hist(random_samples, breaks = 30, main = "Random Samples from Semicircle Distribution", xlab = "Value", ylab = "Frequency")
#'
#' @references
#' \url{https://en.wikipedia.org/wiki/Wigner_semicircle_distribution}
#'
#' @importFrom stats uniroot
NULL

#' @title Density of the Semicircle Distribution
#' @description Computes the density of the semicircle distribution at `x` given a radius `R` and shift `a`.
#' @param x A numeric vector of quantiles.
#' @param R The radius of the semicircle.
#' @param a The shift parameter (default is 0).
#' @return A numeric vector with the density values for each input value of `x`.
#' @examples
#' dsemicircle(0, R = 1)
#' dsemicircle(c(0, 0.5, 1), R = 1)
#' @seealso \code{\link{semicircle}} for the full documentation on the Wigner semicircle distribution.
#' @export
dsemicircle <- function(x, R, a = 0) {
  if (!is.numeric(x)) {
    stop("x must be numeric.")
  }
  if (R <= 0) {
    stop("R must be positive.")
  }
  if (!is.numeric(a)) {
    stop("a must be numeric.")
  }
  ifelse(abs(x - a) > R, 0, (2 / (pi * R^2)) * sqrt(R^2 - (x - a)^2))
}

#' @title Cumulative Probability of the Semicircle Distribution
#' @description Computes the cumulative probability for the semicircle distribution at `x`.
#' @param x A numeric vector of quantiles.
#' @param R The radius of the semicircle.
#' @param a The shift parameter (default is 0).
#' @return A numeric vector with the cumulative probability values for each input value of `x`.
#' @examples
#' psemicircle(0, R = 1)
#' psemicircle(c(0, 0.5, 1), R = 1)
#' @seealso \code{\link{semicircle}} for the full documentation on the Wigner semicircle distribution.
#' @export
psemicircle <- function(x, R, a = 0) {
  if (!is.numeric(x)) {
    stop("x must be numeric.")
  }
  if (R <= 0) {
    stop("R must be positive.")
  }
  if (!is.numeric(a)) {
    stop("a must be numeric.")
  }
  result <- numeric(length(x))
  for (i in 1:length(x)) {
    val <- x[i]
    if (abs(val - a) > R) {
      stop("x must be within radius.")
    }
    result[i] <- 0.5 + (val * sqrt(R^2 - (val - a)^2)) / (pi * R^2) + asin((val - a) / R) / pi
  }
  return(result)
}

#' @title Quantiles of the Semicircle Distribution
#' @description Computes the quantile corresponding to the probability `p` for the semicircle distribution.
#' @param p A numeric vector of probabilities.
#' @param R The radius of the semicircle.
#' @param a The shift parameter (default is 0).
#' @return A numeric vector with the quantiles corresponding to the probabilities `p`.
#' @examples
#' qsemicircle(0.5, R = 1)
#' qsemicircle(c(0.1, 0.5, 0.9), R = 1)
#' @seealso \code{\link{semicircle}} for the full documentation on the Wigner semicircle distribution.
#' @export
qsemicircle <- function(p, R, a = 0) {
  if (!is.numeric(p)) {
    stop("x must be numeric.")
  }
  if (R <= 0) {
    stop("R must be positive.")
  }
  if (!is.numeric(a)) {
    stop("a must be numeric.")
  }
  quantile_fn <- function(prob) {
    sapply(prob, function(pi) {
      if (pi == 0) return(a - R)
      if (pi == 1) return(a + R)
      uniroot(function(x) psemicircle(x, R, a) - pi,
              lower = a - R, upper = a + R)$root
    })
  }
  quantile_fn(p)
}

#' @title Random Samples from the Semicircle Distribution
#' @description Generates `n` random samples from the semicircle distribution with radius `R` and shift `a`.
#' @param n The number of random samples to generate.
#' @param R The radius of the semicircle.
#' @param a The shift parameter (default is 0).
#' @return A numeric vector with `n` random samples from the semicircle distribution.
#' @examples
#' rsemicircle(10, R = 1)
#' rsemicircle(5, R = 1)
#' @seealso \code{\link{semicircle}} for the full documentation on the Wigner semicircle distribution.
#' @export
rsemicircle <- function(n, R, a = 0) {
  if (!is.numeric(n)) {
    stop("x must be numeric.")
  }
  if (R <= 0) {
    stop("R must be positive.")
  }
  if (!is.numeric(a)) {
    stop("a must be numeric.")
  }
  u <- runif(n)  # generate n uniform values between 0 and 1
  qsemicircle(u, R, a)  # apply the inverse CDF (quantile function)
}
