rsemicircle <- function(n, R) {
  if (R <= 0) {
    stop("R must be positive.")
  }
  if (n != round(n)) {
    stop("n must be an integer.")
  }
  if (n < 0) {
    stop("n must be positive")
  }

  ## TODO compute random of distribution (i.e. using runif and inverse cdf)
}
