# DEVISE
## Matrix Formatting

#' Format a Numeric Matrix for Aligned Printing
#'
#' Rounds and formats a matrix for clean, right-aligned display.
#'
#' @param results A numeric matrix or data frame.
#' @param digits Number of decimal places to round to. Default is 3.
#' @param padding Extra space padding on each side of values. Default is 0.
#' @param width Fixed width for each column. If NULL, computed from digits and padding.
#' @param ... Additional arguments passed to `format()`.
#'
#' @return A noquote matrix with formatted strings for display.
#' @noRd
format_matrix <- function(results, digits = 3, padding = 0, width = 8, ...) {
  if (is.null(width)) width <- digits + (padding * 2)
  colnames(results) <- format(colnames(results), width = width, justify = "right")
  noquote(format(as.matrix(round(results, digits = digits)), width = width, justify = "right", digits = digits, nsmall = digits, trim = TRUE, scientific = FALSE, ...))
}

#' Convert Formatted Matrix Back to Numeric
#'
#' Cleans up a formatted matrix by removing commas, currency symbols, etc., and converts to numeric.
#'
#' @param results A character matrix or printed matrix to be converted back to numeric.
#'
#' @return A numeric matrix with the same dimensions as input.
#' @noRd
unformat_matrix <- function(results) {
  results <- as.matrix(results)
  results_clean <- gsub("[,$]", "", results)
  apply(results_clean, c(1, 2), as.numeric)
}

#' Print Formatted Matrix in Plain Style
#'
#' Prints a formatted numeric matrix with optional title and vertical spacing.
#'
#' @param results A numeric matrix already formatted.
#' @param title Optional title printed above the matrix.
#' @param spacing Number of blank lines above and below the matrix. A single number or a vector of length 2.
#'
#' @return Invisibly returns the printed matrix.
#' @noRd
print_matrix_plain <- function(results, title = NULL, spacing = 0, ...) {
  if (length(spacing) == 1) {
    spacing <- rep(spacing, 2)
  }
  if (length(spacing) != 2) {
    stop("spacing must be a numeric vector of length 1 or 2: spacing or c(space_above, space_below)")
  }
  if (spacing[1] > 0) cat(rep("\n", spacing[1]), sep = "")
  if (!is.null(title)) cat(title, "\n\n")
  print(results)
  if (spacing[2] > 0) cat(rep("\n", spacing[2]), sep = "")
}

#' Print Formatted Matrix in APA Style
#'
#' Prints a matrix with APA-style header and border lines.
#' 
#' @param results A numeric matrix already formatted.
#' @param title Optional title printed above the matrix.
#' @param spacing Number of blank lines above and below the matrix. A single number or a vector of length 2.
#'
#' @return Invisibly returns the printed matrix.
#' @noRd
print_matrix_apa <- function(results, title = NULL, spacing = 0, ...) {
  if (length(spacing) == 1) {
    spacing <- rep(spacing, 2)
  }
  if (length(spacing) != 2) {
    stop("spacing must be a numeric vector of length 1 or 2: spacing or c(space_above, space_below)")
  }
  
  if (spacing[1] > 0) cat(rep("\n", spacing[1]), sep = "")
  if (!is.null(title)) cat(title, "\n\n")
  
  printed_lines <- capture.output(print(results))
  max_width <- max(nchar(printed_lines))
  line <- paste(rep("-", max_width), collapse = "")

  cat(line, "\n")
  cat(printed_lines[1], "\n")
  cat(line, "\n")

  if (length(printed_lines) > 1) {
    cat(paste(printed_lines[-1], collapse = "\n"), "\n")
  }
  
  cat(line, "\n")
  if (spacing[2] > 0) cat(rep("\n", spacing[2]), sep = "")
}

#' Format and Print Matrix
#'
#' Wrapper function to format and print a matrix using a specified style.
#'
#' @param results A numeric matrix.
#' @param digits Number of decimal places to round to. Default is 3.
#' @param padding Extra space padding on each side of values. Default is 0.
#' @param width Fixed width for each column. If \code{NULL}, computed from digits and padding.
#' @param title Optional character string to print above the matrix. If \code{NULL}, uses the matrix comment.
#' @param spacing Number of lines before and after the matrix. Either a single number or a vector of length 2.
#' @param style Character string indicating print style. One of \code{"plain"} (default) or \code{"apa"}.
#' @param ... Additional arguments passed to \code{format_matrix()}.
#'
#' @return Invisibly returns the formatted matrix (as a character matrix).
#'
#' @examples
#' mat <- matrix(c(0.123456, 0.789012, 0.345678,
#'                 0.901234, 0.567890, 0.123456,
#'                 0.654321, 0.234567, 0.987654),
#'               nrow = 3, byrow = TRUE)
#' colnames(mat) <- c("Var1", "Var2", "Var3")
#' rownames(mat) <- c("A", "B", "C")
#'
#' # Default plain style
#' print_matrix(mat, title = "Plain Matrix")
#'
#' # APA style
#' print_matrix(mat, title = "APA Style Matrix", style = "apa")
#'
#' @export
print_matrix <- function(results,
                         digits = 3,
                         padding = 0,
                         width = 8,
                         title = NULL,
                         spacing = 1,
                         style = "plain",
                         ...) {
  formatted <- format_matrix(results, digits = digits, padding = padding, width = width, ...)

  if (is.null(title)) {
    title <- comment(results)
  }

  style <- tolower(style)
  if (style == "apa") {
    print_matrix_apa(formatted, title = title, spacing = spacing)
  } else if (style == "plain") {
    print_matrix_plain(formatted, title = title, spacing = spacing)
  } else {
    stop("Unknown style: must be either 'apa' or 'plain'")
  }

  invisible(formatted)
}
