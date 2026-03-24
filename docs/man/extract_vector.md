# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Extract Row or Column as Named Vector from Data Frame or Matrix

### Description

Extract a single row or column from a matrix or data frame as a named vector.

### Usage

```r
extract_vector(data, index)
```

### Arguments

- **`data`**: A matrix or data frame from which to extract data.
- **`index`**: A character or numeric value specifying the row or column to extract. If character, it is matched against row names first, then column names. If numeric, it is interpreted as a row index first, then a column index.

### Details

This function automatically detects whether the input corresponds to a row or a column and returns the result as a named vector. Names are preserved from the opposite dimension (column names for rows, row names for columns).

### Value

A named vector containing the extracted row or column values.

### Examples

```r
data.frame(
  M = c(1.1, 2.2, 3.3),
  SD = c(0.1, 0.2, 0.3),
  N = c(10, 20, 30),
  row.names = c("Group1", "Group2", "Group3")
) -> df
df |> extract_vector("M")
df |> extract_vector("Group2")
```

