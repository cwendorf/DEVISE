# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Plot Comparison of Two Groups with Confidence Intervals

### Description

Plots two group means and their confidence intervals, along with their difference estimate.
Designed for paired or between-group comparisons.

### Usage

```r
plot_comparison(
  results,
  title = NULL,
  ylab = "Outcome",
  xlab = "",
  ylim = NULL,
  slab = "Difference",
  rope = NULL,
  digits = 3,
  values = FALSE,
  connect = FALSE,
  pos = c(2, 2, 4),
  pch = c(15, 15, 17),
  col = "black",
  offset = 0,
  points = TRUE,
  intervals = TRUE,
  lines = TRUE,
  ...
)
```

### Arguments

- **`results`**: A data frame or matrix with three rows: two group estimates and one difference row.
- **`title`**: Plot title. If NULL, uses the comment() attribute of results.
- **`ylab`**: Label for the Y-axis.
- **`xlab`**: Label for the X-axis.
- **`ylim`**: Numeric Y-axis limits. If NULL, auto-calculated.
- **`slab`**: Label for the secondary Y-axis (typically for difference).
- **`rope`**: Length-2 numeric vector for shading a region of practical equivalence for the difference.
- **`digits`**: Decimal places for numeric labels.
- **`values`**: Logical; display numeric values next to points and intervals.
- **`connect`**: Logical; connect the group estimates.
- **`pos`**: Text label positions.
- **`pch`**: Plotting characters for each point.
- **`col`**: Color for plot elements.
- **`offset`**: Horizontal offset to avoid overlap.
- **`points`**: Logical; draw points?
- **`intervals`**: Logical; draw confidence intervals?
- **`lines`**: Logical; draw lines from group points to the difference?
- **`...`**: Additional graphical parameters.

### Value

Invisibly returns the modified results object.

