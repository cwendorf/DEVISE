# DEVISE
## Examples with `backcalc`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/backcalc/main/source-backcalc.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Obtain the Statistics

backcalc_means(m = 8.000, sd = 1.414, n = 10) -> Level1
backcalc_means(m = 11.000, sd = 2.2111, n = 10) -> Level2
backcalc_means(m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) -> Comparison
rbind(Level1, Level2, Comparison) |> intervals() -> Results
c("Level1", "Level2", "Comparison") -> rownames(Results)

### Display the Results

Results |> render(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> compare(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)
