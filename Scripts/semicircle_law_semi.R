################################################################################
# The purpose of this script is to verify Wigner's semicircle law with the
# functions in this package - specifically using the semicircle distribution.
# Using the following link as reference:
# https://math.uchicago.edu/~may/REU2021/REUPapers/Jiang,Tianchong.pdf
################################################################################

library(ggplot2)
library(patchwork)

# Create 3 N by N random matrices
# Stopping at 5000 instead of 10000 to save on computation time
# This script takes at least 30 minutes to run - rsemicircle is pretty slow
# for large numbers
set.seed(1234)

semicircle_1000 <- matrix(rsemicircle(1000 * 1000, R = 2), 1000, 1000)
semicircle_1000_sym = (semicircle_1000 + t(semicircle_1000)) / sqrt(2 * 1000)
ev_semicircle_1000 <- eigen(semicircle_1000_sym)
ev_semicircle_1000_df <- data.frame(ev = ev_semicircle_1000$values)

semicircle_2500 <- matrix(rsemicircle(2500 * 2500, R = 2), 2500, 2500)
semicircle_2500_sym = (semicircle_2500 + t(semicircle_2500)) / sqrt(2 * 2500)
ev_semicircle_2500 <- eigen(semicircle_2500_sym)
ev_semicircle_2500_df <- data.frame(ev = ev_semicircle_2500$values)

semicircle_5000 <- matrix(rsemicircle(5000 * 5000, R = 2), 5000, 5000)
semicircle_5000_sym = (semicircle_5000 + t(semicircle_5000)) / sqrt(2 * 5000)
ev_semicircle_5000 <- eigen(semicircle_5000_sym) # This takes a few minutes to run
ev_semicircle_5000_df <- data.frame(ev = ev_semicircle_5000$values)

# Create histograms
g1_semicircle <- ggplot(ev_semicircle_1000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 1000")

g2_semicircle <- ggplot(ev_semicircle_2500_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 2500")

g3_semicircle <- ggplot(ev_semicircle_5000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 5000")

jpeg("Plots/SemiLaw_NoCurve_Semicircle.jpeg", width = 600, height = 600)

g1_semicircle /
  g2_semicircle /
  g3_semicircle + plot_annotation(
    title = "Semicircle Distribution with R = 2 and a = 0",
    theme = theme(plot.title = element_text(hjust = 0.5))
  ) &
  scale_y_continuous("Density",
                     breaks = seq(0, 0.4, by = 0.1),
                     limits = c(0, 0.4)
  )

dev.off()

# Add semicircle distribution densities
g1_semicircle <- g1_semicircle +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

g2_semicircle <- g2_semicircle +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

g3_semicircle <- g3_semicircle +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

jpeg("Plots/SemiLaw_Semicircle.jpeg", width = 600, height = 600)

g1_semicircle /
  g2_semicircle /
  g3_semicircle + plot_annotation(
    title = "Semicircle Distribution with R = 2 and a = 0",
    theme = theme(plot.title = element_text(hjust = 0.5))
  ) &
  scale_y_continuous("Density",
                     breaks = seq(0, 0.4, by = 0.1),
                     limits = c(0, 0.4)
  )

dev.off()

# Wigner's semicircle law is verified!
