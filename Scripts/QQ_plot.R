################################################################################
## This script generates a QQ plot comparing rsemicircle with qsemicircle
################################################################################

jpeg("Plots/QQ_plot.jpeg", width = 600, height = 600)

## par(mfrow = c(3, 2))
## radii <- seq(.5,3,.5)
par(mfrow = c(2, 1))
radii <- c(0.75, 2)
for (i in radii) {
  random <- sort(rsemicircle(1000, i))
  theoretical <- qsemicircle(ppoints(1000), i)
  lims = c(-i, i)
  ats = seq(-i, i, i / 2)
  qqplot(theoretical,
         random,
         main=paste("QQ Plot of rsemicircle vs theoretical for R = ", i),
         xlab="Theoretical",
         ylab="rsemicircle",
         xlim=lims,
         ylim=lims,
         at=ats,
         cex=2)
  abline(0,1, col="red", lwd=2)
}

dev.off()

## Uncomment to export image
## dev.print(png, "rsemicircle-qq.png", width=720, height=1440)
