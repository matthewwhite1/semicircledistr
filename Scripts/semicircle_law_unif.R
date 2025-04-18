################################################################################
# The purpose of this script is to verify Wigner's semicircle law with the
# functions in this package - specifically using the uniform distribution.
# Using the following link as reference:
# https://math.uchicago.edu/~may/REU2021/REUPapers/Jiang,Tianchong.pdf
################################################################################

library(ggplot2)
library(gridExtra)

# Create 3 N by N random matrices
# Stopping at 5000 instead of 10000 to save on computation time
set.seed(1234)

unif_1000 <- matrix(runif(1000 * 1000), 1000, 1000)
ev_unif_1000 <- eigen(unif_1000)
ev_unif_1000_data <- scale(as.numeric(ev_unif_1000$values))
ev_unif_1000_df <- data.frame(ev = ev_unif_1000_data[-1])

unif_2500 <- matrix(runif(2500 * 2500), 2500, 2500)
ev_unif_2500 <- eigen(unif_2500)
ev_unif_2500_data <- scale(as.numeric(ev_unif_2500$values))
ev_unif_2500_df <- data.frame(ev = ev_unif_2500_data[-1])

unif_5000 <- matrix(runif(5000 * 5000), 5000, 5000)
ev_unif_5000 <- eigen(unif_5000) # This takes a few minutes to run
ev_unif_5000_data <- scale(as.numeric(ev_unif_5000$values))
ev_unif_5000_df <- data.frame(ev = ev_unif_5000_data[-1])

# Create histograms
g1_unif <- ggplot(ev_unif_1000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-0.6, 0.6, by = 0.025)) +
  scale_y_continuous("Density", breaks = seq(0, 1.5, by = 0.25), limits = c(0, 1.5)) +
  xlab("Scaled Eigenvalues for N = 1000")

g2_unif <- ggplot(ev_unif_2500_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-0.6, 0.6, by = 0.025)) +
  scale_y_continuous("Density", breaks = seq(0, 1.5, by = 0.25), limits = c(0, 1.5)) +
  xlab("Scaled Eigenvalues for N = 2500")

g3_unif <- ggplot(ev_unif_5000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-0.6, 0.6, by = 0.025)) +
  scale_y_continuous("Density", breaks = seq(0, 1.5, by = 0.25), limits = c(0, 1.5)) +
  xlab("Scaled Eigenvalues for N = 5000")

jpeg("Plots/SemiLaw_NoCurve_Unif.jpeg", width = 600, height = 600)

grid.arrange(g1_unif, g2_unif, g3_unif)

dev.off()

# Add semicircle distribution densities
g1_unif <- g1_unif +
  stat_function(fun = dsemicircle, args = list(R = 0.55), lwd = 1.5, color = "red")

g2_unif <- g2_unif +
  stat_function(fun = dsemicircle, args = list(R = 0.55), lwd = 1.5, color = "red")

g3_unif <- g3_unif +
  stat_function(fun = dsemicircle, args = list(R = 0.55), lwd = 1.5, color = "red")

jpeg("Plots/SemiLaw_Unif.jpeg", width = 600, height = 600)

grid.arrange(g1_unif, g2_unif, g3_unif)

dev.off()

# Wigner's semicircle law is verified!
