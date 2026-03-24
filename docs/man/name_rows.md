# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Set Row Names of a Data Frame

### Description

Assign row names to a data frame in a pipe-friendly way.

### Usage

```r
name_rows(x, names)
```

### Arguments

- **`x`**: A data frame.
- **`names`**: A character vector of row names. Must have length equal to nrow(x).

### Details

Note: This function does not modify the original data frame in place. You must assign the result back to a variable.

### Value

A data frame identical to x but with updated row names.

### Examples

```r
# Basic usage
data.frame(a = 1:3, b = 4:6) -> df
df |> name_rows(c("A", "B", "C")) -> df  # Must assign back to df

# Within-pipe renaming
data.frame(c(10, 0, 5), c(8, -1, 4), c(12, 1, 6)) -> df
df |> name_rows(c("Group1", "Group2", "Group3")) -> Results
```

