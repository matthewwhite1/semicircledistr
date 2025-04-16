
<!-- README.md is generated from README.Rmd. Please edit that file -->

# semicircledistr

<!-- badges: start -->

[![R-CMD-check](https://github.com/matthewwhite1/semicircledistr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/matthewwhite1/semicircledistr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of semicircledistr is to simulate the Wigner semicircle
distribution. This package includes the four main distribution
simulation functions that other distributions in R have.

## Installation

You can install the development version of semicircledistr like so:

``` r
devtools::install_github("https://github.com/matthewwhite1/semicircledistr")
```

## Using the Four Functions

Here are some examples of how to use the four main functions included in
this package:

``` r
library(semicircledistr)

# Using dsemicircle
dsemicircle(0, R = 1)
#> [1] 0.6366198
dsemicircle(c(0, 0.5, 1), R = 1)
#> [1] 0.6366198 0.5513289 0.0000000

# Using psemicircle
psemicircle(0, R = 1)
#> [1] 0.5
psemicircle(c(0, 0.5, 1), R = 1)
#> [1] 0.5000000 0.8044989 1.0000000

# Using qsemicircle
qsemicircle(0.5, R = 1)
#> [1] 0
qsemicircle(c(0.1, 0.5, 0.9), R = 1)
#> [1] -0.6870235  0.0000000  0.6870235

# Using rsemicircle
rsemicircle(10, R = 1)
#>  [1]  0.5776820  0.4195939  0.6097130 -0.5289568  0.7558557  0.6171496
#>  [7] -0.7367843  0.1074508 -0.1981654  0.8396349
rsemicircle(5, R = 1)
#> [1] -0.20335631 -0.08481184 -0.59083344 -0.43884838  0.37160221
```

## Plots

Here are some plots that can be created with our functions, similar to
the plots found in Wikipedia. The code for creating these plots can be
found in the Scripts folder.

<figure>
<img src="Plots/PDF_plot.jpeg"
alt="Probability density function plot created with dsemicircle." />
<figcaption aria-hidden="true">Probability density function plot created
with dsemicircle.</figcaption>
</figure>

<p>

 
</p>

<figure>
<img src="Plots/PDF_plot_shift.jpeg"
alt="Probability density function plot with shift parameter." />
<figcaption aria-hidden="true">Probability density function plot with
shift parameter.</figcaption>
</figure>

<p>

 
</p>

<figure>
<img src="Plots/CDF_plot.jpeg"
alt="Cumulative distribution function plot created with psemicircle." />
<figcaption aria-hidden="true">Cumulative distribution function plot
created with psemicircle.</figcaption>
</figure>

<p>

 
</p>

<figure>
<img src="Plots/QQ_plot.jpeg"
alt="QQ plot created with rsemicircle and qsemicircle." />
<figcaption aria-hidden="true">QQ plot created with rsemicircle and
qsemicircle.</figcaption>
</figure>

<p>

 
</p>

<figure>
<img src="Plots/SemiLaw.jpeg"
alt="Histograms of random matrix eigenvalues to demonstrate Wigner’s semicircle law." />
<figcaption aria-hidden="true">Histograms of random matrix eigenvalues
to demonstrate Wigner’s semicircle law.</figcaption>
</figure>
