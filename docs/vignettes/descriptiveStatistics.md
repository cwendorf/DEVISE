# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Calculating Descriptive Statistics

This vignette demonstrates how to compute and format descriptive
statistics and correlations using `DEVISE`. These functions help
extract, summarize, and visualize data characteristics for exploratory
analysis and presentation.

- [Case 1: Overall Descriptive Statistics](#case-1-overall-descriptive-statistics)
- [Case 2: Grouped Descriptive Statistics](#case-2-grouped-descriptive-statistics)
- [Case 3: Correlation Analysis](#case-3-correlation-analysis)

------------------------------------------------------------------------

### Case 1: Overall Descriptive Statistics

#### Create Sample Data

Create a sample dataset with groups and multiple variables for
demonstration purposes.

``` r
data.frame(
  Group = create_groups(k = 2, c(5, 5), labels = c("Group1", "Group2")),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10)
) -> df
```

#### Obtain Descriptive Statistics

Compute descriptive statistics without grouping:

``` r
df |> compute_descriptives()
```

          N   M       SD
    Quiz 10 7.0 1.490712
    Exam 10 8.3 1.337494

Format the results as an APA-style table:

``` r
df |> compute_descriptives(Quiz, Exam) |> style_matrix(title = "Table 1: Descriptive Statistics", style = "apa")
```


    Table 1: Descriptive Statistics 

    ------------------------------------- 
                  N          M         SD 
    ------------------------------------- 
    Quiz     10.000      7.000      1.491
    Exam     10.000      8.300      1.337 
    ------------------------------------- 

### Case 2: Grouped Descriptive Statistics

#### Obtain Descriptive Statistics for a Single Variable

Compute descriptive statistics for a single variable grouped by another
variable:

``` r
df |> compute_descriptives(Quiz ~ Group)
```

           N   M      SD
    Group1 5 5.8 0.83666
    Group2 5 8.2 0.83666

Format with styling:

``` r
df |> compute_descriptives(Quiz ~ Group) |> style_matrix(title = "Table 2: Descriptive Statistics by Group", style = "apa")
```


    Table 2: Descriptive Statistics by Group 

    --------------------------------------- 
                    N          M         SD 
    --------------------------------------- 
    Group1      5.000      5.800      0.837
    Group2      5.000      8.200      0.837 
    --------------------------------------- 

#### Obtain Descriptive Statistics for Multiple Variables

Compute descriptive statistics for multiple variables grouped by another
variable:

``` r
df |> compute_descriptives(c(Quiz, Exam) ~ Group)
```

    $Group1
         N   M       SD
    Quiz 5 5.8 0.836660
    Exam 5 7.4 1.140175

    $Group2
         N   M      SD
    Quiz 5 8.2 0.83666
    Exam 5 9.2 0.83666

### Case 3: Correlation Analysis

#### Compute Correlation Matrix

Compute a correlation matrix for multiple variables:

``` r
df |> compute_correlations()
```

              Quiz      Exam
    Quiz 1.0000000 0.7801895
    Exam 0.7801895 1.0000000

Format as a styled table:

``` r
df |> compute_correlations(Quiz, Exam) |> style_matrix(title = "Table 3: Correlation Matrix", style = "apa")
```


    Table 3: Correlation Matrix 

    -------------------------- 
               Quiz       Exam 
    -------------------------- 
    Quiz      1.000      0.780
    Exam      0.780      1.000 
    -------------------------- 

#### Compute Correlation Matrices

Compute correlations separately for each group:

``` r
df |> compute_correlations(c(Quiz, Exam) ~ Group)
```

    $Group1
              Quiz      Exam
    Quiz 1.0000000 0.6289709
    Exam 0.6289709 1.0000000

    $Group2
              Quiz      Exam
    Quiz 1.0000000 0.2857143
    Exam 0.2857143 1.0000000

#### Compute Covariance Matrix

Compute the covariance matrix instead of correlations:

``` r
df |> compute_correlations(Quiz, Exam, type = "cov") |> style_matrix(title = "Table 4: Covariance Matrix", style = "apa")
```


    Table 4: Covariance Matrix 

    -------------------------- 
               Quiz       Exam 
    -------------------------- 
    Quiz      2.222      1.556
    Exam      1.556      1.789 
    -------------------------- 
