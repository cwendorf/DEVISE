# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Basic Workflow

`DEVISE` utilizes forward assignment (`->`) and pipe operators (`|>`) to
keep examples readable and consistent. The overall goal is to read code
left-to-right, from data creation to transformed output.

- [Using Forward Assignment](#using-forward-assignment)
- [Using Pipe Operators](#using-pipe-operators)
- [Extending the Workflow](#extending-the-workflow)

------------------------------------------------------------------------

### Using Forward Assignment

To minimize visual backtracking, avoid left assignment (`<-`). Instead,
use `->` to store objects after they are computed. This keeps the focus
on the computation itself.

``` r
data.frame(
  Group = rep(c("Group1", "Group2"), each = 5),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10)
) -> df

df
```

        Group Quiz Exam
    1  Group1    5    8
    2  Group1    6    7
    3  Group1    7    9
    4  Group1    5    6
    5  Group1    6    7
    6  Group2    8   10
    7  Group2    9    9
    8  Group2    7    9
    9  Group2    8    8
    10 Group2    9   10

### Using Pipe Operators

To keep data flowing, pipe operators (`|>`) show step-by-step
transformations. They help express a sequence of operations without
temporary assignment.

``` r
df |> subset(Group == "Group1")
```

       Group Quiz Exam
    1 Group1    5    8
    2 Group1    6    7
    3 Group1    7    9
    4 Group1    5    6
    5 Group1    6    7

``` r
df |> transform(Total = Quiz + Exam)
```

        Group Quiz Exam Total
    1  Group1    5    8    13
    2  Group1    6    7    13
    3  Group1    7    9    16
    4  Group1    5    6    11
    5  Group1    6    7    13
    6  Group2    8   10    18
    7  Group2    9    9    18
    8  Group2    7    9    16
    9  Group2    8    8    16
    10 Group2    9   10    19

When several operations are needed, chain them in one pipeline so each
step builds directly on the previous one. This keeps the workflow
compact and readable from left to right.

``` r
df |>
  subset(Group == "Group1") |>
  transform(Total = Quiz + Exam)
```

       Group Quiz Exam Total
    1 Group1    5    8    13
    2 Group1    6    7    13
    3 Group1    7    9    16
    4 Group1    5    6    11
    5 Group1    6    7    13

If the chained result will be reused later, capture it with forward
assignment at the end.

``` r
df |>
  subset(Group == "Group2") |>
  transform(Total = Quiz + Exam) -> group2_with_total

group2_with_total
```

        Group Quiz Exam Total
    6  Group2    8   10    18
    7  Group2    9    9    18
    8  Group2    7    9    16
    9  Group2    8    8    16
    10 Group2    9   10    19

### Extending the Workflow

`DEVISE` provides additional functions for data manipulation, result
standardization, and visualization. They are designed to work seamlessly
with forward assignment and pipe operators.

``` r
df |>
  compute_descriptives(Quiz ~ Group) |>
  name_rows(c("First Class", "Second Class")) |>
  style_matrix(title = "Table 1: Quiz Descriptives by Class", style = "apa")
```


    Table 1: Quiz Descriptives by Class 

    --------------------------------------------- 
                          N          M         SD 
    --------------------------------------------- 
    First Class       5.000      5.800      0.837
    Second Class      5.000      8.200      0.837 
    --------------------------------------------- 

For detailed information on all available functions, visit the Reference
documentation.
