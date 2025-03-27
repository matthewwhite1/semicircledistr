#' Semicircle Distribution Probability Density Function (PDF)
#'
#' This function computes the probability density function (PDF) of the semicircle distribution with a given radius \( R \).
#'
#' @param x A numeric value representing the point at which the PDF is evaluated. It must lie in the range \([-R, R]\).
#' @param R A positive numeric value representing the radius parameter of the semicircle distribution.
#'
#' @return A numeric value representing the PDF of the semicircle distribution at point `x`.
#' @details
#' The semicircle distribution is defined as:
#' \deqn{f(x) = \frac{2}{\pi R^2} \sqrt{R^2 - x^2}} for \(-R \leq x \leq R\),
#' and \deqn{f(x) = 0} for \(|x| > R\).
#'
#' @examples
#' dsemicircle(0, 1)   # Should return 2/pi
#' dsemicircle(0.5, 1) # Should return a positive value
#' dsemicircle(1, 1)   # Should return 0
#' dsemicircle(1.5, 1) # Should return 0 (outside the range)
#'
#' @export
dsemicircle <- function(x, R) {
  if (R <= 0) {
    stop("R must be positive.")
  }
  ifelse(abs(x) > R, 0, (2 / (pi * R^2)) * sqrt(R^2 - x^2))
}

