# DEVISE
## Examples with `confintr`

### Source the Functions

source("https://gist.githubusercontent.com/cwendorf/07d9796a750d8ac7c50aa43f28e06415/raw/df243fec33066a72235dc4596c532ca46f9f8c7b/source_github_folder.R")
source_github_folder("mayer79", "confintr", "main", "R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics

gl(2, 10, labels = c("Level1", "Level2")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11) -> Outcome
data.frame(Factor, Outcome) -> IndependentData
IndependentData$Outcome[IndependentData$Factor == "Level1"] -> y1
IndependentData$Outcome[IndependentData$Factor == "Level2"] -> y2

ci_mean(y1) |> intervals() -> Level1
ci_mean(y2) |> intervals() -> Level2
ci_mean_diff(y2, y1) |> intervals() -> Comparison
rbind(Level1, Level2, Comparison) -> Results
c("Level1", "Level2", "Comparison") -> rownames(Results)

### Display the Results

Results |> render(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)
