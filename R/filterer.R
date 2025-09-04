# DEVISE
## Matrix Filtering

#' Extract Row or Column as Named Vector from Data Frame or Matrix
#'
#' This function extracts a single row or column from a matrix or data frame
#' by name or index. It automatically detects whether the input corresponds to
#' a row or a column and returns the result as a named vector. The names are
#' preserved from the opposite dimension (column names for rows, row names for columns).
#'
#' @param data A matrix or data frame from which to extract data.
#' @param index A character or numeric value specifying the row or column to extract.
#'   If character, it is matched against row names first, then column names.
#'   If numeric, it is interpreted as a row index first, then a column index.
#'
#' @return A named vector containing the extracted row or column values.
#'
#' @examples
#' input <- data.frame(
#'   m = c(1.1, 2.2, 3.3),
#'   sd = c(0.1, 0.2, 0.3),
#'   n = c(10, 20, 30),
#'   row.names = c("group1", "group2", "group3")
#' )
#'
#' # Extract column "m" as named vector (names are row names)
#' extract(input, "m")
#'
#' # Extract row "group2" as named vector (names are column names)
#' extract(input, "group2")
#'
#' @export
extract <- function(data, index) {
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

#' Filter Columns from Data Frame, Matrix, or List
#'
#' Filters specified columns from a data frame, matrix, or list of such objects.
#'
#' @param out A data frame, matrix, atomic vector, or a list of such objects.
#' @param cols A numeric vector of column indices or a character vector of column names to keep.
#'
#' @return A filtered object with only the specified columns. The output will match the input type (matrix, data frame, or list).
#'
#' @examples
#' df <- data.frame(Estimate = 1:3, SE = 0.1, Extra = 4:6)
#' columns(df, cols = c("Estimate", "SE"))
#'
#' @export
columns <- function(out, cols = NULL) {
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

    # If cols not provided, try using intervals() to determine them
    if (is.null(cols)) {
      try({
        return(intervals(obj))
      }, silent = TRUE)
      return(obj)  # fallback to returning full object if intervals() fails
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

#' Filter Rows from Data Frame, Matrix, or List
#'
#' Filters specified rows from a data frame, matrix, or list of such objects.
#'
#' @param out A data frame, matrix, atomic vector, or a list of such objects.
#' @param rows A numeric vector of row indices or a character vector of row names to retain. If `NULL`, all rows are returned.
#'
#' @return A filtered object with only the specified rows. The output will match the input type (matrix, data frame, or list).
#'
#' @examples
#' df <- data.frame(A = 1:5, B = letters[1:5])
#' rows(df, rows = c(1, 3))
#'
#' @export
rows <- function(out, rows = NULL) {
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

#' Set Row Names of a Data Frame
#'
#' Assign row names to a data frame in a pipe-friendly way.
#' 
#' **Note:** This function does **not** modify the original data frame in place.
#' You must assign the result back to a variable.
#'
#' @param x A data frame.
#' @param names A character vector of row names. Must have length equal to `nrow(x)`.
#'
#' @return A data frame identical to `x` but with updated row names.
#' @examples
#' df <- data.frame(a = 1:3, b = 4:6)
#' df <- df |> rownamer(c("A", "B", "C"))  # Must assign back to df
#' @export
rownamer <- function(x, names) {
  rownames(x) <- names
  x
}

#' Set Column Names of a Data Frame
#'
#' Assign column names to a data frame in a pipe-friendly way.
#' 
#' **Note:** This function does **not** modify the original data frame in place.
#' You must assign the result back to a variable.
#'
#' @param x A data frame.
#' @param names A character vector of column names. Must have length equal to `ncol(x)`.
#'
#' @return A data frame identical to `x` but with updated column names.
#' @examples
#' df <- data.frame(a = 1:3, b = 4:6)
#' df <- df |> colnamer(c("First", "Second"))  # Must assign back to df
#' @export
colnamer <- function(x, names) {
  colnames(x) <- names
  x
}

#' Extract Point Estimate and Confidence Interval Columns
#'
#' Selects the point estimate and confidence interval columns from a data frame, matrix, or list.
#'
#' @param x A data frame, matrix, or list with `estimate` and `interval` elements.
#'
#' @return A data frame or matrix with columns: Estimate, LL, UL.
#'
#' @export
intervals <- function(x) {
  if (is.list(x) && !is.data.frame(x) && !is.matrix(x)) {
    # Handle 'confintr' list-like objects
    if (!all(c("estimate", "interval") %in% names(x))) {
      stop("List object must contain 'estimate' and 'interval' elements.")
    }
    if (length(x$interval) != 2) {
      stop("'interval' element must be a vector of length 2.")
    }

    return(matrix(
      c(x$estimate, x$interval[1], x$interval[2]),
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
