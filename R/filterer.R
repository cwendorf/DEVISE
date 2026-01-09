# DEVISE
## Filtering Matrices

#' Set Row Names of a Data Frame
#'
#' Assign row names to a data frame in a pipe-friendly way.
#'
#' Note: This function does not modify the original data frame in place. You must assign the result back to a variable.
#'
#' @param x A data frame.
#' @param names A character vector of row names. Must have length equal to `nrow(x)`.
#'
#' @return A data frame identical to `x` but with updated row names.
#' @examples
#' # Basic usage
#' df <- data.frame(a = 1:3, b = 4:6)
#' df <- df |> name_rows(c("A", "B", "C"))  # Must assign back to df
#'
#' # Within-pipe renaming
#' df <- data.frame(c(10, 0, 5), c(8, -1, 4), c(12, 1, 6))
#' df |> name_rows(c("Group1", "Group2", "Group3")) -> Results
#' @export
name_rows <- function(x, names) {
  rownames(x) <- names
  x
}

#' Set Column Names of a Data Frame
#'
#' Assign column names to a data frame in a pipe-friendly way.
#'
#' Note: This function does not modify the original data frame in place. You must assign the result back to a variable if using outside of a pipe.
#'
#' @param x A data frame.
#' @param names A character vector of column names. Must have length equal to `ncol(x)`.
#'
#' @return A data frame identical to `x` but with updated column names.
#' @examples
#' # Basic usage
#' df <- data.frame(a = 1:3, b = 4:6)
#' df <- df |> name_columns(c("First", "Second"))  # Must assign back to df
#'
#' # Within-pipe renaming
#' df <- data.frame(c(10, 0, 5), c(8, -1, 4), c(12, 1, 6))
#' df |> name_columns(c("Estimate", "LL", "UL")) -> Results
#' @export
name_columns <- function(x, names) {
  colnames(x) <- names
  x
}

#' Extract Columns from Data Frame, Matrix, or List
#'
#' Extract specified columns from a data frame, matrix, or list of such objects.
#'
#' @param out A data frame, matrix, atomic vector, or a list of such objects.
#' @param cols A numeric vector of column indices or a character vector of column names to keep. If NULL, all columns are returned or selected by intervals() if available.
#' @return The filtered object with only the specified columns. The output type matches the input (matrix, data frame, or list).
#' @examples
#' data.frame(Estimate = 1:3, SE = 0.1, Extra = 4:6) -> df
#' df |> extract_columns(c("Estimate", "SE"))
#' @export
extract_columns <- function(out, cols = NULL) {
  filter_one <- function(obj) {
    # Atomic vector → 1-row data frame
    if (is.atomic(obj) && !is.data.frame(obj) && !is.matrix(obj)) {
      obj <- as.data.frame(t(obj))
      colnames(obj) <- paste0("V", seq_len(ncol(obj)))
    }

    # Matrix → convert to data frame, preserve row names
    is_matrix <- is.matrix(obj)
    orig_rown <- if (is_matrix) rownames(obj) else NULL
    if (is_matrix) {
      obj <- as.data.frame(obj, stringsAsFactors = FALSE)
    }

    if (!is.data.frame(obj)) return(NULL)

    # If cols not provided, try using extract_intervals() to determine them
    if (is.null(cols)) {
      try({
        return(extract_intervals(obj))
      }, silent = TRUE)
      return(obj)  # fallback to returning full object if extract_intervals() fails
    }

    # Filter by column number or name
    if (is.numeric(cols)) {
      idx <- cols[cols >= 1 & cols <= ncol(obj)]
      result <- obj[, idx, drop = FALSE]
    } else if (is.character(cols)) {
      keep <- cols[cols %in% colnames(obj)]
      result <- obj[, keep, drop = FALSE]
    } else {
      result <- obj
    }

    # Return in original type
    if (is_matrix) {
      result <- as.matrix(result)
      if (!is.null(orig_rown) && nrow(result) == length(orig_rown)) {
        rownames(result) <- orig_rown
      }
    }

    result
  }

  if (is.null(out)) return(NULL)
  if (is.list(out) && !is.data.frame(out) && !is.matrix(out)) {
    return(lapply(out, filter_one))
  }
  filter_one(out)
}

#' Extract Rows from Data Frame, Matrix, or List
#'
#' Extract specified rows from a data frame, matrix, or list of such objects.
#'
#' @param out A data frame, matrix, atomic vector, or a list of such objects.
#' @param rows A numeric vector of row indices or a character vector of row names to retain. If NULL, all rows are returned.
#' @return The filtered object with only the specified rows. The output type matches the input (matrix, data frame, or list).
#' @examples
#' data.frame(A = 1:5, B = letters[1:5]) -> df
#' df |> extract_rows(c(1, 3))
#' @export
extract_rows <- function(out, rows = NULL) {
  filter_one <- function(obj) {
    # Atomic vector → data frame
    if (is.atomic(obj) && !is.data.frame(obj) && !is.matrix(obj)) {
      obj <- data.frame(value = obj)
    }

    # Matrix → convert to data frame, preserve names
    is_matrix <- is.matrix(obj)
    if (is_matrix) {
      obj_df <- as.data.frame(obj, stringsAsFactors = FALSE)
    } else {
      obj_df <- obj
    }

    if (!is.data.frame(obj_df)) return(NULL)

    # Default: all rows
    result <- if (is.null(rows)) {
      obj_df
    } else if (is.numeric(rows)) {
      idx <- rows[rows >= 1 & rows <= nrow(obj_df)]
      obj_df[idx, , drop = FALSE]
    } else if (is.character(rows)) {
      if (!is.null(rownames(obj_df))) {
        obj_df[rownames(obj_df) %in% rows, , drop = FALSE]
      } else {
        obj_df[0, , drop = FALSE]
      }
    } else {
      obj_df
    }

    # Restore to matrix if original was matrix
    if (is_matrix) {
      result_matrix <- as.matrix(result)
      colnames(result_matrix) <- colnames(result)  # restore col names
      rownames(result_matrix) <- rownames(result)  # preserve actual filtered row names
      return(result_matrix)
    }

    result
  }

  if (is.null(out)) return(NULL)
  if (is.list(out) && !is.data.frame(out) && !is.matrix(out)) {
    return(lapply(out, filter_one))
  }
  filter_one(out)
}

#' Extract Row or Column as Named Vector from Data Frame or Matrix
#'
#' Extract a single row or column from a matrix or data frame as a named vector.
#'
#' This function automatically detects whether the input corresponds to a row or a column and returns the result as a named vector. Names are preserved from the opposite dimension (column names for rows, row names for columns).
#'
#' @param data A matrix or data frame from which to extract data.
#' @param index A character or numeric value specifying the row or column to extract. If character, it is matched against row names first, then column names. If numeric, it is interpreted as a row index first, then a column index.
#' @return A named vector containing the extracted row or column values.
#' @examples
#' data.frame(
#'   M = c(1.1, 2.2, 3.3),
#'   SD = c(0.1, 0.2, 0.3),
#'   N = c(10, 20, 30),
#'   row.names = c("Group1", "Group2", "Group3")
#' ) -> df
#' df |> extract_vector("M")
#' df |> extract_vector("Group2")
#' @export
extract_vector <- function(data, index) {
  if (is.character(index) && index %in% rownames(data)) {
    vec <- data[index, ]           # drop=TRUE by default → atomic vector
    nms <- colnames(data)
    if (!is.null(nms) && length(vec) == length(nms)) {
      names(vec) <- nms
    }
    return(vec)
  }
  
  if (is.character(index) && index %in% colnames(data)) {
    vec <- data[, index]           # drop=TRUE by default
    nms <- rownames(data)
    if (!is.null(nms) && length(vec) == length(nms)) {
      names(vec) <- nms
    }
    return(vec)
  }
  
  if (is.numeric(index)) {
    if (index <= nrow(data)) {
      vec <- data[index, ]         # drop=TRUE by default
      nms <- colnames(data)
      if (!is.null(nms) && length(vec) == length(nms)) {
        names(vec) <- nms
      }
      return(vec)
    } else if (index <= ncol(data)) {
      vec <- data[, index]         # drop=TRUE by default
      nms <- rownames(data)
      if (!is.null(nms) && length(vec) == length(nms)) {
        names(vec) <- nms
      }
      return(vec)
    }
  }
  
  stop("Invalid index: not found in row or column names, or out of bounds.")
}

#' Extract Point Estimate and Confidence Interval Columns
#'
#' Extract the point estimate and confidence interval columns from a data frame, matrix, list, or t.test result.
#'
#' @param x A data frame, matrix, list with 'estimate' and 'interval' (or 'conf.int') elements, or a t.test (htest) result.
#' @return A matrix with columns: Estimate, LL, UL.
#' @examples
#' cbind(Estimate = c(10, 0, 5), LL = c(8, -1, 4), UL = c(12, 1, 6)) -> df
#' c("A", "B", "C") -> rownames(df)
#' df |> extract_intervals()
#'
#' # t.test result
#' set.seed(1); x <- rnorm(20, 10, 2)
#' t.test(x) |> extract_intervals()
#' @export
extract_intervals <- function(x) {
  if (is.list(x) && !is.data.frame(x) && !is.matrix(x)) {
    # Handle 'confintr' or t.test list-like objects
    has_estimate <- "estimate" %in% names(x)
    has_interval <- "interval" %in% names(x)
    has_conf_int <- "conf.int" %in% names(x)
    
    if (!has_estimate || !(has_interval || has_conf_int)) {
      stop("List object must contain 'estimate' and either 'interval' or 'conf.int' elements.")
    }
    
    ci <- if (has_interval) x$interval else x$conf.int
    if (length(ci) != 2) {
      stop("Interval element must be a vector of length 2.")
    }
    
    # Handle estimate: single value or two-sample difference
    if (length(x$estimate) == 1L) {
      est <- unname(x$estimate)
    } else if (length(x$estimate) == 2L) {
      # Two-sample t.test: compute second - first and flip CI
      est <- unname(x$estimate[2] - x$estimate[1])
      ci <- -rev(ci)
    } else {
      est <- unname(x$estimate[1])  # Fallback: use first element
    }

    return(matrix(
      c(est, ci[1], ci[2]),
      nrow = 1,
      dimnames = list(NULL, c("Estimate", "LL", "UL"))
    ))
  }

  # Otherwise assume it's a data frame or matrix
  colnames_x <- tolower(colnames(x))

  est_patterns <- c("estimate", "est", "beta", "effect", "coef", "coefficient")
  ll_patterns  <- c("ll", "lower", "lowerlimit", "ci_lower", "lcl")
  ul_patterns  <- c("ul", "upper", "upperlimit", "ci_upper", "ucl")

  est_idx <- which(colnames_x %in% est_patterns)[1]
  ll_idx  <- which(colnames_x %in% ll_patterns)[1]
  ul_idx  <- which(colnames_x %in% ul_patterns)[1]

  if (is.na(ll_idx) || is.na(ul_idx)) {
    stop("Could not identify lower and upper confidence interval columns.")
  }

  if (is.na(est_idx)) {
    est_idx <- 1  # Default to first column if no estimate found
  }

  x[, c(est_idx, ll_idx, ul_idx), drop = FALSE]
}
