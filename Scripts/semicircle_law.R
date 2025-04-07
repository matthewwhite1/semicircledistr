################################################################################
# The purpose of this script is to verify Wigner's semicircle law with the
# functions in this package.
# Using the following link as reference:
# https://math.uchicago.edu/~may/REU2021/REUPapers/Jiang,Tianchong.pdf
################################################################################

library(ggplot2)
library(pracma) # for random matrices
library(gridExtra)

# Create 3 N by N random matrices
# Stopping at 5000 instead of 10000 to save on computation time
set.seed(1234)

goe_1000 <- randn(1000)
ev_1000 <- eigen(goe_1000)
ev_1000_data <- scale(as.numeric(ev_1000$values))
ev_1000_df <- data.frame(ev = ev_1000_data)

goe_2500 <- randn(2500)
ev_2500 <- eigen(goe_2500)
ev_2500_data <- scale(as.numeric(ev_2500$values))
ev_2500_df <- data.frame(ev = ev_2500_data)

goe_5000 <- randn(5000)
ev_5000 <- eigen(goe_5000) # This takes a few minutes to run
ev_5000_data <- scale(as.numeric(ev_5000$values))
ev_5000_df <- data.frame(ev = ev_5000_data)

# Create histograms
g1 <- ggplot(ev_1000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2.1, 2, by = 0.1)) +
  scale_y_continuous("Density", breaks = seq(0, 0.5, by = 0.1), limits = c(0, 0.5)) +
  xlab("Scaled Eigenvalues for N = 1000")

g2 <- ggplot(ev_2500_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2.1, 2, by = 0.1)) +
  scale_y_continuous("Density", breaks = seq(0, 0.5, by = 0.1), limits = c(0, 0.5)) +
  xlab("Scaled Eigenvalues for N = 2500")

g3 <- ggplot(ev_5000_df, aes(ev)) +
  geom_histogram(aes(y = after_stat(density)), breaks = seq(-2.1, 2, by = 0.1)) +
  scale_y_continuous("Density", breaks = seq(0, 0.5, by = 0.1), limits = c(0, 0.5)) +
  xlab("Scaled Eigenvalues for N = 5000")

grid.arrange(g1, g2, g3)

# Add semicircle distribution densities
g1 <- g1 +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1.5, color = "red")

g2 <- g2 +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1.5, color = "red")

g3 <- g3 +
  stat_function(fun = dsemicircle, args = list(R = 2), lwd = 1.5, color = "red")

grid.arrange(g1, g2, g3)

# Wigner's semicircle law is verified!
