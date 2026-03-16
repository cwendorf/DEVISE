# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Vignettes

This section contains vignettes for `DEVISE`. Each page demonstrates a workflow using real or simulated data, including setup, computation, formatting, and visualization.

### Getting Started

- **[Workflow Vignette](./workflowVignette.md)**: This vignette introduces the coding conventions used throughout `DEVISE`. It demonstrates the use of forward assignment (`->`) and pipe operators (`|>`) to write readable, left-to-right analytical workflows.

### Using DEVISE Directly

- **[Direct Input Vignette](./directVignette.md)**: This vignette demonstrates how to directly input reported statistics from published or secondary sources to present estimation results. `DEVISE` handles the assembly, formatting, and visualization of these externally-sourced values without any computation.

### Using DEVISE with Other Packages

- **[Reconstructed Information Vignette](./reconstructVignette.md)**: In conjunction with `DEVISE`, this vignette demonstrates how to use `backcalc` to reconstruct and compute confidence intervals for statistics beyond simple means. When published studies report summary statistics or test results, `backcalc` can reconstruct the full inferential statistics for various types of analyses.

- **[Bootstrapped Intervals Vignette](./bootstrapVignette.md)**: In conjunction with `DEVISE`, this vignette demonstrates how to use the `confintr` package for parametric and bootstrap confidence intervals. `confintr` supports both distribution-based confidence intervals for normally-distributed data and bootstrap methods that provide distribution-free intervals without relying on parametric assumptions.
