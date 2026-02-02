# `DEVISE`
## Mean Comparisons with `EASI`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/EASI/main/source-EASI.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Examine the Conditions (Raw Data Input)

#### Input the Data

gl(3, 10, labels = c("Level1", "Level2", "Level3")) -> Factor
c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11, 9, 16, 11, 12, 15, 13, 9, 14, 11, 10) -> Outcome

#### Obtain the Statistics

(Outcome~Factor) |> estimateMeans() -> Conditions

#### Display the Conditions

Conditions |> style_matrix(title = "Table 1: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 1: Conditions Confidence Intervals", values = TRUE)

### Make a Comparison (Raw Data Input)

#### Subset the Data

Outcome[Factor %in% c("Level1", "Level2")] -> Outcome_Sub
Factor[Factor %in% c("Level1", "Level2")] -> Factor_Sub

#### Obtain the Statistics

(Outcome_Sub~Factor_Sub) |> estimateComparison() -> Comparison

#### Display the Comparison

Comparison |> style_matrix(title = "Table 2: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 2: Comparison Confidence Intervals", values = TRUE)

### Examine the Conditions (Summary Statistics Input)

#### Input the Statistics

c(N = 10, M = 8.000, SD = 1.414) -> Level1
c(N = 10, M = 11.000, SD = 2.211) -> Level2
c(N = 10, M = 12.000, SD = 2.449) -> Level3
construct(Level1, Level2, Level3, class = "bsm") -> IndependentSummary

#### Obtain the Statistics

IndependentSummary |> estimateMeans() -> Conditions

#### Display the Conditions

Conditions |> style_matrix(title = "Table 3: Means and Confidence Intervals", style = "apa")
Conditions |> plot_conditions(title = "Figure 3: Conditions Confidence Intervals", values = TRUE)

### Make a Comparison (Summary Statistics Input)

#### Calculate the Statistics

construct(Level1, Level2, class = "bsm") |> estimateComparison() -> Comparison

#### Display the Comparison

Comparison |> style_matrix(title = "Table 4: Means, Confidence Intervals, and Comparison", style = "apa")
Comparison |> plot_comparison(title = "Figure 4: Comparison Confidence Intervals", values = TRUE)
