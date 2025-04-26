################################################################################
# The purpose of this script is to verify Wigner's semicircle law with the
# functions in this package - specifically using the uniform distribution.
# Using the following link as reference:
# https://math.uchicago.edu/~may/REU2021/REUPapers/Jiang,Tianchong.pdf
################################################################################

library(ggplot2)
library(patchwork)

# Create 3 N by N random matrices
# Stopping at 5000 instead of 10000 to save on computation time
set.seed(1234)

unif_1000 <- (matrix(runif(1000 * 1000), 1000, 1000) - 0.5) / sqrt(1 / 12)
unif_1000_sym <- (unif_1000 + t(unif_1000)) / sqrt(2 * 1000)
ev_unif_1000 <- eigen(unif_1000_sym)
ev_unif_1000_df <- data.frame(ev = ev_unif_1000$values[-1])

unif_2500 <- (matrix(runif(2500 * 2500), 2500, 2500) - 0.5) / sqrt(1 / 12)
unif_2500_sym <- (unif_2500 + t(unif_2500)) / sqrt(2 * 2500)
ev_unif_2500 <- eigen(unif_2500_sym)
ev_unif_2500_df <- data.frame(ev = ev_unif_2500$values[-1])

unif_5000 <- (matrix(runif(5000 * 5000), 5000, 5000) - 0.5) / sqrt(1 / 12)
unif_5000_sym <- (unif_5000 + t(unif_5000)) / sqrt(2 * 5000)
ev_unif_5000 <- eigen(unif_5000_sym) # This takes a few minutes to run
ev_unif_5000_df <- data.frame(ev = ev_unif_5000$values[-1])

# Create histograms
g1_unif <- ggplot(ev_unif_1000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 1000")

g2_unif <- ggplot(ev_unif_2500_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 2500")

g3_unif <- ggplot(ev_unif_5000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2, 2, by = 0.1)) +
  xlab("Scaled Eigenvalues for N = 5000")

jpeg("Plots/SemiLaw_NoCurve_Unif.jpeg", width = 600, height = 600)

g1_unif /
  g2_unif /
  g3_unif + plot_annotation(
    title = expression(paste("Uniform Distribution with a = ", -sqrt(3), " and b = ", sqrt(3))),
    theme = theme(plot.title = element_text(hjust = 0.5))
  ) &
  scale_y_continuous("Density",
                     breaks = seq(0, 0.4, by = 0.1),
                     limits = c(0, 0.4)
  )

dev.off()

# Add semicircle distribution densities
g1_unif <- g1_unif +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

g2_unif <- g2_unif +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

g3_unif <- g3_unif +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1, color = "red")

jpeg("Plots/SemiLaw_Unif.jpeg", width = 600, height = 600)

g1_unif /
  g2_unif /
  g3_unif + plot_annotation(
    title = expression(paste("Uniform Distribution with a = ", -sqrt(3), " and b = ", sqrt(3))),
    theme = theme(plot.title = element_text(hjust = 0.5))
  ) &
  scale_y_continuous("Density",
                     breaks = seq(0, 0.4, by = 0.1),
                     limits = c(0, 0.4)
  )

dev.off()

# Wigner's semicircle law is verified!
