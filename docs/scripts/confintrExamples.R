# DEVISE
## Comparison Examples with confintr

### Source the Functions

source("https://gist.githubusercontent.com/cwendorf/07d9796a750d8ac7c50aa43f28e06415/raw/df243fec33066a72235dc4596c532ca46f9f8c7b/source_github_folder.R")
source_github_folder("mayer79", "confintr", "main", "R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Data Entry

create_groups(k = 3, n = c(10,10,10), labels = c("Level1", "Level2", "Level3")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10) -> Outcome
data.frame(Factor, Outcome) -> Data
Data$Outcome[Data$Factor == "Level1"] -> y1
Data$Outcome[Data$Factor == "Level2"] -> y2
Data$Outcome[Data$Factor == "Level3"] -> y3

### Obtain the Statistics for Each Condition

ci_mean(y1) |> extract_intervals() -> Level1
ci_mean(y2) |> extract_intervals() -> Level2
ci_mean(y3) |> extract_intervals() -> Level3

rbind(Level1, Level2, Level3) -> Conditions
c("Level1", "Level2", "Level3") -> rownames(Conditions)

### Display the Conditions

Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 1: Conditions Confidence Intervals", values = TRUE)

### Obtain the Comparison Statistics

ci_mean_diff(y2, y1) |> extract_intervals() -> Difference

rbind(Level1, Level2, Difference) -> Comparison
c("Level1", "Level2", "Difference") -> rownames(Comparison)

### Display the Comparison

Comparison |> style_matrix(title = "Table 2: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
