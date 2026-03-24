# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Style and Print a Formatted Matrix

### Description

Style and print a numeric matrix using a specified formatting style (plain or APA).

### Usage

```r
style_matrix(
  results,
  digits = 3,
  padding = 0,
  width = 10,
  title = NULL,
  spacing = 1,
  style = "plain",
  ...
)
```

### Arguments

- **`results`**: A numeric matrix.
- **`digits`**: Number of decimal places to round to.
- **`padding`**: Extra space padding around values.
- **`width`**: Fixed width for each column. If NULL, auto-computed.
- **`title`**: Optional title printed above the matrix.
- **`spacing`**: Lines of vertical space before/after matrix.
- **`style`**: One of "plain" (default) or "apa".
- **`...`**: Additional formatting arguments.

### Value

Returns the formatted character matrix.

