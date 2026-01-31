# DEVISE
## Comparison Vignettes with Direct Input

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Input the Statistics for Each Condition

c(Estimate = 8.000, LL = 6.988, UL = 9.012) -> Level1
c(Estimate = 11.000, LL = 9.418, UL = 12.582) -> Level2
c(Estimate = 12.000, LL = 10.248, UL = 13.752) -> Level3

rbind(Level1, Level2, Level3) -> Conditions
c("Level1", "Level2", "Level3") -> rownames(Conditions)

### Display the Conditions

Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 1: Conditions Confidence Intervals", values = TRUE)

### Input the Comparison Statistics

c(Estimate = 3.000, LL = 1.234, UL = 4.766) -> Difference

rbind(Level1, Level2, Difference) -> Comparison
c("Level1", "Level2", "Difference") -> rownames(Comparison)

### Display the Comparison

Comparison |> style_matrix(title = "Table 2: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
