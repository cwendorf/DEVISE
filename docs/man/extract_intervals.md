# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Extract Point Estimate and Confidence Interval Columns

**Aliases:**

- `extract_intervals`

### Description

Extract the point estimate and confidence interval columns from a data frame, matrix, list, or t.test result.

### Usage

```r
extract_intervals(x)
```

### Arguments

- **`x`**: A data frame, matrix, list with 'estimate' and 'interval' (or 'conf.int') elements, or a t.test (htest) result.

### Value

A matrix with columns: Estimate, LL, UL.

### Examples

```r
cbind(Estimate = c(10, 0, 5), LL = c(8, -1, 4), UL = c(12, 1, 6)) -> df
c("A", "B", "C") -> rownames(df)
df |> extract_intervals()

# t.test result
set.seed(1); rnorm(20, 10, 2) -> x
t.test(x) |> extract_intervals()
```

