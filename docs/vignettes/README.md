# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Articles

This section contains vignettes for `DEVISE`. Each page demonstrates a workflow using real or simulated data, including setup, computation, formatting, and visualization.

### Core Operations

`DEVISE` uses a particular workflow and set of functions to organize and handle data and results.

- [Basic Workflow](./basicWorkflow.md): The coding conventions and process used throughout the package.
- [Descriptive Statistics](./descriptiveStatistics.md): Obtaining descriptive statistics for later analyses.

### Mean Comparisons

One main purpose of `DEVISE` is to aid in the presentation of a mean comparison after using other methods or packages to calculate the confidence intervals.

- [Mean Comparisons with Direct Input](./directMeanComparisons.md): Uses direct input of confidence intervals from published sources.
- [Mean Comparisons with Base R](./baseMeanComparisons.md): Uses base R to calculate confidence intervals from data.
- [Mean Comparisons with EASI](./easiMeanComparisons.md): Uses `EASI` to calculate the confidence intervals from data and summary statistics.
- [Mean Comparisons with statpsych and spTools](./spToolsMeanComparisons.md): Uses `statpsych` and `spTools` to calculate confidence intervals from summary statistics.
- [Mean Comparisons with backcalc](./backcalcMeanComparisons.md): Uses `backcalc` to infer confidence intervals from incomplete summary statistics.
- [Mean Comparisons with confintr](./confintrMeanComparisons.md): Uses `confintr` to calculate parametric and bootstrapped confidence intervals from data.
