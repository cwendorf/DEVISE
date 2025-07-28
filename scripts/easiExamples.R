# DEVISE
## Interfacing with `EASI`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/EASI/main/source-EASI.R")
source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Input Data

y1 <- 10:30
ny1 <- length(y1)

y2 <- 1:30
ny2 <- length(y2)

Factor <- c(rep(1, length(y1)), rep(2, length(y2)))
Factor <- factor(Factor, levels = c(1, 2), labels = c("Group1", "Group2"))
Outcome <- c(y1, y2)
Data <- construct(Factor, Outcome)

y1 <- 10:30
my1 <- mean(y1)
sdy1 <- sd(y1)
ny1 <- length(y1)

y2 <- 1:30
my2 <- mean(y2)
sdy2 <- sd(y2)
ny2 <- length(y2)

Level1 <- c(N = ny1, M = my1, SD = sdy1)
Level2 <- c(N = ny2, M = my2, SD = sdy2)
Moments <- construct(Level1, Level2, class = "bsm")

### Examples

Moments |> estimateMeans()
Moments |> estimateMeans() |> format_table() |> style_apa()

Moments |> plotComparison()
Moments |> estimateComparison() |> plot_comp(main = "Comparison Plot",values=TRUE)
