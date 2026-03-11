# Plot Point Estimates with Confidence Intervals

**Aliases:**

- `plot_conditions`

## Description

Plots a set of point estimates and their confidence intervals for multiple conditions or outcomes.

## Usage

```r
plot_conditions(
  results,
  title = NULL,
  ylab = "Outcome",
  xlab = "",
  ylim = NULL,
  digits = 3,
  offset = 0,
  pch = 16,
  col = "black",
  points = TRUE,
  intervals = TRUE,
  values = FALSE,
  pos = 2,
  connect = FALSE,
  line = NULL,
  rope = NULL,
  ...
)
```

## Arguments

- **`results`**: A data frame or matrix with point estimates in the first column,
and confidence limits in columns named like "ll", "ul", "ci_lower", "ci_upper".
- **`title`**: Plot title. If NULL, uses the comment() attribute of results.
- **`ylab`**: Label for the Y-axis.
- **`xlab`**: Label for the X-axis.
- **`ylim`**: Numeric Y-axis limits. If NULL, limits are auto-calculated.
- **`digits`**: Decimal places for value labels if values = TRUE.
- **`offset`**: Horizontal offset for plotted points (for overlap adjustment).
- **`pch`**: Plotting character.
- **`col`**: Color for points and intervals.
- **`points`**: Logical; if TRUE, draw point estimates.
- **`intervals`**: Logical; if TRUE, draw confidence intervals.
- **`values`**: Logical; if TRUE, display numeric values next to points and intervals.
- **`pos`**: Position for text labels (see text()).
- **`connect`**: Logical; if TRUE, connect adjacent points with lines.
- **`line`**: Draw a horizontal reference line at this Y value.
- **`rope`**: Length-2 numeric vector for shading a region of practical equivalence.
- **`...`**: Additional graphical parameters passed to plot().

## Value

Invisibly returns the modified results object.

