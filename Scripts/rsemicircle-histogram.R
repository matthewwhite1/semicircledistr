## Generates histograms to demonstrate rsemicircle

par(mfrow=c(2,2))
lwd <- 3

radii <- c(0.5, 1, 2, 4)
nvals <- 10000
for (r in radii) {
  vals <- rsemicircle(nvals, r)
  hist(vals, freq=FALSE, breaks=30,
       main=paste("Histogram of rsemicircle with R =", r, "and n =", prettyNum(nvals, big.mark = ",")),
       xlab="R", ylab="Density")

  xvals <- seq(-r, r, r / nvals / 2)
  pdfv <- dsemicircle(xvals, r)
  lines(xvals, pdfv, col="red", lwd=lwd)
  legend("topleft", "Theoretical", fill="red")
}

## Uncomment to export image
## dev.print(png, "rsemicircle.png", width=1440)
