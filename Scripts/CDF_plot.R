################################################################################
## This script generates a CDF plot based on the Wikipedia plot below.
## https://en.wikipedia.org/wiki/Wigner_semicircle_distribution
################################################################################

colors <- c("red", "orange", "gold", "green", "cyan", "blue")

radii <- c(0.25, 0.5, 1, 1.5, 2, 3)
i <- 1
for (r in radii) {
  x <- seq(-r, r, length.out=1000)
  cdf <- sort(psemicircle(x, r))

  if (i == 1) {
    plot(x,
         cdf,
         type="l",
         xlim=c(-3,3),
         xlab="R",
         col=colors[i],
         main="Semicircle distribution CDF")
  } else {
    lines(x, cdf, col=colors[i])
  }

  i <- i + 1
}
legend("topleft", as.character(radii), fill=colors)
