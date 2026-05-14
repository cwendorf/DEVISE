Data Helpers
================

## Data Helpers

This vignette demonstrates helper functions that operate on *raw data*,
building datasets and preparing variables and formulas for downstream
analysis functions.

- [Create Sample Data](#create-sample-data)
- [Evaluate Variables](#evaluate-variables)
- [Filter Formula Rows](#filter-formula-rows)

------------------------------------------------------------------------

### Create Sample Data

`create_groups()` constructs a factor grouping variable by repeating
labels according to the requested group sizes.

``` r
data.frame(
  Group = create_groups(k = 3, c(10, 10, 10), labels = c("Level1", "Level2", "Level3")),
  Outcome = c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9, 6, 7, 8, 6, 7, 9, 10, 8, 9, 10, 7, 8, 9, 7, 8, 10, 11, 9, 10, 11),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10, 7, 8, 9, 7, 8, 10, 11, 9, 10, 11, 8, 9, 10, 8, 9, 11, 12, 10, 11, 12)
) -> df

df
```

        Group Outcome Quiz Exam
    1  Level1       6    5    8
    2  Level1       8    6    7
    3  Level1       6    7    9
    4  Level1       8    5    6
    5  Level1      10    6    7
    6  Level1       8    8   10
    7  Level1      10    9    9
    8  Level1       9    7    9
    9  Level1       8    8    8
    10 Level1       7    9   10
    11 Level2       7    6    7
    12 Level2      13    7    8
    13 Level2      11    8    9
    14 Level2      10    6    7
    15 Level2      13    7    8
    16 Level2       8    9   10
    17 Level2      11   10   11
    18 Level2      14    8    9
    19 Level2      12    9   10
    20 Level2      11   10   11
    21 Level3       9    7    8
    22 Level3      16    8    9
    23 Level3      11    9   10
    24 Level3      12    7    8
    25 Level3      15    8    9
    26 Level3      13   10   11
    27 Level3       9   11   12
    28 Level3      14    9   10
    29 Level3      11   10   11
    30 Level3      10   11   12

### Evaluate Variables

`use_vars()` extracts one or more named columns from a data frame and
passes them to the next function. This avoids attaching the data frame
or creating temporary objects.

``` r
# Single variable
df |> use_vars(Quiz)
```

     [1]  5  6  7  5  6  8  9  7  8  9  6  7  8  6  7  9 10  8  9 10  7  8  9  7  8
    [26] 10 11  9 10 11

``` r
# Multiple variables
df |> use_vars(Quiz, Exam)
```

       Quiz Exam
    1     5    8
    2     6    7
    3     7    9
    4     5    6
    5     6    7
    6     8   10
    7     9    9
    8     7    9
    9     8    8
    10    9   10
    11    6    7
    12    7    8
    13    8    9
    14    6    7
    15    7    8
    16    9   10
    17   10   11
    18    8    9
    19    9   10
    20   10   11
    21    7    8
    22    8    9
    23    9   10
    24    7    8
    25    8    9
    26   10   11
    27   11   12
    28    9   10
    29   10   11
    30   11   12

`use_vars()` also accepts formula syntax, scoping the formula variables
to the data frame. This is useful for preparing inputs for model
functions.

``` r
# Formula captured from data columns
df |> use_vars(Quiz ~ Group)
```

    Quiz ~ Group
    <environment: 0x000002097788d728>

``` r
# View the model frame from the captured formula
df |> use_vars(Quiz ~ Group) |> model.frame()
```

       Quiz  Group
    1     5 Level1
    2     6 Level1
    3     7 Level1
    4     5 Level1
    5     6 Level1
    6     8 Level1
    7     9 Level1
    8     7 Level1
    9     8 Level1
    10    9 Level1
    11    6 Level2
    12    7 Level2
    13    8 Level2
    14    6 Level2
    15    7 Level2
    16    9 Level2
    17   10 Level2
    18    8 Level2
    19    9 Level2
    20   10 Level2
    21    7 Level3
    22    8 Level3
    23    9 Level3
    24    7 Level3
    25    8 Level3
    26   10 Level3
    27   11 Level3
    28    9 Level3
    29   10 Level3
    30   11 Level3

### Filter Formula Rows

`filter_rows()` restricts the data referenced by a formula to a subset
of groups and returns a formula with the filtered rows in its
environment. Use it when your downstream function expects a formula.

``` r
# Pipe-friendly with filter_rows()
df |> use_vars(Outcome ~ Group) |> filter_rows(Group == c("Level1", "Level2")) |> model.frame()
```

       Outcome  Group
    1        6 Level1
    2        8 Level1
    3        6 Level1
    4        8 Level1
    5       10 Level1
    6        8 Level1
    7       10 Level1
    8        9 Level1
    9        8 Level1
    10       7 Level1
    11       7 Level2
    12      13 Level2
    13      11 Level2
    14      10 Level2
    15      13 Level2
    16       8 Level2
    17      11 Level2
    18      14 Level2
    19      12 Level2
    20      11 Level2

``` r
# Use with a different subset and formula
df |> use_vars(Exam ~ Group + Quiz) |> filter_rows(Group == c("Level2", "Level3")) |> model.matrix()
```

       (Intercept) GroupLevel3 Quiz
    1            1           0    6
    2            1           0    7
    3            1           0    8
    4            1           0    6
    5            1           0    7
    6            1           0    9
    7            1           0   10
    8            1           0    8
    9            1           0    9
    10           1           0   10
    11           1           1    7
    12           1           1    8
    13           1           1    9
    14           1           1    7
    15           1           1    8
    16           1           1   10
    17           1           1   11
    18           1           1    9
    19           1           1   10
    20           1           1   11
    attr(,"assign")
    [1] 0 1 2
    attr(,"contrasts")
    attr(,"contrasts")$Group
    [1] "contr.treatment"
