# DEVISE
## Interfacing with `statpsych` and `spTools`

### Source the Functions

source("https://raw.githubusercontent.com/dgbonett/statpsych/main/R/statpsych1.R")
source("http://raw.githubusercontent.com/cwendorf/spTools/main/source-spTools.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Input Data

y1 <- 10:30
my1 <- mean(y1)
sdy1 <- sd(y1)
ny1 <- length(y1)

y2 <- 1:30
my2 <- mean(y2)
sdy2 <- sd(y2)
ny2 <- length(y2)

### Examples

ci.mean(alpha = .05, m = my1, sd = sdy1, n = ny1)[,c(1,3,4)] -> group1
ci.mean(alpha = .05, m = my2, sd = sdy2, n = ny2)[,c(1,3,4)] -> group2
ci.mean2(alpha = .05, my2, my1, sdy2, sdy1, ny2, ny1)[1,c(1,6,7)] -> compare
results <- rbind(group1, group2, compare)
results
results |> format_table()
results |> plot_comp(main = "Comparison Plot", values = TRUE)

ci.mean.vec(alpha = .05, m = c(my1, my2), sd = c(sdy1, sdy2), n = c(ny1, ny2)) -> groups
ci.mean2.vec(alpha = .05, m = c(my2, my1), sd = c(sdy2, sdy1), n = c(ny2, ny1)) -> compare
results <- rbind(groups, compare)
results
results |> format_table()
results |> plot_comp(main = "Comparison Plot", values = TRUE)
