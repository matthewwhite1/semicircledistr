################################################################################
## This script generates a CDF plot based on the Wikipedia plot below.
## https://en.wikipedia.org/wiki/Wigner_semicircle_distribution
################################################################################

colors <- hcl.colors(6, "Dark 3")

radii <- c(0.25, 0.5, 1, 1.5, 2, 3)
i <- 1
lwd <- 3
for (r in radii) {
  x <- seq(-r, r, length.out=1000)
  cdf <- sort(psemicircle(x, r))

  if (i == 1) {
    plot(x,
         cdf,
         type="l",
         xlim=c(-3,3),
         xlab="R",
         ylab="CDF",
         col=colors[i],
         main="Semicircle Cumulative Distribution Function",
         lwd=lwd)
  } else {
    lines(x, cdf, col=colors[i], lwd=lwd)
  }

  i <- i + 1
}

legend("topleft", as.character(radii), fill=colors, title="Radius")

## Uncomment to export image
## dev.print(png, "cdf.png", width=1440)
