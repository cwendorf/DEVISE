# DEVISE
## Computing Statistics

#' Compute Descriptive Statistics for Numeric Variables (fixed)
#'
#' Calculates N, mean and SD for numeric variables, optionally grouped.
#' Accepts either:
#'  - no args: all numeric vars,
#'  - bare var names:  e.g. `x, y` or `c(x,y)`,
#'  - a formula: `vars ~ group` or `~ group`.
#'
#' If grouped and exactly one measured variable is requested, the function
#' returns a single matrix with groups as rownames (auto-collapsed).
#' If grouped with multiple measured variables, returns a named list of matrices.
#'
#' @param data data.frame
#' @param ... bare variable names (unquoted), or a single formula (e.g. `x ~ Group`,
#'   `c(x,y) ~ Group`, or `~ Group`). If omitted, all numeric variables are used.
#' @return matrix (ungrouped), matrix (grouped + single var), or list of matrices (grouped + multiple vars)
#' @examples
#' data.frame(
#'   Group = rep(c("A","B"), each = 5),
#'   x = c(1,2,3,4,5, 2,3,4,5,6),
#'   y = c(5,4,3,2,1, 6,7,8,9,10)
#' ) -> df
#' df |> compute_descriptives()
#' df |> compute_descriptives(x, y)
#' df |> compute_descriptives(x ~ Group)
#' df |> compute_descriptives(c(x,y) ~ Group)
#' @export
compute_descriptives <- function(data, ...) {
  spec <- substitute(list(...))[-1L]

  # helper to turn symbol / c(...) calls into names
  expr_to_names <- function(e) {
    if (is.symbol(e)) return(deparse(e))
    if (is.call(e) && identical(e[[1]], as.symbol("c"))) {
      parts <- as.list(e)[-1L]
      return(unlist(lapply(parts, expr_to_names), use.names = FALSE))
    }
    # fallback: try to evaluate (not needed per your request, but harmless)
    val <- try(eval(e, parent.frame()), silent = TRUE)
    if (!inherits(val, "try-error") && is.character(val)) return(val)
    stop("Invalid variable specification")
  }

  # ---- Formula branch ----
  is_formula_expr <- function(expr) {
    # detect calls like ~ or existing formula objects
    (is.call(expr) && identical(expr[[1]], as.symbol("~"))) ||
      inherits(eval(expr, parent.frame()), "formula")
  }

  if (length(spec) == 1L && is_formula_expr(spec[[1L]])) {
    # build a formula object in the caller env (safe)
    fml <- tryCatch(as.formula(spec[[1L]], env = parent.frame()),
                    error = function(e) eval(spec[[1L]], parent.frame()))
    # Extract LHS vars (measured) and RHS vars (group)
    lhs_vars <- all.vars(fml[[2]])
    rhs_vars <- all.vars(fml[[3]])

    # If RHS missing or multiple RHS items -> error
    if (length(rhs_vars) != 1L) stop("Formula must be of the form vars ~ group (RHS must be a single grouping variable).")
    groupvar <- rhs_vars[[1L]]
    if (!(groupvar %in% names(data))) stop("Grouping variable not found in data.")

    # If no LHS specified (~ group), use all numeric variables
    if (length(lhs_vars) == 0L) {
      measurevars <- names(data)[sapply(data, is.numeric)]
    } else {
      measurevars <- intersect(lhs_vars, names(data))
      measurevars <- measurevars[sapply(data[measurevars], is.numeric)]
    }
    if (length(measurevars) == 0L) stop("No numeric variables found on the left-hand side.")

    groups <- unique(data[[groupvar]])

    # If only one measured var -> auto-collapse to matrix (rows = groups)
    if (length(measurevars) == 1L) {
      mv <- measurevars[[1L]]
      out <- t(sapply(groups, function(g) {
        vec <- data[data[[groupvar]] == g, mv]
        c(N = sum(!is.na(vec)),
          M = mean(vec, na.rm = TRUE),
          SD = sd(vec, na.rm = TRUE))
      }))
      rownames(out) <- as.character(groups)
      return(out)
    }

    # multiple measured variables -> return list of matrices (one per group)
    results <- lapply(groups, function(g) {
      subset <- data[data[[groupvar]] == g, , drop = FALSE]
      t(sapply(measurevars, function(x) {
        vec <- subset[[x]]
        c(N = sum(!is.na(vec)),
          M = mean(vec, na.rm = TRUE),
          SD = sd(vec, na.rm = TRUE))
      }))
    })
    names(results) <- as.character(groups)
    return(results)
  }

  # ---- Non-formula branch: bare names or none ----
  if (length(spec) == 0L) {
    vars <- names(data)[sapply(data, is.numeric)]
  } else {
    vars <- unique(unlist(lapply(spec, expr_to_names), use.names = FALSE))
    vars <- intersect(vars, names(data))
    vars <- vars[sapply(data[vars], is.numeric)]
  }
  if (length(vars) == 0L) stop("No numeric variables selected.")

  out <- t(sapply(vars, function(x) {
    vec <- data[[x]]
    c(N = sum(!is.na(vec)),
      M = mean(vec, na.rm = TRUE),
      SD = sd(vec, na.rm = TRUE))
  }))
  return(out)
}


#' Compute Correlation or Covariance Matrices
#'
#' Computes a correlation or covariance matrix for selected numeric variables in a data frame,
#' optionally grouped by a factor using a formula or bare variable names.
#'
#' @param data A data frame containing the variables of interest.
#' @param ... One or more expressions:
#'   - A formula (e.g., `~ group` or `y1 + y2 ~ group`) to specify grouping and optionally variables.
#'   - One or more bare variable names (e.g., `x1, x2`).
#'   - If omitted, all numeric variables in `data` are used.
#' @param type Character string indicating whether to compute `"cor"` (correlation) or `"cov"` (covariance).
#'   Default is `"cor"`.
#' @param method Character string specifying the correlation method: one of `"pearson"` (default), `"spearman"`, or `"kendall"`.
#'   Ignored if `type = "cov"`.
#'
#' @return
#'   - If no grouping is specified: returns a correlation or covariance matrix.
#'   - If a grouping formula is specified: returns a named list of matrices, one per group level.
#'
#' @examples
#' # Correlation matrix for all numeric variables
#' iris |> compute_correlations()
#'
#' # Covariance matrix for specific variables
#' iris |> compute_correlations(Sepal.Length, Petal.Length, type = "cov")
#'
#' # Grouped correlation matrices by Species
#' iris |> compute_correlations(~ Species)
#'
#' # Grouped correlation matrices for specific variables
#' iris |> compute_correlations(Sepal.Length, Petal.Length ~ Species)
#'
#' @export
compute_correlations <- function(data, ..., type = "cor", method = "pearson") {
  type <- match.arg(type, choices = c("cor", "cov"))
  dots <- substitute(list(...))[-1L]

  # Helper: compute correlation/covariance
  compute_matrix <- function(df) {
    if (type == "cor") {
      cor(df, use = "pairwise.complete.obs", method = method)
    } else {
      cov(df, use = "pairwise.complete.obs")
    }
  }

  # Case 1: no inputs → use all numeric variables
  if (length(dots) == 0L) {
    vars <- names(data)[sapply(data, is.numeric)]
    return(compute_matrix(data[vars]))
  }

  # Case 2: single formula
  if (length(dots) == 1L && inherits(eval(dots[[1]], parent.frame()), "formula")) {
    fml <- eval(dots[[1]], parent.frame())
    terms <- all.vars(fml)

    if (length(terms) == 1L) {
      # Only grouping: ~ group
      groupvar <- terms[1]
      vars <- names(data)[sapply(data, is.numeric)]
    } else {
      # Variables + grouping: var(s) ~ group
      groupvar <- terms[length(terms)]
      vars <- terms[-length(terms)]
    }

    if (!(groupvar %in% names(data))) stop("Grouping variable not found in data.")
    groups <- unique(data[[groupvar]])

    results <- lapply(groups, function(g) {
      subset <- data[data[[groupvar]] == g, , drop = FALSE]
      subset_vars <- vars[vars %in% names(subset)]
      compute_matrix(subset[subset_vars])
    })
    names(results) <- as.character(groups)
    return(results)
  }

  # Case 3: bare variables
  vars <- sapply(dots, deparse)
  vars <- vars[vars %in% names(data) & sapply(data[vars], is.numeric)]
  if (length(vars) == 0L) stop("No valid numeric variables supplied.")
  return(compute_matrix(data[vars]))
}

#' Compute Additional Metrics for Statistical Estimates
#'
#' This function computes additional metrics (Width, Margin of Error, Relative Width)
#' for a data frame of estimates with confidence intervals.
#'
#' @param input A data frame containing at least the columns `"Estimate"`, `"LL"`, and `"UL"`,
#' where `"LL"` and `"UL"` represent the lower and upper bounds of a confidence interval, respectively.
#'
#' @return A data frame identical to `input`, with additional columns:
#' \details{
#'   \item{Width}{The width of the confidence interval (`UL - LL`).}
#'   \item{MoE}{The margin of error (`Width / 2`).}
#'   \item{Relative}{The relative width of the interval (`Width / abs(Estimate)`). Returns `NA` if `Estimate` is zero.}
#' }
#'
#' @examples
#' cbind(Estimate = c(10, 0, 5), LL = c(8, -1, 4), UL = c(12, 1, 6)) -> df
#' c("A", "B", "C") -> rownames(df)
#' df |> compute_metrics()
#'
#' @export
compute_metrics <- function(input) {
  width <- input[, "UL"] - input[, "LL"]
  moe <- width / 2
  relative <- ifelse(input[, "Estimate"] == 0, NA, width / abs(input[, "Estimate"]))
  out <- cbind(input, Width = width, MoE = moe, Relative = relative)
  return(out)
}
