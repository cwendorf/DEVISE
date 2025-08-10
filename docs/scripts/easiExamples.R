# DEVISE
## Examples with `EASI`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/EASI/main/source-EASI.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics (using Data Input)

gl(2, 10, labels = c("Level1", "Level2")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11) -> Outcome
(Outcome~Factor) |> estimateComparison() -> Results

### Display the Results

Results |> render(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)

### Obtain the Statistics (using Summary Statistics Input)

c(N = 10, M = 8.000, SD = 1.414) -> Level1
c(N = 10, M = 11.000, SD = 2.211) -> Level2
construct(Level1, Level2, class = "bsm") -> IndependentSummary
IndependentSummary |> estimateComparison() -> Results

### Display the Results

Results |> render(title = "Table 2: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
