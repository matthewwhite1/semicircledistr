#' Wigner Semicircle Distribution
#'
#' The Wigner Semicircle Distribution
#'
#' Density, distribution function, quantile function, and random generation for the semicircle distribution with parameters radius `R` and shift `a`.
#'
#' This distribution is used to model random variables that follow the shape of a semicircle.
#'
#' @name semicircle
#' @aliases dsemicircle psemicircle qsemicircle rsemicircle
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
#' @examples
#' # Compute the density at x = 0 for a semicircle with radius 1
#' dsemicircle(0, R = 1)
#' # Compute the density for a few x values for a semicircle with radius 2
#' # shifted 2 to the right
#' dsemicircle(c(2, 3, 4), R = 2, a = 2)
#'
#' # Compute the cumulative probability at x = 0 for a semicircle with radius 1
#' psemicircle(0, R = 1)
#' # Compute the cumulative probability for a few x values for a semicircle with
#' # radius 2 shifted 2 to the right
#' psemicircle(c(2, 3, 4), R = 2, a = 2)
#'
#' # Compute the quantile for probability p = 0.75 for a semicircle with radius 1
#' qsemicircle(0.75, R = 1)
#' # Compute the quantile for a few probabilities for a semicircle with radius 2
#' # shifted 2 to the right
#' qsemicircle(c(0.25, 0.5, 0.75), R = 2, a = 2)
#'
#' # Generate 1000 random samples from a semicircle with radius 1
#' random_samples <- rsemicircle(1000, R = 1)
#' hist(random_samples,
#'   breaks = 30, main = "Random Samples from Semicircle Distribution",
#'   xlab = "Value", ylab = "Frequency"
#' )
#' # Generate 1000 random samples from a semicircle with radius 2 shifted 2
#' # to the right
#' random_samples <- rsemicircle(1000, R = 2, a = 2)
#' hist(random_samples,
#'   breaks = 30, main = "Random Samples from Semicircle Distribution",
#'   xlab = "Value", ylab = "Frequency"
#' )
#'
#' @references
#' \url{https://en.wikipedia.org/wiki/Wigner_semicircle_distribution}
#'
#' @importFrom stats uniroot
NULL

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
    val <- x[i] - a
    if (abs(val) > R) {
      stop("x must be within radius.")
    }
    result[i] <- 0.5 + (val * sqrt(R^2 - val^2)) / (pi * R^2) + asin(val / R) / pi
  }
  return(result)
}

#' @export
qsemicircle <- function(p, R, a = 0) {
  if (!is.numeric(p) || any(p < 0) || any(p > 1)) {
    stop("p must be between 0 and 1.")
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

#' @export
rsemicircle <- function(n, R, a = 0) {
  if (!is.numeric(n) || n != round(n)) {
    stop("n must be an integer.")
  }
  if (R <= 0) {
    stop("R must be positive.")
  }
  if (!is.numeric(a)) {
    stop("a must be numeric.")
  }
  u <- stats::runif(n)  # generate n uniform values between 0 and 1
  qsemicircle(u, R, a)  # apply the inverse CDF (quantile function)
}
