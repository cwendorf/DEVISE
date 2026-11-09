# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Data Exploration, Visualization, and Inference with Statistical Estimation

[![Minimal R Version](https://img.shields.io/badge/R%3E%3D-3.6.2-6666ff?style=for-the-badge)](https://cran.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](https://opensource.org/licenses/MIT)

### Overview

`DEVISE` is a companion toolkit for working with other packages that focus on statistical estimation. Where other packages provide high-accuracy confidence intervals for a wide variety of statistics, `DEVISE` handles the pre-processing of data (extraction of data, calculation of descriptives) and post-processing of results into more accessible and readable formats (such as summary tables and comparison plots) all using a pipe-friendly framework.

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

This package includes the following documentation:

- [Introduction](./docs/README.md): Overview of the package, listing of associated packages, and links to all resources.
- [Reference](./docs/man/README.md): Documentation for all exported functions, including usage, arguments, return values, and examples.
- [Articles](./docs/vignettes/README.md): Examples demonstrating how to use `DEVISE` directly and in conjunction with other packages.

### Citation

Wendorf, C.A. (2025). *DEVISE: Data Exploration, Visualization, and Inference with Statistical Estimation* [R Package]. [https://github.com/cwendorf/DEVISE](https://github.com/cwendorf/DEVISE)
