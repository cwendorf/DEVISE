# `DEVISE` 

## Data Exploration, Visualization, and Inference with Statistical Estimation

[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.6.2-6666ff.svg)](https://cran.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

### Overview

`DEVISE` is an R package that implements features of estimation statistics and data visualization in a pipe-oriented framework. Its primary functions describe, estimate, test, and plot confidence intervals for means, mean comparisons, correlations, and standardized effect sizes in between- and within-subjects single-factor, factorial, and mixed designs. Most functions can take either raw data or summary statistics as input.

![Standard DEVISE Output](./man/figures/CoverImageOne.jpg)

Other functions extend the analysis capabilities by offering summaries and plots of data, frequencies, densities, and more. These features can be combined to produce images similar to those from other estimation statistics implementations. 

![Enhanced DEVISE Output](./man/figures/CoverImageTwo.jpg)

### Installation

This R package is not currently on CRAN, but the latest version can be installed and loaded using these R commands:

``` r
if (!require(remotes)) install.packages("remotes")
remotes::install_github("cwendorf/DEVISE")
library(DEVISE)
```

If you do not wish a full install, the latest functions can be made available using these R commands:

``` r
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")
```

### Usage

The package includes a wide variety of materials that demonstrate its use:

- [Introduction](https://cwendorf.github.io/DEVISE/articles/Introduction.html) - A quick overview and summary of the package
- [Reference](https://cwendorf.github.io/DEVISE/reference/index.html) - Reference documentation of the functions of the package
- [Articles](https://cwendorf.github.io/DEVISE/articles/index.html) - Examples and applications of features of the package

### Contact Me

- GitHub Issues: [https://github.com/cwendorf/DEVISE/issues](https://github.com/cwendorf/DEVISE/issues) 
- Author Email: [cwendorf@uwsp.edu](mailto:cwendorf@uwsp.edu)
- Author Homepage: [https://github.com/cwendorf](https://github.com/cwendorf)

### Citation

Wendorf, C. A. (2025). *DEVISE: Data exploration, visualization, and inference with statistical estimation* [R Package]. [https://cwendorf.github.io/DEVISE/](https://cwendorf.github.io/DEVISE/)
