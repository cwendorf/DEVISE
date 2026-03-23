# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Filter Rows Referenced by a Formula

**Aliases:**

- `filter_rows`

### Description

filter_rows() filters the variables referenced in a two-sided formula and
returns the same formula with an updated environment containing only the
filtered rows. This allows formula-based functions (for example, t.test())
to be used in a pipe-friendly workflow without creating temporary objects.

### Usage

```r
filter_rows(formula, condition)
```

### Arguments

- **`formula`**: A two-sided formula (for example, Outcome ~ Group).
- **`condition`**: A logical condition evaluated in the formula's model frame.

### Details

If condition is written as x == c("a", "b"), it is treated as
membership (x %in% c("a", "b")) to avoid element-wise recycling.

### Value

A formula with the same left- and right-hand sides as formula, but
whose environment contains only filtered rows.

### Examples

```r
# Base R t test with formula filtering in a pipe
gl(3, 10, labels = c("Level1", "Level2", "Level3")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7,
  7, 13, 11, 10, 13, 8, 11, 14, 12, 11,
  9, 16, 11, 12, 15, 13, 9, 14, 11, 10) -> Outcome

(Outcome ~ Factor) |>
  filter_rows(Factor == c("Level1", "Level2")) |>
  t.test() |>
  extract_intervals()

# Equivalent explicit condition form
(Outcome ~ Factor) |>
  filter_rows(Factor %in% c("Level2", "Level3")) |>
  t.test()
```