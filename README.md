
# `DEVISE` 

## Data Exploration, Visualization, and Inference with Statistical Estimation

[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.6.2-6666ff.svg)](https://cran.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

### Overview

`DEVISE` is a companion package for working with other statistical packages. Where other packages provide high-accuracy confidence intervals for a wide variety of statistics, `DEVISE` handles the pre-processing of data and post-processing of results into more accessible and readable formats such as summary tables and comparison plots.

### Installation

This package is not currently on CRAN, but can be installed and loaded using these R commands

``` r
if (!require(remotes)) install.packages("remotes")
remotes::install_github("cwendorf/DEVISE")
library(DEVISE)
```

If you do not wish a full install, the latest functions can be made available using this R command:

```r
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")
```

### Usage

This package contains a set of examples to demonstrate its use:

- [Direct and Basic Examples](./docs/basicExamples.md) – Use reported confidence intervals from published sources or use Base R to calculate the confidence intervals.
- [Reconstructed Information Examples](./docs/reconstructExamples.md) – Start from incomplete sumamry information to reconstruct the confidence intervals for various statistics.
- [Bootstrapped Intervals Examples](./docs/bootstrapExamples) – Use external packages to obtain parametric and bootstrapped confidence intervals for various statistics.

### Contact Me

- GitHub Issues: [https://github.com/cwendorf/DEVISE/issues](https://github.com/cwendorf/DEVISE/issues) 
- Author Email: [cwendorf@uwsp.edu](mailto:cwendorf@uwsp.edu)
- Author Homepage: [https://github.com/cwendorf](https://github.com/cwendorf)

### Citation

Wendorf, C.A. (2025). *DEVISE: Data Exploration, Visualization, and Inference with Statistical Estimation* [R Package]. [https://github.com/cwendorf/DEVISE](https://github.com/cwendorf/DEVISE)

