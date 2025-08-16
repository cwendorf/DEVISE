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



### Direct Input

c(Estimate = 8.000, LL = 6.988, UL = 9.012) -> Level1
c(Estimate = 11.000, LL = 9.418, UL = 12.582) -> Level2
c(Estimate = 3.000, LL = 1.234, UL = 4.766) -> Comparison
rbind(Level1, Level2, Comparison) -> Results

Results |> render(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)
