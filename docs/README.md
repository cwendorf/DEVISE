# [`DEVISE`](https://github.com/cwendorf/DEVISE/)
## Overview of DEVISE

`DEVISE` is a companion package for working with other statistical packages. Where other packages provide high-accuracy confidence intervals for a wide variety of statistics, `DEVISE` handles the pre-processing of data and post-processing of results into more accessible and readable formats such as summary tables and comparison plots.

This vignette explains the use of `DEVISE`, particularly the project-wide convention of using forward assignment (`->`) and pipe operators (`|>`) to keep examples readable and consistent. The goal is to read code left-to-right, from data creation to analysis to output.

### Load the Packages

Of course, when using DEVISE, you need to load it first. This also applies to any other packages you may be using.

```r
if (!require(remotes)) install.packages("remotes")
if (!require(DEVISE)) {remotes::install_github("cwendorf/DEVISE")}
library(DEVISE)
```

### Forward Assignment

To minimize visual backtracking, avoid left assignment (`<-`). Instead, use `->` to store objects after they are computed. This keeps the focus on the computation itself.

```r
data.frame(
  Group = create_groups(k = 2, c(5, 5), labels = c("Group1", "Group2")),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10)
) -> df

compute_descriptives(df, Quiz ~ Group) -> descriptives
descriptives
```

### Pipe-First Workflow

To keep data flowing, pipes (`|>`) show step-by-step transformations. They help express a sequence of operations without temporary assignment.

```r
df |> compute_descriptives(Quiz ~ Group)
df |> compute_descriptives(Quiz ~ Group) |> style_matrix(title = "Table 1: Descriptive Statistics by Group", style = "apa")

df |> compute_correlations(Quiz, Exam)
df |> compute_correlations(Quiz, Exam) |> style_matrix(title = "Table 2: Correlation Matrix", style = "apa")
```

### Examples

This package contains a set of examples to demonstrate its use:

- [Direct Input Examples](./basicExamples.md) – Use reported confidence intervals from published sources.
- [Reconstructed Information Examples](./reconstructExamples.md) – Use summary information to reconstruct the confidence intervals.
- [Bootstrapped Intervals Examples](./bootstrapExamples.md) – Use external packages to obtain parametric and bootstrapped confidence intervals.
