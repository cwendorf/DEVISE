# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Mean Comparisons with `EASI`

This vignette demonstrates two workflows with EASI: one using raw data
and one using summary statistics. Each workflow follows the same pattern
of building condition intervals, then generating a comparison.

- [Case 1: Raw Data Input](#case-1-raw-data-input)
- [Case 2: Summary Statistics Input](#case-2-summary-statistics-input)

------------------------------------------------------------------------

### Case 1: Raw Data Input

#### Input the Data

Create a factor and outcome vector for the raw-data workflow.

``` r
gl(3, 10, labels = c("Level1", "Level2", "Level3")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10) -> Outcome
```

#### Examine the Conditions

Estimate condition means and intervals from the raw data.

``` r
(Outcome~Factor) |> estimateMeans() -> Conditions
```

#### Display the Conditions

Format and visualize the condition intervals.

``` r
Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals for Conditions", style = "apa")
```


    Table 1: Means and Confidence Intervals for Conditions 

    ------------------------------------------------------------- 
                  Est         SE         df         LL         UL 
    ------------------------------------------------------------- 
    Level1      8.000      0.447      9.000      6.988      9.012
    Level2     11.000      0.699      9.000      9.418     12.582
    Level3     12.000      0.775      9.000     10.248     13.752 
    ------------------------------------------------------------- 

``` r
Conditions |> plot_conditions(title = "Figure 1: Means and Confidence Intervals for Conditions", values = TRUE)
```

![](figures/easi-case1-conditions-1.png)<!-- -->

#### Make a Comparison

Subset to the two conditions that will be compared directly.

``` r
Outcome[Factor %in% c("Level1", "Level2")] -> Outcome_Sub
Factor[Factor %in% c("Level1", "Level2")] -> Factor_Sub
```

#### Examine a Comparison

Estimate the comparison interval for the selected conditions.

``` r
(Outcome_Sub~Factor_Sub) |> estimateComparison() -> Comparison
```

#### Display a Comparison

Present the comparison in a formatted table and plot.

``` r
Comparison |> style_matrix(title = "Table 2: Means and Confidence Intervals for a Comparison", style = "apa")
```


    Table 2: Means and Confidence Intervals for a Comparison 

    ----------------------------------------------------------------- 
                      Est         SE         df         LL         UL 
    ----------------------------------------------------------------- 
    Level1          8.000      0.447      9.000      6.988      9.012
    Level2         11.000      0.699      9.000      9.418     12.582
    Comparison      3.000      0.830     15.308      1.234      4.766 
    ----------------------------------------------------------------- 

``` r
Comparison |> plot_comparison(title = "Figure 2: Means and Confidence Intervals for a Comparison", values = TRUE)
```

![](figures/easi-case1-comparison-1.png)<!-- -->

### Case 2: Summary Statistics Input

#### Input the Statistics

Provide summary statistics to demonstrate the summary-input workflow.

``` r
c(N = 10, M = 8.000, SD = 1.414) -> Level1
c(N = 10, M = 11.000, SD = 2.211) -> Level2
c(N = 10, M = 12.000, SD = 2.449) -> Level3
construct(Level1, Level2, Level3, class = "bsm") -> IndependentSummary
```

#### Examine the Conditions

Estimate condition intervals from summary statistics.

``` r
IndependentSummary |> estimateMeans() -> Conditions
```

#### Display the Conditions

Format and visualize the condition intervals.

``` r
Conditions |> style_matrix(title = "Table 3: Means and Confidence Intervals for Conditions", style = "apa")
```


    Table 3: Means and Confidence Intervals for Conditions 

    ------------------------------------------------------------- 
                  Est         SE         df         LL         UL 
    ------------------------------------------------------------- 
    Level1      8.000      0.447      9.000      6.988      9.012
    Level2     11.000      0.699      9.000      9.418     12.582
    Level3     12.000      0.774      9.000     10.248     13.752 
    ------------------------------------------------------------- 

``` r
Conditions |> plot_conditions(title = "Figure 3: Means and Confidence Intervals for Conditions", values = TRUE)
```

![](figures/easi-case2-conditions-1.png)<!-- -->

#### Examine a Comparison

Compute the comparison interval for the summary-input workflow.

``` r
construct(Level1, Level2, class = "bsm") |> estimateComparison() -> Comparison
```

#### Display a Comparison

Present the comparison in a formatted table and plot.

``` r
Comparison |> style_matrix(title = "Table 4: Means and Confidence Intervals for a Comparison", style = "apa")
```


    Table 4: Means and Confidence Intervals for a Comparison 

    ----------------------------------------------------------------- 
                      Est         SE         df         LL         UL 
    ----------------------------------------------------------------- 
    Level1          8.000      0.447      9.000      6.988      9.012
    Level2         11.000      0.699      9.000      9.418     12.582
    Comparison      3.000      0.830     15.307      1.234      4.766 
    ----------------------------------------------------------------- 

``` r
Comparison |> plot_comparison(title = "Figure 4: Means and Confidence Intervals for a Comparison", values = TRUE)
```

![](figures/easi-case2-comparison-1.png)<!-- -->
