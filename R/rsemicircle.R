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

  ## I don't think there is a closed form solution.
  ## The alternative is to generate random points within rectangle enclosing PDF
  ## and reject until we get one inside the distribution.

  # get the height of the enclosing rectangle
  height <- dsemicircle(0, R)
  result <- numeric(n)

  i <- 1
  while (i <= n) {
    x <- runif(1, -R, R)
    y <- runif(1, 0, height)
    if (y <= dsemicircle(x, R)) {
      result[i] <- x
      i <- i + 1
    }
  }

  return(result)
}
