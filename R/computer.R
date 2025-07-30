# spTools
## Matrix Computing

#' Compute Descriptive Statistics for Numeric Variables
#'
#' Calculates basic descriptive statistics (N, mean, and standard deviation) for numeric variables
#' in a data frame, optionally grouped by a factor using a formula interface.
#'
#' @param data A data frame containing the variables of interest.
#' @param vars Optional character vector specifying the names of numeric variables to include.
#'   If `NULL`, all numeric variables in `data` are used.
#' @param formula Optional formula specifying a grouping variable (e.g., `~ group`).
#'   If provided, statistics are computed separately for each group.
#'
#' @return If `formula` is `NULL`, returns a matrix of descriptive statistics (N, mean, and SD)
#'   for each variable. If `formula` is provided, returns a named list of such matrices, one for each group.
#'
#' @examples
#' data(iris)
#'
#' # Descriptive statistics for all numeric variables
#' describe(iris)
#'
#' # Descriptive statistics for specific variables
#' describe(iris, vars = c("Sepal.Length", "Petal.Length"))
#'
#' # Grouped descriptive statistics by Species
#' describe(iris, formula = ~ Species)
#'
#' @export
describe <- function(data, vars = NULL, formula = NULL) {
  # Get variable names
  if (is.null(vars)) {
    vars <- names(data)
  }
  
  # Handle formula-based grouping
  if (!is.null(formula)) {
    groupvar <- all.vars(formula)[1]
    if (!(groupvar %in% names(data))) {
      stop("Grouping variable not found in data.")
    }
    groups <- unique(data[[groupvar]])
    
    # Only use numeric variables (excluding groupvar)
    measurevars <- vars[vars %in% names(data) & sapply(data[vars], is.numeric)]
    
    results <- list()
    for (g in groups) {
      subset <- data[data[[groupvar]] == g, , drop = FALSE]
      stats <- t(sapply(subset[measurevars], function(x) {
        c(N = sum(!is.na(x)), 
        M = mean(x, na.rm = TRUE),
        SD = sd(x, na.rm = TRUE))
      }))
      results[[as.character(g)]] <- stats
    }
    return(results)
  }
  
  # If no formula, just compute for selected variables
  vars <- vars[vars %in% names(data) & sapply(data[vars], is.numeric)]
  stats <- t(sapply(data[vars], function(x) {
    c(N = sum(!is.na(x)),
    M = mean(x, na.rm = TRUE),
    SD = sd(x, na.rm = TRUE))
  }))
  return(stats)
}

#' Compute Correlation or Covariance Matrices
#'
#' Computes a correlation or covariance matrix for selected numeric variables in a data frame,
#' optionally grouped by a factor using a formula interface.
#'
#' @param data A data frame containing the variables of interest.
#' @param vars Optional character vector specifying the names of numeric variables to include.
#'   If `NULL`, all numeric variables in `data` are used.
#' @param formula Optional formula specifying a grouping variable, e.g., `~ group`.
#'   If provided, the correlation or covariance matrix is computed separately for each group.
#' @param type Character string indicating whether to compute `"cor"` (correlation) or `"cov"` (covariance).
#'   Default is `"cor"`.
#' @param method Character string specifying the correlation method: one of `"pearson"` (default), `"spearman"`, or `"kendall"`.
#'   Ignored if `type = "cov"`.
#'
#' @return If `formula` is `NULL`, returns a correlation or covariance matrix for the selected variables.
#' If `formula` is provided, returns a named list of matrices, one for each group level.
#'
#' @examples
#' data(iris)
#'
#' # Correlation matrix for all numeric variables
#' correlate(iris)
#'
#' # Covariance matrix for specific variables
#' correlate(iris, vars = c("Sepal.Length", "Petal.Length"), type = "cov")
#'
#' # Grouped correlation matrices by Species
#' correlate(iris, formula = ~ Species)
#'
#' @export
correlate <- function(data, vars = NULL, formula = NULL, type = "cor", method = "pearson") {
  # Validate type
  type <- match.arg(type, choices = c("cor", "cov"))

  # Variable selection
  if (is.null(vars)) {
    vars <- names(data)
  }

  # Filter numeric variables
  vars <- vars[vars %in% names(data) & sapply(data[vars], is.numeric)]

  # Internal computation: either correlation or covariance
  compute_matrix <- function(df) {
    if (type == "cor") {
      return(cor(df, use = "pairwise.complete.obs", method = method))
    } else {
      return(cov(df, use = "pairwise.complete.obs"))
    }
  }

  # Handle grouping
  if (!is.null(formula)) {
    groupvar <- all.vars(formula)[1]
    if (!(groupvar %in% names(data))) {
      stop("Grouping variable not found in data.")
    }
    groups <- unique(data[[groupvar]])
    results <- list()

    for (g in groups) {
      subset <- data[data[[groupvar]] == g, , drop = FALSE]
      results[[as.character(g)]] <- compute_matrix(subset[vars])
    }

    return(results)
  }

  # No grouping: compute directly
  return(compute_matrix(data[vars]))
}

#' Calculate Additional Metrics for Statistical Estimates
#'
#' This function computes additional metrics (Width, Margin of Error, Relative Width)
#' for a data frame of estimates with confidence intervals.
#'
#' @param input A data frame containing at least the columns `"Estimate"`, `"LL"`, and `"UL"`,
#' where `"LL"` and `"UL"` represent the lower and upper bounds of a confidence interval, respectively.
#'
#' @return A data frame identical to `input`, with additional columns:
#' \describe{
#'   \item{Width}{The width of the confidence interval (`UL - LL`).}
#'   \item{MoE}{The margin of error (`Width / 2`).}
#'   \item{Relative}{The relative width of the interval (`Width / abs(Estimate)`). Returns `NA` if `Estimate` is zero.}
#' }
#'
#' @examples
#' df <- data.frame(Estimate = c(10, 0, 5), LL = c(8, -1, 4), UL = c(12, 1, 6))
#' metrics(df)
#'
#' @export
metrics <- function(input) {
  width <- input[, "UL"] - input[, "LL"]
  moe <- width / 2
  relative <- ifelse(input[, "Estimate"] == 0, NA, width / abs(input[, "Estimate"]))
  out <- cbind(input, Width = width, MoE = moe, Relative = relative)
  return(out)
}
