# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Set Column Names of a Data Frame

**Aliases:**

- `name_columns`

### Description

Assign column names to a data frame in a pipe-friendly way.

### Usage

```r
name_columns(x, names)
```

### Arguments

- **`x`**: A data frame.
- **`names`**: A character vector of column names. Must have length equal to ncol(x).

### Details

Note: This function does not modify the original data frame in place. You must assign the result back to a variable if using outside of a pipe.

### Value

A data frame identical to x but with updated column names.

### Examples

```r
# Basic usage
data.frame(a = 1:3, b = 4:6) -> df
df |> name_columns(c("First", "Second")) -> df  # Must assign back to df

# Within-pipe renaming
data.frame(c(10, 0, 5), c(8, -1, 4), c(12, 1, 6)) -> df
df |> name_columns(c("Estimate", "LL", "UL")) -> Results
```

