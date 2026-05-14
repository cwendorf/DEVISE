Descriptive Statistics
================

## Descriptive Statistics

This vignette demonstrates how to compute descriptive statistics using
`DEVISE`. These functions help extract and summarize data for later
analyses.

- [Create Sample Data](#create-sample-data)
- [Means and Standard Deviations](#means-and-standard-deviations)
- [Medians and Quartiles](#medians-and-quartiles)
- [Correlations and Covariances](#correlations-and-covariances)

------------------------------------------------------------------------

### Create Sample Data

Create a sample dataset with groups and multiple variables for
demonstration purposes.

``` r
data.frame(
  Group = rep(c("Group1", "Group2"), each = 5),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10)
) -> df
```

### Means and Standard Deviations

Compute descriptive statistics for the whole frame:

``` r
df |> summarize_descriptives()
```

          N   M       SD
    Quiz 10 7.0 1.490712
    Exam 10 8.3 1.337494

Compute descriptive statistics for selected variables:

``` r
df |> summarize_descriptives(Quiz, Exam)
```

          N   M       SD
    Quiz 10 7.0 1.490712
    Exam 10 8.3 1.337494

Compute descriptive statistics for a single variable grouped by another
variable:

``` r
df |> summarize_descriptives(Quiz ~ Group)
```

           N   M      SD
    Group1 5 5.8 0.83666
    Group2 5 8.2 0.83666

Compute descriptive statistics for multiple variables grouped by another
variable:

``` r
df |> summarize_descriptives(c(Quiz, Exam) ~ Group)
```

    $Group1
         N   M       SD
    Quiz 5 5.8 0.836660
    Exam 5 7.4 1.140175

    $Group2
         N   M      SD
    Quiz 5 8.2 0.83666
    Exam 5 9.2 0.83666

### Medians and Quartiles

Compute quartile summaries for the whole frame:

``` r
df |> summarize_quartiles()
```

          N Mdn  IQR
    Quiz 10 7.0 2.00
    Exam 10 8.5 1.75

Compute quartile summaries for selected variables:

``` r
df |> summarize_quartiles(Quiz, Exam)
```

          N Mdn  IQR
    Quiz 10 7.0 2.00
    Exam 10 8.5 1.75

Compute quartile summaries for a single variable grouped by another
variable:

``` r
df |> summarize_quartiles(Quiz ~ Group)
```

           N Mdn IQR
    Group1 5   6   1
    Group2 5   8   1

Compute quartile summaries for multiple variables grouped by another
variable:

``` r
df |> summarize_quartiles(c(Quiz, Exam) ~ Group)
```

    $Group1
         N Mdn IQR
    Quiz 5   6   1
    Exam 5   7   1

    $Group2
         N Mdn IQR
    Quiz 5   8   1
    Exam 5   9   1

### Correlations and Covariances

Compute a correlation matrix for a whole frame:

``` r
df |> summarize_relationships()
```

              Quiz      Exam
    Quiz 1.0000000 0.7801895
    Exam 0.7801895 1.0000000

Compute a correlation matrix for selected variables:

``` r
df |> summarize_relationships(Quiz, Exam)
```

              Quiz      Exam
    Quiz 1.0000000 0.7801895
    Exam 0.7801895 1.0000000

Compute correlations separately for each group:

``` r
df |> summarize_relationships(c(Quiz, Exam) ~ Group)
```

    $Group1
              Quiz      Exam
    Quiz 1.0000000 0.6289709
    Exam 0.6289709 1.0000000

    $Group2
              Quiz      Exam
    Quiz 1.0000000 0.2857143
    Exam 0.2857143 1.0000000

Compute covariances instead of correlations:

``` r
df |> summarize_relationships(Quiz, Exam, type = "cov")
```

             Quiz     Exam
    Quiz 2.222222 1.555556
    Exam 1.555556 1.788889
