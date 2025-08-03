# DEVISE
## Simple Formatting

### Input Data

mat <- matrix(c(1.23456, 7.89123, 3.45678, 9.01234), ncol = 2)
colnames(mat) <- c("M", "SD")
rownames(mat) <- c("Group1", "Group2")

### Results

mat
mat |> print_matrix(digits = 2, width = 8, title = "Table 1\nDescriptive Statistics", style="apa")
