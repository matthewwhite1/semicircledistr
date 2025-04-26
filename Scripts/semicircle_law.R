################################################################################
# The purpose of this script is to verify Wigner's semicircle law with the
# functions in this package.
# Using the following link as reference:
# https://math.uchicago.edu/~may/REU2021/REUPapers/Jiang,Tianchong.pdf
################################################################################

library(ggplot2)
library(pracma) # for random matrices
library(patchwork)

# Create 3 N by N random matrices
# Stopping at 5000 instead of 10000 to save on computation time
set.seed(1234)

norm_1000 <- randn(1000)
norm_1000_sym <- (norm_1000 + t(norm_1000)) / sqrt(2 * 1000)
ev_1000 <- eigen(norm_1000_sym)
ev_1000_df <- data.frame(ev = ev_1000$values)

norm_2500 <- randn(2500)
norm_2500_sym <- (norm_2500 + t(norm_2500)) / sqrt(2 * 2500)
ev_2500 <- eigen(norm_2500_sym)
ev_2500_df <- data.frame(ev = ev_2500$values)

norm_5000 <- randn(5000)
norm_5000_sym <- (norm_5000 + t(norm_5000)) / sqrt(2 * 5000)
ev_5000 <- eigen(norm_5000_sym) # This takes a few minutes to run
ev_5000_df <- data.frame(ev = ev_5000$values)

# Create histograms
g1 <- ggplot(ev_1000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 1000")

g2 <- ggplot(ev_2500_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 2500")

g3 <- ggplot(ev_5000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 5000")

jpeg("Plots/SemiLaw_NoCurve.jpeg", width = 600, height = 600)

g1 /
  g2 /
  g3 + plot_annotation(
    title = expression(paste("Normal Distribution with ", mu, " = 0 and ", sigma, " = 1")),
    theme = theme(plot.title = element_text(hjust = 0.5))
  ) &
  scale_y_continuous("Density",
    breaks = seq(0, 0.4, by = 0.1),
    limits = c(0, 0.4)
  )

dev.off()

# Add semicircle distribution densities
g1 <- g1 +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

g2 <- g2 +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

g3 <- g3 +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

jpeg("Plots/SemiLaw.jpeg", width = 600, height = 600)

g1 /
  g2 /
  g3 + plot_annotation(
    title = expression(paste("Normal Distribution with ", mu, " = 0 and ", sigma, " = 1")),
    theme = theme(plot.title = element_text(hjust = 0.5))
  ) &
  scale_y_continuous("Density",
                     breaks = seq(0, 0.4, by = 0.1),
                     limits = c(0, 0.4)
  )

dev.off()

# Wigner's semicircle law is verified!
