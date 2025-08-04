# DEVISE
## Simple Examples

### Input Data

Level1 <- c(N = 10, M = 8.000, SD = 1.414)
Level2 <- c(N = 10, M = 11.000, SD = 2.211)
Results <- rbind(Level1, Level2)

### Results

Results |> print_matrix(title = "Table 1: Descriptive Statistics", style = "apa")
