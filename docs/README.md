# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Introduction

`DEVISE` complements rather than replaces packages that calculate statistical estimates and confidence intervals. It supports the workflow around those calculations by extracting and summarizing data beforehand, then presenting results in accessible formats such as summary tables and comparison plots.

- [Overview](#overview)
- [Resources](#resources)

---

### Overview

Though it works with base R and all packages, `DEVISE` is designed to work particularly well with:

- [`backcalc`](https://github.com/cwendorf/backcalc): Reconstructs missing inferential statistics from incomplete summary data.
- [`EASI`](https://github.com/cwendorf/EASI): Implements estimation statistics and effect size computation in a direct fashion.
- [`confintr`](https://github.com/mayer79/confintr): Provides classic and bootstrap confidence intervals for various parameters.
- [`statpsych`](https://github.com/dgbonett/statpsych/): Offers methods across multiple research designs and parameters.

### Resources

- [Reference](./man/README.md): Documentation for all exported functions, including usage, arguments, return values, and examples.
- [Articles](./vignettes/README.md): Examples demonstrating how to use `DEVISE` directly and in conjunction with other packages.
