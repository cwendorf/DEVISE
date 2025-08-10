# DEVISE
## Examples with `backcalc`

### Source the Functions

source("https://gist.githubusercontent.com/cwendorf/07d9796a750d8ac7c50aa43f28e06415/raw/df243fec33066a72235dc4596c532ca46f9f8c7b/source_github_folder.R")
source_github_folder("cwendorf", "backcalc", "main", "R")
source_github_folder("cwendorf", "DEVISE", "main", "R")

### Obtain the Statistics

backcalc_means(m = 8.000, sd = 1.414, n = 10) -> Level1
backcalc_means(m = 11.000, sd = 2.2111, n = 10) -> Level2
backcalc_means(m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) -> Comparison
rbind(Level1, Level2, Comparison) |> intervals() -> Results
c("Level1", "Level2", "Comparison") -> rownames(Results)

### Display the Results

Results |> render(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)
