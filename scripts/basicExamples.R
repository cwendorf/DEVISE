# DEVISE
## Some DEVISE Basics

### Descriptive Statistics

describe(mtcars, vars = c("mpg", "hp"))
describe(mtcars, vars = c("mpg", "hp")) |> print_matrix()

### Correlation and Variance-Covariance Matrix

correlate(mtcars, vars = c("mpg", "hp"))
correlate(mtcars, vars = c("mpg", "hp"), type = "cov") |> print_matrix()


### Extract Vector

input <- data.frame(
   m = c(1.1, 2.2, 3.3),
   sd = c(0.1, 0.2, 0.3),
   n = c(10, 20, 30),
   row.names = c("group1", "group2", "group3")
)

extract(input,"m")
extract(input,"sd")
extract(input,"n")


### Write to a File

sink("output.txt") # Create file and start redirecting
describe(mtcars, vars = c("mpg", "hp")) |> print_matrix(title = "Table 1\nDescriptive Statistics", style = "apa")
correlate(mtcars, vars = c("mpg", "hp")) |> print_matrix(title = "Table 2\nCorrrelations", style = "apa")
sink()  # Stop redirecting

