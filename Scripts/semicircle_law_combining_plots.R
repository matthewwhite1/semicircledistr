################################################################################
# The purpose of this script is to combine the plots from the exp, unif, and
# semi semicircle_law scripts into one plot using patchwork.
# You must have all of the plots from those scripts loaded into your
# environment in order to run this script.
################################################################################

library(ggplot2)
library(patchwork)
library(grid)

main_plot <- (g1_exp + g1_unif + g1_semicircle + plot_layout(axes = "collect")) /
  (g2_exp + g2_unif + g2_semicircle + plot_layout(axes = "collect")) /
  (g3_exp + g3_unif + g3_semicircle + plot_layout(axes = "collect")) &
  scale_y_continuous("Density",
                     breaks = seq(0, 0.4, by = 0.1),
                     limits = c(0, 0.4)
  )

# This comes from ChatGPT
column_titles <- wrap_plots(
  ggplot() + theme_void() +
    annotation_custom(grid::textGrob("Exponential", gp=grid::gpar(fontsize=15))),
  ggplot() + theme_void() +
    annotation_custom(grid::textGrob("Uniform", gp=grid::gpar(fontsize=15))),
  ggplot() + theme_void() +
    annotation_custom(grid::textGrob("Semicircle", gp=grid::gpar(fontsize=15))),
  ncol = 3
)

final_plot <- column_titles / main_plot +
  plot_layout(heights = c(0.1, 1))  # adjust height to make title row smaller

jpeg("Plots/SemiLaw_Combined.jpeg", width = 600, height = 600)

final_plot

dev.off()
