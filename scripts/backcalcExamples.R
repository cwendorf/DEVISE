# DEVISE
## Interfacing with `backcalc`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/backcalc/main/source-backcalc.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Examples

# 1. Direct estimate with SE and sample size (minimal inference, t-distribution used)
backcalc_means(m = 25.4, se = 2.1, n = 30)
backcalc_means(m = 25.4, se = 2.1, n = 30) |> print_matrix()

# 6. Means, SDs, and ns provided (calculate difference, SE, df)
backcalc_means(m = c(15, 12), sd = c(4, 5), n = c(40, 35))
backcalc_means(m = c(15, 12), sd = c(4, 5), n = c(40, 35)) |> print_matrix()

# 9. Means and confidence interval provided (infer SE, df)
backcalc_means(m = c(100, 90), ci = c(2, 18), n = c(50, 45))
backcalc_means(m = c(100, 90), ci = c(2, 18), n = c(50, 45)) |> print_matrix(digits = 4, style = "apa")

backcalc_means(m = 25.4, se = 2.1, n = 30)
backcalc_means(m = 25.4, se = 2.1, n = 30) |> print_matrix(digits = 4, style = "apa")


### Input Summary

backcalc_means(m = 8.000, sd = 1.414, n = 10) -> Level1
backcalc_means(m = 11.000, sd = 2.2111, n = 10) -> Level2
backcalc_means(m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) -> Comparison
Results <- rbind(Level1, Level2, Comparison)
rownames(Results) <- c("Level1", "Level2", "Comparison")

### Results

Results
Results |> print_matrix(style = "apa", digits = 4)
Results |> plot_comp(title = "Comparison Plot", values = TRUE)

