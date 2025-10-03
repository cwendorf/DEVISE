# DEVISE
## Evaluating Expressions

#' Select Variables or Formulas from a Data Frame
#'
#' `use_vars()` evaluates one or more expressions within the context of a data frame.
#' This can include formulas (e.g., `y ~ x`) or bare variable names. The result
#' is pipe-friendly and adapts depending on whether you select a single variable,
#' multiple variables, or a formula.
#'
#' @param data A data frame providing the evaluation context.
#' @param ... One or more expressions:
#'   - A formula (e.g., `y ~ x1 + x2`) for use with modeling functions.
#'   - One or more bare variable names (e.g., `x1, x2`).
#'
#' @return
#'   - If a single variable is provided: returns a vector.
#'   - If multiple variables are provided: returns a data frame.
#'   - If a formula is provided: returns a data frame with the selected variables,
#'     and the original formula is preserved as an attribute for use by functions
#'     like `lm()`, `glm()`, or `t.test()`.
#'
#' @examples
#' df <- data.frame(
#'   y = 1:5,
#'   x1 = c(1,1,1,2,2),
#'   x2 = c(5,4,3,2,1),
#'   x3 = c(10,20,30,40,50)
#' )
#'
#' # Use a formula for modeling
#' df |> use_vars(y ~ x1) |> t.test()
#' df |> use_vars(y ~ x1 + x2) |> lm() |> summary()
#'
#' # Use a single variable
#' df |> use_vars(x3)
#'
#' # Use multiple variables
#' df |> use_vars(x1, x2) |> cor()
#'
#' @export
use_vars <- function(data, ...) {
  dots <- substitute(list(...))[-1L]  # capture unevaluated inputs
  if (length(dots) == 0L) stop("No expressions supplied")

  results <- lapply(dots, function(e) with(data, eval(e)))
  names(results) <- sapply(dots, deparse)

  if (length(results) == 1L) {
    results[[1]]
  } else {
    as.data.frame(results)
  }
}

#' Retain an Object in a Pipeline
#'
#' `retain()` assigns an object in the caller's environment
#' while returning the value invisibly. This makes it easy to save
#' intermediate results when using the native pipe (`|>`).
#'
#' @param x The object to retain (typically coming from a pipeline).
#' @param name A symbol giving the name to assign `x` to in the
#'   caller's environment.
#'
#' @return Invisibly returns `x`, unchanged.
#' @export
#'
#' @examples
#' # Save a filtered dataset in a pipeline
#' iris |>
#'   subset(Species == "setosa") |>
#'   retain(setosa_only) |>
#'   summary()
#'
#' # Save a model fit while still viewing its summary
#' iris |>
#'   lm(Sepal.Length ~ Sepal.Width, data = _) |>
#'   retain(model_fit) |>
#'   summary()
#'
#' # Save an intermediate step for debugging
#' mtcars |>
#'   subset(cyl == 6) |>
#'   retain(six_cyls) |>
#'   transform(kpl = mpg * 0.425) |>
#'   head()
retain <- function(x, name) {
  assign(deparse(substitute(name)), x, envir = parent.frame())
  invisible(x)
}
