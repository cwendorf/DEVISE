# [`DEVISE`](https://github.com/cwendorf/DEVISE/)
## Working with DEVISE

### Overview

`DEVISE` is a companion package for working with other statistical packages. Where other packages provide high-accuracy confidence intervals for a wide variety of statistics, `DEVISE` handles the pre-processing of data (extraction of data, calculation of descriptives) and post-processing of results into more accessible and readable formats (such as summary tables and comparison plots).

Though it works with base R and all packages, `DEVISE` is designed to work particularly well in conjunction with:

- [`backcalc`](https://github.com/cwendorf/backcalc)
- [`EASI`](https://github.com/cwendorf/EASI)
- [`confintr`](https://github.com/mayer79/confintr) 
- [`statpsych`](https://github.com/dgbonett/statpsych/)

### The Workflow

`DEVISE` utilizes forward assignment (`->`) and pipe operators (`|>`) to keep examples readable and consistent. The goal is to read code left-to-right, from data creation to analysis to output.

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
- [Reconstructed Information Examples](./reconstructExamples.md) – Use external packages to reconstruct confidence intervals.
- [Bootstrapped Intervals Examples](./bootstrapExamples.md) – Use external packages to obtain bootstrapped confidence intervals.
