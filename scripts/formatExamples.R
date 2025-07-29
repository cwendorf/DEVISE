
# Simple Matrix Formation

mat <- matrix(c(1.23456, 7.89123, 3.45678, 9.01234), ncol = 2)
colnames(mat) <- c("M", "SD")
rownames(mat) <- c("Group1","Group2")

mat |> style_plain(title = "Table 1\nDescriptives", spacing = 2, width=8, digits=2)
mat |> print_table(style="apa", title="Table 1\nDescriptives", digits = 4)

