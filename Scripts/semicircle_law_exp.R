################################################################################
# The purpose of this script is to verify Wigner's semicircle law with the
# functions in this package - specifically using the exponential distribution.
# Using the following link as reference:
# https://math.uchicago.edu/~may/REU2021/REUPapers/Jiang,Tianchong.pdf
################################################################################

library(ggplot2)
library(gridExtra)

# Create 3 N by N random matrices
# Stopping at 5000 instead of 10000 to save on computation time
set.seed(1234)

exp_1000 <- matrix(rexp(1000 * 1000), 1000, 1000)
ev_exp_1000 <- eigen(exp_1000)
ev_exp_1000_data <- scale(as.numeric(ev_exp_1000$values))
ev_exp_1000_df <- data.frame(ev = ev_exp_1000_data[-1])

exp_2500 <- matrix(rexp(2500 * 2500), 2500, 2500)
ev_exp_2500 <- eigen(exp_2500)
ev_exp_2500_data <- scale(as.numeric(ev_exp_2500$values))
ev_exp_2500_df <- data.frame(ev = ev_exp_2500_data[-1])

exp_5000 <- matrix(rexp(5000 * 5000), 5000, 5000)
ev_exp_5000 <- eigen(exp_5000) # This takes a few minutes to run
ev_exp_5000_data <- scale(as.numeric(ev_exp_5000$values))
ev_exp_5000_df <- data.frame(ev = ev_exp_5000_data[-1])

# Create histograms
g1_exp <- ggplot(ev_exp_1000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-1, 1, by = 0.05)) +
  scale_y_continuous("Density", breaks = seq(0, 1, by = 0.2), limits = c(0, 1)) +
  xlab("Scaled Eigenvalues for N = 1000")

g2_exp <- ggplot(ev_exp_2500_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-1, 1, by = 0.05)) +
  scale_y_continuous("Density", breaks = seq(0, 1, by = 0.2), limits = c(0, 1)) +
  xlab("Scaled Eigenvalues for N = 2500")

g3_exp <- ggplot(ev_exp_5000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-1, 1, by = 0.05)) +
  scale_y_continuous("Density", breaks = seq(0, 1, by = 0.2), limits = c(0, 1)) +
  xlab("Scaled Eigenvalues for N = 5000")

jpeg("Plots/SemiLaw_NoCurve_Exp.jpeg", width = 600, height = 600)

grid.arrange(g1_exp, g2_exp, g3_exp)

dev.off()

# Add semicircle distribution densities
g1_exp <- g1_exp +
  stat_function(fun = dsemicircle, args = list(R = 0.9), lwd = 1.5, color = "red")

g2_exp <- g2_exp +
  stat_function(fun = dsemicircle, args = list(R = 0.9), lwd = 1.5, color = "red")

g3_exp <- g3_exp +
  stat_function(fun = dsemicircle, args = list(R = 0.9), lwd = 1.5, color = "red")

jpeg("Plots/SemiLaw_Exp.jpeg", width = 600, height = 600)

grid.arrange(g1_exp, g2_exp, g3_exp)

dev.off()

# Wigner's semicircle law is verified!
