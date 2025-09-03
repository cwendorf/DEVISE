# DEVISE
## Resolve a Formula from a Frame

#' Evaluate a Formula or Variable in a Data Frame
#'
#' `resolve()` evaluates a formula or a single variable within the context of a given data frame.
#' This is useful for pipe-friendly workflows where you want to dynamically compute expressions
#' using columns of a data frame.
#'
#' @param data A data frame in which the formula or variable should be evaluated.
#' @param formula A formula (e.g., `y ~ x`) or a variable name.
#'
#' @return The result of evaluating the formula or variable in the data frame context.
#'   - If a single variable is provided, returns the vector.
#'   - If a formula is provided, returns the formula object suitable for functions like `lm()`.
#'
#' @export
resolve <- function(data, formula) {
  formula <- substitute(formula)
  with(data, eval(formula))
}
