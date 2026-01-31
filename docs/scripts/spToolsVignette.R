# DEVISE
## Comparison Vignettes with statpsych and spTools

### Source the Functions

source("https://gist.githubusercontent.com/cwendorf/07d9796a750d8ac7c50aa43f28e06415/raw/df243fec33066a72235dc4596c532ca46f9f8c7b/source_github_folder.R")
source_github_folder("dgbonett", "statpsych", "main", "R")
source("http://raw.githubusercontent.com/cwendorf/spTools/main/source-spTools.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics for Each Condition ('statpsych' only)

ci.mean(alpha = .05, m = 8.000, sd = 1.414, n = 10) |> extract_intervals() -> Level1
ci.mean(alpha = .05, m = 11.000, sd = 2.211, n = 10) |> extract_intervals() -> Level2
ci.mean(alpha = .05, m = 12.000, sd = 2.449, n = 10) |> extract_intervals() -> Level3

rbind(Level1, Level2, Level3) -> Conditions
c("Level1", "Level2", "Level3") -> rownames(Conditions)

### Display the Conditions

Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 1: Conditions Confidence Intervals", values = TRUE)

### Obtain the Comparison Statistics

ci.mean2(alpha = .05, 11.000, 8.000, 2.211, 1.414, 10, 10) |> extract_intervals() |> extract_rows(1) -> Difference

rbind(Level1, Level2, Difference) -> Comparison
c("Level1", "Level2", "Difference") -> rownames(Comparison)

### Display the Comparison

Comparison |> style_matrix(title = "Table 2: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)

### Obtain the Statistics for Each Condition ('statpsych' and 'spTools')

ci.mean.vec(alpha = .05, m = c(8.000, 11.000, 12.000), sd = c(1.414, 2.211, 2.449), n = c(10, 10, 10)) |> extract_intervals() -> Conditions
c("Level1", "Level2", "Level3") -> rownames(Conditions)

### Display the Conditions

Conditions |> style_matrix(title = "Table 3: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 3: Conditions Confidence Intervals", values = TRUE)

### Obtain the Comparison Statistics

ci.mean2.vec(alpha = .05, m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) |> extract_intervals() |> extract_rows(1) -> Difference

rbind(Conditions[1,], Conditions[2,], Difference) -> Comparison
c("Level1", "Level2", "Difference") -> rownames(Comparison)

### Display the Comparison

Comparison |> style_matrix(title = "Table 4: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 4: Comparison Confidence Intervals", values = TRUE)
