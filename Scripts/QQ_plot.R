################################################################################
## This script generates a QQ plot comparing rsemicircle with qsemicircle
################################################################################

## par(mfrow = c(3, 2))
## radii <- seq(.5,3,.5)
par(mfrow = c(2, 1))
radii <- c(0.75, 2)
for (i in radii) {
  random <- sort(rsemicircle(1000, i))
  theoretical <- qsemicircle(ppoints(1000), i)
  qqplot(random, theoretical, main=paste("QQ Plot of rsemicircle vs theoretical for R = ", i), xlab="rsemicircle", ylab="Theoretical", cex=2)
  abline(0,1, col="red", lwd=2)
}

## Uncomment to export image
## dev.print(png, "rsemicircle-qq.png", width=720)
