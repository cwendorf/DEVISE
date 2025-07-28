# DEVISE
## Interfacing with `confintr`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")
source.github <- function(username, repo, branch) {
  url <- paste("https://github.com/", username, "/", repo, "/archive/refs/heads/", branch, ".zip", sep = "")
  name <- paste(repo, "-", branch, sep = "")
  file <- paste(name, ".zip", sep = "")
  download.file(url = url, destfile = file)
  unzip(zipfile = file)
  folder <- paste(name, "/R/", sep = "")
  paths <- list.files(path = folder, full.names = TRUE)
  for (i in 1:length(paths)) source(paths[i])
  unlink(file)
  unlink(name, recursive = TRUE)
}
source.github("mayer79", "confintr", "main")


### New Helper Functions

#' Display Confidence Interval Object
#'
#' Prints a formatted summary of a confidence interval object created by a custom function.
#' This includes information on the probabilities, type, and parameter, along with a 
#' labeled display of the estimate and the confidence interval bounds.
#'
#' @param x An object representing a confidence interval, typically containing elements 
#' like `estimate`, `interval`, `probs`, `type`, `parameter`, and `info`.
#' @param digits Number of significant digits to use for numeric display. Defaults to `getOption("digits")`.
#' @param ... Additional arguments passed to `print.data.frame()`.
#'
#' @return Invisibly returns the printed data frame with columns for the estimate and confidence interval bounds.
#' @export
#'
#' @seealso \code{\link{convert.cint}}
display.cint <- function(x, digits = getOption("digits"), ...) {
  # Print title and info left-aligned with no prefix
  cat("\n")
  cat(
    strwrap(
      paste(
        props2text(x$probs),
        format_p(diff(x$probs), digits = digits),
        x$type,
        "confidence interval for the",
        x$parameter,
        x$info
      )
    ),
    sep = "\n"
  )
  cat("\n")

  # Prepare column names for interval from probs
  ci_names <- format_p(x$probs, digits = digits)

  # Use helper function to generate data.frame
  df <- convert.cint(x)

  # Rename CI columns to the formatted probs (like "2.5%", "97.5%")
  colnames(df)[2:3] <- ci_names

  # Print data.frame right-aligned (right=TRUE) with digits option
  print(df, digits = digits, right = TRUE, row.names = FALSE)

  cat("\n")
  invisible(df)
}


convert.cint <- function(x, rowname = "Outcome", ...) {
  df <- matrix(
    c(x$estimate, x$interval[1], x$interval[2]),
    nrow = 1,
    dimnames = list(rowname, c("Estimate", "LL", "UL"))
  )
  df
}



### Examples

ci_mean(1:100)
ci_mean(1:100) |> display.cint()
ci_mean(1:100) |> convert.cint()

ci_mean(1:100) |> convert.cint() |> format_table() |> style_apa()
ci_mean(1:100) |> convert.cint() |> plot_set(main = "Confidence Interval Plot")



ci_mean(1:100, type = "bootstrap")
ci_mean(1:100, type = "bootstrap") |> display.cint()
ci_mean(1:100, type = "bootstrap") |> convert.cint() |> format_table(digits=3)

y1 <- 10:30
y2 <- 1:30
ci_mean_diff(y1, y2)
ci_mean_diff(y1, y2) |> display.cint()
ci_mean_diff(y1, y2) |> convert.cint() |> format_table(digits=3)


ci_mean(y1) |> convert.cint(rowname="Group 1") -> group1
ci_mean(y2) |> convert.cint(rowname="Group 2") -> group2

results <- rbind(group1,group2)
results |> plot_set(main = "Group Means", values=TRUE, col = "red")


ci_mean_diff(y2, y1) |> convert.cint(rowname="Comparison") -> compare
results <- rbind(group1, group2 ,compare)
results
results |> format_table()
results |> plot_comp(main = "Comparison Plot",values=TRUE)

ci_mean_diff(y1, y2, type = "bootstrap", R = 999)
ci_mean_diff(y1, y2, type = "bootstrap", R = 999) |> display.cint()
ci_mean_diff(y1, y2, type = "bootstrap", R = 999) |> convert.cint() |> format_table(digits=3)





## Mayer's Examples

# Mean
ci_mean(1:100)

# Mean using the Bootstrap
ci_mean(1:100, type = "bootstrap")

# 95% value at risk
ci_quantile(rexp(1000), q = 0.95)

# Mean difference
ci_mean_diff(1:100, 2:101)
ci_mean_diff(1:100, 2:101, type = "bootstrap", seed = 1)

# Correlation
ci_cor(iris[1:2], method = "spearman", type = "bootstrap")

# Proportions
ci_proportion(10, n = 100, type = "Wilson")
ci_proportion(10, n = 100, type = "Clopper-Pearson")

# R-squared
fit <- lm(Sepal.Length ~ ., data = iris)
ci_rsquared(fit, probs = c(0.05, 1))

# Kurtosis
ci_kurtosis(1:100)

# Mean difference
ci_mean_diff(10:30, 1:15)
ci_mean_diff(10:30, 1:15, type = "bootstrap")

# Median difference
ci_median_diff(10:30, 1:15)
