# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Summarize Correlation or Covariance Matrices

### Description

Summarizes a correlation or covariance matrix for selected numeric variables in a data frame,
optionally grouped by a factor using a formula or bare variable names.

### Usage

```r
summarize_relationships(data, ..., type = "cor", method = "pearson")
```

### Arguments

- **`data`**: A data frame containing the variables of interest.
- **`...`**: One or more expressions: A formula (e.g., ~ group or y1 + y2 ~ group) to specify grouping and optionally variables. One or more bare variable names (e.g., x1, x2). If omitted, all numeric variables in data are used.
- **`type`**: Character string indicating whether to compute "cor" (correlation) or "cov" (covariance).
Default is "cor".
- **`method`**: Character string specifying the correlation method: one of "pearson" (default), "spearman", or "kendall".
Ignored if type = "cov".

### Value

If no grouping is specified: returns a correlation or covariance matrix. If a grouping formula is specified: returns a named list of matrices, one per group level.

### Examples

```r
# Correlation matrix for all numeric variables
iris |> summarize_relationships()

# Covariance matrix for specific variables
iris |> summarize_relationships(Sepal.Length, Petal.Length, type = "cov")

# Grouped correlation matrices by Species
iris |> summarize_relationships(~ Species)

# Grouped correlation matrices for specific variables
iris |> summarize_relationships(Sepal.Length, Petal.Length ~ Species)
```
