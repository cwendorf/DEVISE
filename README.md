# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Data Exploration, Visualization, and Inference with Statistical Estimation

[![Minimal R Version](https://img.shields.io/badge/R%3E%3D-3.6.2-blue?style=for-the-badge)](https://cran.r-project.org/)
[![GitHub Release](https://img.shields.io/github/v/release/cwendorf/DEVISE?style=for-the-badge)](https://github.com/cwendorf/DEVISE/releases/latest)
[![Project Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)](https://www.repostatus.org/#active)

### Overview

`DEVISE` is a companion toolkit for working with other packages that focus on statistical estimation. Where other packages provide high-accuracy confidence intervals for a wide variety of statistics, `DEVISE` handles the pre-processing of data (extraction of data, calculation of descriptives) and post-processing of results into more accessible and readable formats (such as summary tables and comparison plots) all using a pipe-friendly framework.

### Installation

This package is not currently available on CRAN. It can be installed directly from GitHub:

``` r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("cwendorf/DEVISE")
library(DEVISE)
```

If you prefer not to install the package, you can load the current functions directly:

```r
source("https://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")
```

### Usage

This package includes the following documentation:

- [Introduction](./docs/README.md): Overview of the package, listing of associated packages, and links to all resources.
- [Reference](./docs/man/README.md): Documentation for all exported functions, including usage, arguments, return values, and examples.
- [Articles](./docs/vignettes/README.md): Examples demonstrating how to use `DEVISE` directly and in conjunction with other packages.

### Citation

Wendorf, C.A. (2025). *DEVISE: Data Exploration, Visualization, and Inference with Statistical Estimation* [R Package]. [https://github.com/cwendorf/DEVISE](https://github.com/cwendorf/DEVISE)
