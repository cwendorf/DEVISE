# DEVISE
## Examples with `statpsych` and `spTools`

### Source the Functions

source("https://gist.githubusercontent.com/cwendorf/07d9796a750d8ac7c50aa43f28e06415/raw/df243fec33066a72235dc4596c532ca46f9f8c7b/source_github_folder.R")
source_github_folder("dgbonett", "statpsych", "main", "R")
source("http://raw.githubusercontent.com/cwendorf/spTools/main/source-spTools.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics ('statpsych' only)

ci.mean(alpha = .05, m = 8.000, sd = 1.414, n = 10) |> intervals() -> Level1
ci.mean(alpha = .05, m = 11.000, sd = 2.2111, n = 10) |> intervals() -> Level2
ci.mean2(alpha = .05, 11.000, 8.000, 2.211, 1.414, 10, 10) |> intervals() |> rows(1) -> Comparison
rbind(Level1, Level2, Comparison) -> Results
c("Level1", "Level2", "Comparison") -> rownames(Results)

### Display the Results

Results |> render(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)

### Obtain the Statistics ('statpsych' and 'spTools')

ci.mean.vec(alpha = .05, m = c(8.000, 11.000), sd = c(1.414, 2.211), n = c(10, 10)) |> intervals() -> Levels
ci.mean2.vec(alpha = .05, m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) |> intervals() |> rows(1) -> Comparison
rbind(Levels, Comparison) -> Results
c("Level1", "Level2", "Comparison") -> rownames(Results)

### Display the Results

Results |> render(title = "Table 2: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
