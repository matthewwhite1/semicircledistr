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
