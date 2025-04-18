################################################################################
# This script investigates the claim from Wikipedia that the semicircle
# distribution coincides with a scaled and shifted beta distribution.
#
# https://en.wikipedia.org/wiki/Wigner_semicircle_distribution
#
# "If Y is a beta-distributed random variable with parameters α = β = 3⁄2,
# then the random variable 2RY – R exhibits a Wigner semicircle distribution
# with radius R."
################################################################################

library(ggplot2)
library(gridExtra)

# Create random variable transformations
set.seed(1234)

R <- 2

# n = 1000
Y1 <- rbeta(1000, (3 / 2), (3 / 2))
U1 <- 2 * R * Y1 - R
U1_df <- data.frame(U1_vals = U1)

# n = 10000
Y2 <- rbeta(10000, (3 / 2), (3 / 2))
U2 <- 2 * R * Y2 - R
U2_df <- data.frame(U2_vals = U2)

# n = 100000
Y3 <- rbeta(100000, (3 / 2), (3 / 2))
U3 <- 2 * R * Y3 - R
U3_df <- data.frame(U3_vals = U3)

# Create histograms
g1 <- ggplot(U1_df, aes(U1_vals)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  scale_y_continuous("Density", breaks = seq(0, 0.4, by = 0.1), limits = c(0, 0.4)) +
  xlab("Transformed Beta Distribution Values for n = 1000")

g2 <- ggplot(U2_df, aes(U2_vals)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  scale_y_continuous("Density", breaks = seq(0, 0.4, by = 0.1), limits = c(0, 0.4)) +
  xlab("Transformed Beta Distribution Values for n = 10000")

g3 <- ggplot(U3_df, aes(U3_vals)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  scale_y_continuous("Density", breaks = seq(0, 0.4, by = 0.1), limits = c(0, 0.4)) +
  xlab("Transformed Beta Distribution Values for n = 100000")

jpeg("Plots/BetaTrans_NoCurve.jpeg", width = 600, height = 600)

grid.arrange(g1, g2, g3)

dev.off()

# Add semicircle distribution densities
g1 <- g1 +
  stat_function(fun = dsemicircle, args = R, lwd = 1.5, color = "red")

g2 <- g2 +
  stat_function(fun = dsemicircle, args = R, lwd = 1.5, color = "red")

g3 <- g3 +
  stat_function(fun = dsemicircle, args = R, lwd = 1.5, color = "red")

jpeg("Plots/BetaTrans.jpeg", width = 600, height = 600)

grid.arrange(g1, g2, g3)

dev.off()

jpeg("Plots/BetaTrans_QQ.jpeg", width = 600, height = 600)

# Check with a QQ plot
par(mfrow = c(3, 1))

theoretical1 <- qsemicircle(ppoints(1000), R)
qqplot(U1, theoretical1, main = "QQ Plot of Shifted Beta vs Theoretical Semicircle for n = 1000",
       xlab = "Shifted Beta", ylab = "Theoretical Semicircle", cex = 2)
abline(a = 0, b = 1, col = "red")

theoretical2 <- qsemicircle(ppoints(10000), R)
qqplot(U2, theoretical2, main = "QQ Plot of Shifted Beta vs Theoretical Semicircle for n = 10000",
       xlab = "Shifted Beta", ylab = "Theoretical Semicircle", cex = 2)
abline(a = 0, b = 1, col = "red")

theoretical3 <- qsemicircle(ppoints(100000), R)
qqplot(U3, theoretical3, main = "QQ Plot of Shifted Beta vs Theoretical Semicircle for n = 100000",
       xlab = "Shifted Beta", ylab = "Theoretical Semicircle", cex = 2)
abline(a = 0, b = 1, col = "red")

dev.off()

# The claim seems to be confirmed!
