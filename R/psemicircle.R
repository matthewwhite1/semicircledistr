#' Semicircle Distribution Cumulative Density Function (CDF)
#'
#' This function computes the cumulative density function (CDF) of the semicircle distribution with a given radius \eqn{R}.
#'
#' @param x A numeric value representing the point at which the CDF is evaluated. It must lie in the range \eqn{[-R, R]}.
#' @param R A positive numeric value representing the radius parameter of the semicircle distribution.
#'
#' @return A numeric value representing the CDF of the semicircle distribution at point `x`.
#'
#' @examples
#' psemicircle(0, 1)   # Should return 0.5
#' psemicircle(-1, 1)  # Should return 0
#' psemicircle(1.5, 1) # Should return 0 (outside the range)
#'
#' @export
psemicircle <- function(x, R) {
  if (R <= 0) {
    stop("R must be positive.")
  }

  result <- numeric(length(x))

  for (i in 1:length(x)) {
    val <- x[i]
    if (abs(val) > R) {
      stop("x must be within radius.")
    }

    result[i] <- 0.5 + (val * sqrt(R^2 - val^2)) / (pi * R^2) + asin(val/R)/pi
  }

  return(result)
}
