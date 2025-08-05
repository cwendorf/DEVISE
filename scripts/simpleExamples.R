# DEVISE
## Simple Examples

### Display Summary Statistics

mtcars |> describe(vars = c("mpg", "hp")) |> print_matrix(title = "Table 1: Descriptive Statistics", style = "apa")
mtcars |> correlate(vars = c("mpg", "hp"), type = "cov") |> print_matrix(title = "Table 2: Covariance Matrix", style = "apa")

### Write to a File

sink("Results.txt") # Create file and start redirecting
mtcars |> describe(vars = c("mpg", "hp")) |> print_matrix(title = "Table 1: Descriptive Statistics", style = "apa")
mtcars |> correlate(vars = c("mpg", "hp")) |> print_matrix(title = "Table 2: Corrrelation Matrix", style = "apa")
sink()  # Stop redirecting

### Extract a Vector

mtcars |> describe(vars = c("mpg", "hp")) |> extract("N")
mtcars |> describe(vars = c("mpg", "hp")) |> extract("M")
mtcars |> describe(vars = c("mpg", "hp")) |> extract("SD")
