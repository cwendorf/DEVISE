# DEVISE
## Comparison Vignette with backcalc

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/backcalc/main/source-backcalc.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics (using Summary Statistics Input)

backcalc_means(m = 8.000, sd = 1.414, n = 10) -> Level1
backcalc_means(m = 11.000, sd = 2.211, n = 10) -> Level2
backcalc_means(m = 12.000, sd = 2.162, n = 10) -> Level3

rbind(Level1, Level2, Level3) |> extract_intervals() -> Conditions
c("Level1", "Level2", "Level3") -> rownames(Conditions)

### Display the Conditions

Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 1: Conditions Confidence Intervals", values = TRUE)

### Obtain the Comparison Statistics (Level1 vs Level2)

backcalc_means(m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) |> extract_intervals() -> Difference

rbind(Level1, Level2, Difference) -> Comparison
c("Level1", "Level2", "Difference") -> rownames(Comparison)

### Display the Comparison

Comparison |> style_matrix(title = "Table 2: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
