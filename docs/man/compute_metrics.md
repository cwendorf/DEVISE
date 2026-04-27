# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Compute Additional Metrics for Statistical Estimates

### Description

This function computes additional metrics (Width, Margin of Error, Relative Width)
for a data frame of estimates with confidence intervals. If a ROPE is provided,
it also computes the Second Generation P-Value (SGPV).

### Usage

```r
compute_metrics(input, rope = NULL)
```

### Arguments

- **`input`**: A data frame containing at least the columns "Estimate", "LL", and "UL",
where "LL" and "UL" represent the lower and upper bounds of a confidence interval, respectively.
- **`rope`**: Optional length-2 numeric vector `c(lower, upper)` defining the Region of Practical Equivalence.
If provided, an `SGPV` column is added.

### Value

A data frame identical to input, with additional columns: Width: The width of the confidence interval (UL - LL).
MoE: The margin of error (Width / 2). RW: The relative width of the interval (Width / abs(Estimate)). Returns NA if Estimate is zero.
SGPV: If rope is provided, the proportion of CI overlap with the ROPE (|CI ∩ ROPE| / |CI|).

### Examples

```r
cbind(Estimate = c(10, 0, 5), LL = c(8, -1, 4), UL = c(12, 1, 6)) -> df
c("A", "B", "C") -> rownames(df)
df |> compute_metrics()
df |> compute_metrics(rope = c(-1, 1))
```

