# Extract Columns from Data Frame, Matrix, or List

**Aliases:**

- `extract_columns`

## Description

Extract specified columns from a data frame, matrix, or list of such objects.

## Usage

```r
extract_columns(out, cols = NULL)
```

## Arguments

- **`out`**: A data frame, matrix, atomic vector, or a list of such objects.
- **`cols`**: A numeric vector of column indices or a character vector of column names to keep. If NULL, all columns are returned or selected by intervals() if available.

## Value

The filtered object with only the specified columns. The output type matches the input (matrix, data frame, or list).

## Examples

```r
data.frame(Estimate = 1:3, SE = 0.1, Extra = 4:6) -> df
df |> extract_columns(c("Estimate", "SE"))
```

