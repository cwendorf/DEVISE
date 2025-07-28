# DEVISE
## Interfacing with `backcalc`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/backcalc/main/source-backcalc.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Examples

# 1. Direct estimate with SE and sample size (minimal inference, t-distribution used)
backcalc_means(m = 25.4, se = 2.1, n = 30)
backcalc_means(m = 25.4, se = 2.1, n = 30) |> format_table()
backcalc_means(m = 25.4, se = 2.1, n = 30) |> style_md()
backcalc_means(m = 25.4, se = 2.1, n = 30) |> format_table() |> style_apa()

# 6. Means, SDs, and ns provided (calculate difference, SE, df)
backcalc_means(m = c(15, 12), sd = c(4, 5), n = c(40, 35))
backcalc_means(m = c(15, 12), sd = c(4, 5), n = c(40, 35)) |> format_table()
backcalc_means(m = c(15, 12), sd = c(4, 5), n = c(40, 35)) |> format_table() |> style_md()
backcalc_means(m = c(15, 12), sd = c(4, 5), n = c(40, 35)) |> format_table() |> style_apa()

# 9. Means and confidence interval provided (infer SE, df)
backcalc_means(m = c(100, 90), ci = c(2, 18), n = c(50, 45))
backcalc_means(m = c(100, 90), ci = c(2, 18), n = c(50, 45)) |> format_table(digits=3, width=8)
backcalc_means(m = c(100, 90), ci = c(2, 18), n = c(50, 45)) |> format_table(digits=3, width=8) |> style_apa()
backcalc_means(m = c(100, 90), ci = c(2, 18), n = c(50, 45)) |> format_table(digits=3, width=8) |> style_md()

backcalc_means(m = 25.4, se = 2.1, n = 30, digits=4)
backcalc_means(m = 25.4, se = 2.1, n = 30) |> format_table(digits = 4)


# Plotting

backcalc_means(m = 25.4, se = 2.1, n = 30, digits=4)


y1 <- 10:30
my1 <- mean(y1)
sdy1 <- sd(y1)
ny1 <- length(y1)

y2 <- 1:30
my2 <- mean(y2)
sdy2 <- sd(y2)
ny2 <- length(y2)

backcalc_means(m = my1, sd = sdy1, n = ny1) -> group1
backcalc_means(m = my2, sd = sdy2, n = ny2) -> group2
backcalc_means(m = c(my2, my1), sd = c(sdy2, sdy1), n = c(ny2, ny1)) -> compare
results
results |> format_table()
results |> plot_comp(main = "Comparison Plot",values=TRUE)
