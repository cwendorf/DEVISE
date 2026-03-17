# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Introduction

### Overview

`DEVISE` is a companion package for working with other statistical packages. Where other packages provide high-accuracy confidence intervals for a wide variety of statistics, `DEVISE` handles the pre-processing of data (extraction of data, calculation of descriptives) and post-processing of results into more accessible and readable formats (such as summary tables and comparison plots).

Though it works with base R and all packages, `DEVISE` is designed to work particularly well with:

- [`backcalc`](https://github.com/cwendorf/backcalc): Reconstructs missing inferential statistics from incomplete summary data.
- [`EASI`](https://github.com/cwendorf/EASI): Implements estimation statistics and effect size computation in a direct fashion.
- [`confintr`](https://github.com/mayer79/confintr): Provides classic and bootstrap confidence intervals for various parameters.
- [`statpsych`](https://github.com/dgbonett/statpsych/): Offers methods across multiple reseach designs and parameters.

### Resources

- [Reference](./man/README.md): Documentation for all exported functions, including usage, arguments, return values, and examples.
- [Articles](./vignettes/README.md): Examples demonstrating how to use `DEVISE` directly and in conjunction with other packages.
