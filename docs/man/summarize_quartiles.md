# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Summarize Quartiles for Numeric Variables

### Description

Summarizes sample size, median, and IQR for selected numeric variables, optionally grouped by a single factor.

### Usage

```r
summarize_quartiles(data, ...)
```

### Arguments

- **`data`**: data.frame
- **`...`**: bare variable names (unquoted), or a single formula (e.g. x ~ Group, c(x,y) ~ Group, or ~ Group). If omitted, all numeric variables are used.

### Value

matrix (ungrouped), matrix (grouped + single var), or list of matrices (grouped + multiple vars)

### Examples

```r
data.frame(
  Group = rep(c("A","B"), each = 5),
  x = c(1,2,3,4,5, 2,3,4,5,6),
  y = c(5,4,3,2,1, 6,7,8,9,10)
) -> df
df |> summarize_quartiles()
df |> summarize_quartiles(x, y)
df |> summarize_quartiles(x ~ Group)
df |> summarize_quartiles(c(x,y) ~ Group)
```
