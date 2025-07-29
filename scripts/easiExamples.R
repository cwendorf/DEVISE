# DEVISE
## Interfacing with `EASI`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/EASI/main/source-EASI.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Input Data

Factor <- gl(2, 10, labels = c("Level1", "Level2"))
Outcome <- c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11)
IndependentData <- construct(Factor, Outcome)

### Results

(Outcome~Factor) |> estimateMeans()
(Outcome~Factor) |> estimateMeans() |> style_apa()

(Outcome~Factor) |> plotComparison()
(Outcome~Factor) |> estimateComparison() |> plot_comp(main = "Comparison Plot",values=TRUE)


### Input Summary

Level1 <- c(N = 10, M = 8.000, SD = 1.414)
Level2 <- c(N = 10, M = 11.000, SD = 2.211)
IndependentSummary <- construct(Level1, Level2, class = "bsm")

### Results

IndependentSummary |> estimateMeans()
IndependentSummary |> estimateMeans() |> print_table(style="md", digits = 4)
IndependentSummary |> estimateMeans() |> style_apa(digits=5, width=10)

IndependentSummary |> plotComparison()
IndependentSummary |> estimateComparison() |> plot_comp(title = "Comparison Plot",values=TRUE)
