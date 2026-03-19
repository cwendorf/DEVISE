# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Basic Workflow

`DEVISE` utilizes forward assignment (`->`) and pipe operators (`|>`) to
keep examples readable and consistent. The goal is to read code
left-to-right, from data creation to transformed output.

- [Case 1: Using Forward Assignment](#case-1-using-forward-assignment)
- [Case 2: Using Pipe Operators](#case-2-using-pipe-operators)

------------------------------------------------------------------------

### Case 1: Using Forward Assignment

To minimize visual backtracking, avoid left assignment (`<-`). Instead,
use `->` to store objects after they are computed. This keeps the focus
on the computation itself.

``` r
data.frame(
  Group = rep(c("Group1", "Group2"), each = 5),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10)
) -> df

head(df)
```

       Group Quiz Exam
    1 Group1    5    8
    2 Group1    6    7
    3 Group1    7    9
    4 Group1    5    6
    5 Group1    6    7
    6 Group2    8   10

### Case 2: Using Pipe Operators

To keep data flowing, pipe operators (`|>`) show step-by-step
transformations. They help express a sequence of operations without
temporary assignment.

``` r
df |> subset(Group == "Group1") |> head()
```

       Group Quiz Exam
    1 Group1    5    8
    2 Group1    6    7
    3 Group1    7    9
    4 Group1    5    6
    5 Group1    6    7

``` r
df |> transform(Total = Quiz + Exam) |> head()
```

       Group Quiz Exam Total
    1 Group1    5    8    13
    2 Group1    6    7    13
    3 Group1    7    9    16
    4 Group1    5    6    11
    5 Group1    6    7    13
    6 Group2    8   10    18
