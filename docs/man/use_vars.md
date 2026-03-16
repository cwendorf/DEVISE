# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Select Variables or Formulas from a Data Frame

**Aliases:**

- `use_vars`

### Description

use_vars() evaluates one or more expressions within the context of a data frame.
This can include formulas (e.g., y ~ x) or bare variable names. The result
is pipe-friendly and adapts depending on whether you select a single variable,
multiple variables, or a formula.

### Usage

```r
use_vars(data, ...)
```

### Arguments

- **`data`**: A data frame providing the evaluation context.
- **`...`**: One or more expressions:

 A formula (e.g., y ~ x1 + x2) for use with modeling functions.
 One or more bare variable names (e.g., x1, x2).

### Value

If a single variable is provided: returns a vector.
 If multiple variables are provided: returns a data frame.
 If a formula is provided: returns a data frame with the selected variables,
and the original formula is preserved as an attribute for use by functions
like lm(), glm(), or t.test().

### Examples

```r
data.frame(
  y = 1:5,
  x1 = c(1,1,1,2,2),
  x2 = c(5,4,3,2,1),
  x3 = c(10,20,30,40,50)
) -> df

# Use a formula for modeling
df |> use_vars(y ~ x1) |> t.test()
df |> use_vars(y ~ x1 + x2) |> lm() |> summary()

# Use a single variable
df |> use_vars(x3)

# Use multiple variables
df |> use_vars(x1, x2) |> cor()
```

