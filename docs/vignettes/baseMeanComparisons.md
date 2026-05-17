# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Mean Comparisons with Base R

This vignette walks through a complete mean comparison workflow using
Base R for data entry and `DEVISE` for interval extraction and
visualization. Each step builds on the previous one, ending with a
comparison table and plot.

- [Confidence Intervals from Raw Data](#confidence-intervals-from-raw-data)

------------------------------------------------------------------------

### Confidence Intervals from Raw Data

Create a simple factor and outcome vector that will be used to compute
condition-specific statistics.

``` r
gl(3, 10, labels = c("Level1", "Level2", "Level3")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10) -> Outcome
```

Compute confidence intervals for each level and assemble them into a
conditions matrix.

``` r
Outcome[Factor == "Level1"] |> t.test() |> extract_intervals() -> Level1
Outcome[Factor == "Level2"] |> t.test() |> extract_intervals() -> Level2
Outcome[Factor == "Level3"] |> t.test() |> extract_intervals() -> Level3
rbind(Level1, Level2, Level3) |> name_rows(c("Level 1", "Level 2", "Level 3")) -> Conditions
```

Format the conditions matrix and visualize the confidence intervals.

``` r
Conditions |> style_matrix(title = "Table 1a: Means and Confidence Intervals for Conditions")
```


    Table 1a: Means and Confidence Intervals for Conditions 

              Estimate         LL         UL
    Level 1      8.000      6.988      9.012
    Level 2     11.000      9.418     12.582
    Level 3     12.000     10.248     13.752

``` r
Conditions |> plot_conditions(title = "Figure 1a: Means and Confidence Intervals for Conditions")
```

![](figures/base-case1-conditions-1.png)<!-- -->

Compute the comparison interval between the two selected conditions
directly in `t.test()`.

``` r
(Outcome ~ Factor) |> filter_rows(Factor == c("Level1", "Level2")) |>  t.test() |> extract_intervals() -> Difference
rbind(Level1, Level2, Difference) |> name_rows(c("Level 1", "Level 2", "Comparison")) -> Comparison
```

Present the comparison in a formatted table and plot.

``` r
Comparison |> style_matrix(title = "Table 1b: Means and Confidence Intervals for a Comparison")
```


    Table 1b: Means and Confidence Intervals for a Comparison 

                 Estimate         LL         UL
    Level 1         8.000      6.988      9.012
    Level 2        11.000      9.418     12.582
    Comparison      3.000      1.234      4.766

``` r
Comparison |> plot_comparison(title = "Figure 1b: Means and Confidence Intervals for a Comparison")
```

![](figures/base-case1-comparison-1.png)<!-- -->
