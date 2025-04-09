################################################################################
## This script generates a QQ plot comparing rsemicircle with qsemicircle
################################################################################

par(mfrow = c(3, 2))
for (i in seq(.5,3,.5)) {
  random <- sort(rsemicircle(1000, i))
  theoretical <- qsemicircle(ppoints(1000), i)
  qqplot(random, theoretical, main=paste("QQ Plot of random results vs theoretical for R = ", i))
}
