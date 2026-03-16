# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Compute Descriptive Statistics for Numeric Variables (fixed)

**Aliases:**

- `compute_descriptives`

### Description

Calculates N, mean and SD for numeric variables, optionally grouped.
Accepts either:

 no args: all numeric vars,
 bare var names:  e.g. x, y or c(x,y),
 a formula: vars ~ group or ~ group.

### Usage

```r
compute_descriptives(data, ...)
```

### Arguments

- **`data`**: data.frame
- **`...`**: bare variable names (unquoted), or a single formula (e.g. x ~ Group,
c(x,y) ~ Group, or ~ Group). If omitted, all numeric variables are used.

### Details

If grouped and exactly one measured variable is requested, the function
returns a single matrix with groups as rownames (auto-collapsed).
If grouped with multiple measured variables, returns a named list of matrices.

### Value

matrix (ungrouped), matrix (grouped + single var), or list of matrices (grouped + multiple vars)

### Examples

```r
data.frame(
  Group = rep(c("A","B"), each = 5),
  x = c(1,2,3,4,5, 2,3,4,5,6),
  y = c(5,4,3,2,1, 6,7,8,9,10)
) -> df
df |> compute_descriptives()
df |> compute_descriptives(x, y)
df |> compute_descriptives(x ~ Group)
df |> compute_descriptives(c(x,y) ~ Group)
```

