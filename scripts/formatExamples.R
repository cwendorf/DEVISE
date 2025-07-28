
# Simple Matrix Formation

mat <- matrix(c(1.23456, 7.89123, 3.45678, 9.01234), ncol = 2)
colnames(mat) <- c("M", "SD")
rownames(mat) <- c("Group1","Group2")

format_matrix(mat, padding=3, width=20)
format_table(mat, padding=3, digits=5, width=20)


# Style Selections

results <- matrix(c(1.234, 12.345, 123.456, 1234.567), nrow = 2)
colnames(results) <- c("Short", "Long")
rownames(results) <- c("Model A", "Model B")

formatted <- format_table(results)
formatted
formatted |> style_plain(title = "Table 1\nDescriptive Statistics")
formatted |> style_md(title = "Table 1\nDescriptive Statistics")
formatted |> style_apa(title = "Table 1\nDescriptive Statistics")


unformat_matrix(formatted)
