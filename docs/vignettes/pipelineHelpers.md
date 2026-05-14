Pipeline Helpers
================

## Pipeline Helpers

Several `DEVISE` helpers are not specific to any analysis stage — they
work equally well on raw data frames and on result matrices produced by
analysis functions. These functions support a general pipe-and-assign
style and can appear anywhere in a pipeline.

- [Create Sample Data](#create-sample-data)
- [Extracting Columns and Rows](#extracting-columns-and-rows)
- [Relabeling Rows and Columns](#relabeling-rows-and-columns)
- [Capturing an Object Mid-Pipeline](#capturing-an-object-mid-pipeline)

------------------------------------------------------------------------

### Create Sample Data

Create a sample dataset with groups and multiple variables for
demonstration purposes.

### Extracting Columns and Rows

`extract_columns()` keeps only the specified columns, accepting either
names or numeric indices. It preserves the object type — a data frame
in, a data frame out; a matrix in, a matrix out.

``` r
# By name
df |> extract_columns(c("Group", "Quiz"))
```

        Group Quiz
    1  Level1    5
    2  Level1    6
    3  Level1    7
    4  Level1    5
    5  Level1    6
    6  Level1    8
    7  Level1    9
    8  Level1    7
    9  Level1    8
    10 Level1    9
    11 Level2    6
    12 Level2    7
    13 Level2    8
    14 Level2    6
    15 Level2    7
    16 Level2    9
    17 Level2   10
    18 Level2    8
    19 Level2    9
    20 Level2   10
    21 Level3    7
    22 Level3    8
    23 Level3    9
    24 Level3    7
    25 Level3    8
    26 Level3   10
    27 Level3   11
    28 Level3    9
    29 Level3   10
    30 Level3   11

``` r
# By index
df |> extract_columns(c(1, 3))
```

        Group Quiz
    1  Level1    5
    2  Level1    6
    3  Level1    7
    4  Level1    5
    5  Level1    6
    6  Level1    8
    7  Level1    9
    8  Level1    7
    9  Level1    8
    10 Level1    9
    11 Level2    6
    12 Level2    7
    13 Level2    8
    14 Level2    6
    15 Level2    7
    16 Level2    9
    17 Level2   10
    18 Level2    8
    19 Level2    9
    20 Level2   10
    21 Level3    7
    22 Level3    8
    23 Level3    9
    24 Level3    7
    25 Level3    8
    26 Level3   10
    27 Level3   11
    28 Level3    9
    29 Level3   10
    30 Level3   11

`extract_rows()` keeps only the specified rows, accepting numeric
indices or row names. Like `extract_columns()`, it is type-preserving.

``` r
# By numeric index
df |> extract_rows(c(1, 11, 21))
```

        Group Outcome Quiz
    1  Level1       6    5
    11 Level2       7    6
    21 Level3       9    7

``` r
# By row name number
df |>
  extract_columns(c("Group", "Outcome")) |>
  extract_rows(c(1, 11, 21))
```

        Group Outcome
    1  Level1       6
    11 Level2       7
    21 Level3       9

`extract_vector()` returns a single row or column as a named vector.
This is useful when you need one slice of a data frame or matrix inside
a pipeline.

``` r
# Extract a column vector
df |> extract_vector("Outcome")
```

     1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 
     6  8  6  8 10  8 10  9  8  7  7 13 11 10 13  8 11 14 12 11  9 16 11 12 15 13 
    27 28 29 30 
     9 14 11 10 

### Relabeling Rows and Columns

`name_rows()` and `name_columns()` assign new labels in-place within a
pipeline. They work on any data frame or matrix and do not require a
temporary assignment between steps.

``` r
# Rename columns on a data frame
df |>
  extract_columns(c("Group", "Outcome")) |>
  name_columns(c("Condition", "Response"))
```

       Condition Response
    1     Level1        6
    2     Level1        8
    3     Level1        6
    4     Level1        8
    5     Level1       10
    6     Level1        8
    7     Level1       10
    8     Level1        9
    9     Level1        8
    10    Level1        7
    11    Level2        7
    12    Level2       13
    13    Level2       11
    14    Level2       10
    15    Level2       13
    16    Level2        8
    17    Level2       11
    18    Level2       14
    19    Level2       12
    20    Level2       11
    21    Level3        9
    22    Level3       16
    23    Level3       11
    24    Level3       12
    25    Level3       15
    26    Level3       13
    27    Level3        9
    28    Level3       14
    29    Level3       11
    30    Level3       10

``` r
# Rename rows and columns on df-derived subset
df |>
  extract_columns(c("Outcome", "Quiz")) |>
  extract_rows(c(1, 11, 21)) |>
  name_rows(c("RowA", "RowB", "RowC")) |>
  name_columns(c("Pre", "Post"))
```

         Pre Post
    RowA   6    5
    RowB   7    6
    RowC   9    7

### Capturing an Object Mid-Pipeline

`keep_as()` saves the current pipeline value under a name in the calling
environment and then passes the value through unchanged. Use it whenever
you need to retain an intermediate result without branching the pipeline
into a separate assignment statement.

``` r
# Save the full data frame, then continue narrowing it
df |>
  keep_as(full_df) |>
  extract_columns(c("Group", "Outcome")) |>
  keep_as(narrow_df)

nrow(full_df)
```

    [1] 30

``` r
nrow(narrow_df)
```

    [1] 30
