# DEVISE
## Interfacing with `statpsych` and `spTools`

### Source the Functions

source("https://raw.githubusercontent.com/dgbonett/statpsych/main/R/statpsych1.R")
source("http://raw.githubusercontent.com/cwendorf/spTools/main/source-spTools.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Input Summary

ci.mean(alpha = .05, m = 8.000, sd = 1.414, n = 10)[,c(1,3,4)] -> Level1
ci.mean(alpha = .05, m = 11.000, sd = 2.2111, n = 10)[,c(1,3,4)] -> Level2
ci.mean2(alpha = .05, 11.000, 8.000, 2.211, 1.414, 10, 10)[1, c(1,6,7)] -> Comparison
Results <- rbind(Level1, Level2, Comparison)
rownames(Results) <- c("Level1", "Level2", "Comparison")

### Results

Results
Results |> print_matrix(style="apa", digits = 4, width = 10)
Results |> plot_comp(title = "Comparison Plot", values = TRUE)

### Input Summary

ci.mean.vec(alpha = .05, m = c(8.000, 11.000), sd = c(1.414, 2.211), n = c(10, 10)) |> sp.columns() -> Levels
ci.mean2.vec(alpha = .05, m = c(11.000, 8.000), sd = c(2.211, 1.414), n = c(10, 10)) |> sp.columns() |> sp.rows(1) -> Comparison
Results <- rbind(Levels, Comparison)
rownames(Results) <- c("Level1", "Level2", "Comparison")

### Results

Results
Results |> print_matrix(digits = 2)
Results |> plot_comp(title = "Comparison Plot", values = TRUE)
