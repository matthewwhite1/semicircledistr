################################################################################
# This script generates a PDF plot based on the Wikipedia plot below.
# https://en.wikipedia.org/wiki/Wigner_semicircle_distribution
################################################################################

library(ggplot2)
library(dplyr)
library(RColorBrewer)

# Create dataframe for plotting
x <- seq(-3, 3, by = 0.01)

d0.25 <- dsemicircle(x, R = 0.25)
d0.5 <- dsemicircle(x, R = 0.5)
d1 <- dsemicircle(x, R = 1)
d2 <- dsemicircle(x, R = 2)
d3 <- dsemicircle(x, R = 3)

size <- length(d0.25)

label0.25 <- rep("R=0.25", size)
label0.5 <- rep("R=0.5", size)
label1 <- rep("R=1", size)
label2 <- rep("R=2", size)
label3 <- rep("R=3", size)

xs <- rep(x, 5)
values <- c(d0.25, d0.5, d1, d2, d3)
labels <- c(label0.25, label0.5, label1, label2, label3)

pdf_df <- data.frame(xs = xs, values = values, labels = labels)

# Plot
jpeg("Plots/PDF_plot.jpeg", width = 600, height = 600)

ggplot(pdf_df, aes(xs, values, color = labels)) +
  geom_line(lwd = 1) +
  theme_bw() +
  scale_color_brewer(palette = "Dark2") +
  scale_x_continuous("", breaks = seq(-3, 3, by = 1)) +
  scale_y_continuous("", breaks = seq(0, 2.5, by = 0.5), limits = c(0, 2.6)) +
  ggtitle("Probability Density Function") +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = c(0.9, 0.83),
        legend.title = element_blank())

dev.off()

# Demonstrate "a" parameter
x_shift <- seq(-5, 5, by = 0.01)

d1_shift <- dsemicircle(x_shift, R = 1, a = -3)
d2_shift <- dsemicircle(x_shift, R = 2, a = -1)
d3_shift <- dsemicircle(x_shift, R = 3, a = 1)

size_shift <- length(d1_shift)

label1_shift <- rep("R=1, a=-3", size_shift)
label2_shift <- rep("R=2, a=-1", size_shift)
label3_shift <- rep("R=3, a=1", size_shift)

xs_shift <- rep(x_shift, 3)
values_shift <- c(d1_shift, d2_shift, d3_shift)
labels_shift <- c(label1_shift, label2_shift, label3_shift)

pdf_df_shift <- data.frame(xs = xs_shift, values = values_shift, labels = labels_shift)

# Plot
jpeg("Plots/PDF_plot_shift.jpeg", width = 600, height = 600)

colors <- brewer.pal(5, "Dark2")[3:5]

ggplot(pdf_df_shift, aes(xs, values, color = labels)) +
  geom_line(lwd = 1) +
  theme_bw() +
  scale_color_manual(values = colors) +
  scale_x_continuous("", breaks = seq(-5, 5, by = 1)) +
  ylab("") +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = c(0.8, 0.8),
        legend.title = element_blank())

dev.off()
