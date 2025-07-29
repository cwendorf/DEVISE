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

### Input Data

Factor <- gl(2, 10, labels = c("Level1", "Level2"))
Outcome <- c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11)
IndependentData <- data.frame(Factor, Outcome)

y1 <- IndependentData$Outcome[IndependentData$Factor == "Level1"]
y2 <- IndependentData$Outcome[IndependentData$Factor == "Level2"]

### Create Summary

ci_mean(y1) |> convert.cint(rowname="Level1") -> Level1
ci_mean(y2) |> convert.cint(rowname="Level2") -> Level2
ci_mean_diff(y2, y1) |> convert.cint(rowname="Comparison") -> Comparison
Results <- rbind(Level1, Level2, Comparison)

### Results

Results
Results |> print_table()
Results |> plot_comp(title = "Comparison Plot", values = TRUE)
