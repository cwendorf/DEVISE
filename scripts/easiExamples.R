# DEVISE
## Examples with `EASI`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/EASI/main/source-EASI.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics (using Data Input)

Factor <- gl(2, 10, labels = c("Level1", "Level2"))
Outcome <- c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11)
Results <- (Outcome~Factor) |> estimateComparison()

### Display the Results

Results |> print_matrix(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> plot_comp(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)

### Obtain the Statistics (using Summary Statistics Input)

Level1 <- c(N = 10, M = 8.000, SD = 1.414)
Level2 <- c(N = 10, M = 11.000, SD = 2.211)
IndependentSummary <- construct(Level1, Level2, class = "bsm")
Results <- IndependentSummary |> estimateComparison()

### Display the Results

Results |> print_matrix(title = "Table 2: Comparison Confidence Intervals", style = "apa")
Results |> plot_comp(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)
