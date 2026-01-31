# DEVISE
## Comparison Vignette with Base R

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Data Entry

gl(3, 10, labels = c("Level1", "Level2", "Level3")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10) -> Outcome

### Obtain the Statistics for Each Condition

Outcome[Factor == "Level1"] |> t.test() |> extract_intervals() -> Level1
Outcome[Factor == "Level2"] |> t.test() |> extract_intervals() -> Level2
Outcome[Factor == "Level3"] |> t.test() |> extract_intervals() -> Level3

rbind(Level1, Level2, Level3) -> Conditions
c("Level1", "Level2", "Level3") -> rownames(Conditions)

### Display the Conditions

Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 1: Conditions Confidence Intervals", values = TRUE)

### Subset the Data

Outcome_Sub <- Outcome[Factor %in% c("Level1", "Level2")]
Factor_Sub <- Factor[Factor %in% c("Level1", "Level2")]

### Obtain the Comparison Statistics

(Outcome_Sub ~ Factor_Sub) |> t.test() |> extract_intervals() -> Difference

rbind(Level1, Level2, Difference) -> Comparison
c("Level1", "Level2", "Difference") -> rownames(Comparison)

### Display the Comparison

Comparison |> style_matrix(title = "Table 2: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
