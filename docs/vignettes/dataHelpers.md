# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Data Helpers

This vignette demonstrates data helper functions for selecting rows and
columns, renaming, extracting vectors, and retaining intermediate
results.

- [Case 1: Create a Data Set](#case-1:-create-a-data-set)
- [Case 2: Select and Rename Data](#case-2:-select-and-rename-data)
- [Case 3: Extract Vectors from
  Results](#case-3:-extract-vectors-from-results)
- [Case 4: Use Objects in Pipelines](#case-4:-use-objects-in-pipelines)

------------------------------------------------------------------------

### Case 1: Create a Data Set

`create_groups()` constructs a grouping variable by repeating labels
according to the requested group sizes. In this example, it’s used in
conjunction with building an entire data frame.

``` r
data.frame(
  Group = create_groups(k = 3, c(10, 10, 10), labels = c("Level1", "Level2", "Level3")),
  Outcome = c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9, 6, 7, 8, 6, 7, 9, 10, 8, 9, 10, 7, 8, 9, 7, 8, 10, 11, 9, 10, 11),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10, 7, 8, 9, 7, 8, 10, 11, 9, 10, 11, 8, 9, 10, 8, 9, 11, 12, 10, 11, 12)
) -> df

df |> head()
```

       Group Outcome Quiz Exam
    1 Level1       6    5    8
    2 Level1       8    6    7
    3 Level1       6    7    9
    4 Level1       8    5    6
    5 Level1      10    6    7
    6 Level1       8    8   10

### Case 2: Select and Rename Data

Use extraction helpers to keep only the rows and columns needed for a
specific task.

``` r
df |> extract_columns(c("Group", "Outcome", "Quiz")) -> selected_cols
selected_cols |> head()
```

       Group Outcome Quiz
    1 Level1       6    5
    2 Level1       8    6
    3 Level1       6    7
    4 Level1       8    5
    5 Level1      10    6
    6 Level1       8    8

``` r
selected_cols |> extract_rows(c(1, 10, 20, 30)) -> selected_rows
selected_rows
```

        Group Outcome Quiz
    1  Level1       6    5
    10 Level1       7    9
    20 Level2      11   10
    30 Level3      10   11

``` r
selected_rows |> name_columns(c("Condition", "Response", "QuizScore")) -> renamed_cols
renamed_cols
```

       Condition Response QuizScore
    1     Level1        6         5
    10    Level1        7         9
    20    Level2       11        10
    30    Level3       10        11

``` r
renamed_cols |> name_rows(c("Case1", "Case10", "Case20", "Case30")) -> renamed_rows
renamed_rows
```

           Condition Response QuizScore
    Case1     Level1        6         5
    Case10    Level1        7         9
    Case20    Level2       11        10
    Case30    Level3       10        11

### Case 3: Extract Vectors from Results

`extract_vector()` can pull a single column (for reporting) or a single
row (for follow-up calculations).

``` r
df |> compute_descriptives(Outcome ~ Group) -> descriptives
descriptives
```

            N  M       SD
    Level1 10  8 1.414214
    Level2 10 11 2.211083
    Level3 10 12 2.449490

``` r
descriptives |> extract_vector("M") -> means
means
```

    Level1 Level2 Level3 
         8     11     12 

``` r
descriptives |> extract_vector("Level2") -> level2_stats
level2_stats
```

            N         M        SD 
    10.000000 11.000000  2.211083 

### Case 4: Use Objects in Pipelines

`use_vars()` helps evaluate variables and formulas inside pipelines.

``` r
df |> use_vars(Quiz, Exam) |> cor()
```

              Quiz      Exam
    Quiz 1.0000000 0.9440688
    Exam 0.9440688 1.0000000
