# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Extract Rows from Data Frame, Matrix, or List

### Description

Extract specified rows from a data frame, matrix, or list of such objects.

### Usage

```r
extract_rows(out, rows = NULL)
```

### Arguments

- **`out`**: A data frame, matrix, atomic vector, or a list of such objects.
- **`rows`**: A numeric vector of row indices or a character vector of row names to retain. If NULL, all rows are returned.

### Value

The filtered object with only the specified rows. The output type matches the input (matrix, data frame, or list).

### Examples

```r
data.frame(A = 1:5, B = letters[1:5]) -> df
df |> extract_rows(c(1, 3))
```

