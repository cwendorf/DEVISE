# DEVISE
## Simple Examples

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Display Summary Statistics

mtcars |> describe(vars = c("mpg", "hp")) |> render(title = "Table 1: Descriptive Statistics", style = "apa")
mtcars |> correlate(vars = c("mpg", "hp"), type = "cov") |> render(title = "Table 2: Covariance Matrix", style = "apa")

### Write to a File

sink("Results.txt") # Create file and start redirecting
mtcars |> describe(vars = c("mpg", "hp")) |> render(title = "Table 1: Descriptive Statistics", style = "apa")
mtcars |> correlate(vars = c("mpg", "hp")) |> render(title = "Table 2: Corrrelation Matrix", style = "apa")
sink()  # Stop redirecting

### Extract a Vector

mtcars |> describe(vars = c("mpg", "hp")) |> extract("N")
mtcars |> describe(vars = c("mpg", "hp")) |> extract("M")
mtcars |> describe(vars = c("mpg", "hp")) |> extract("SD")
