# DEVISE
## Matrix Handling


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
columns <- function(out, cols = c("Estimate", "SE", "df", "LL", "UL")) {
  filter_one <- function(obj) {
    # Atomic vector → 1-row data frame
    if (is.atomic(obj) && !is.data.frame(obj) && !is.matrix(obj)) {
      obj <- as.data.frame(t(obj))
      colnames(obj) <- paste0("V", seq_len(ncol(obj)))
    }

    # Matrix → convert to data frame
    is_matrix <- is.matrix(obj)
    if (is_matrix) {
      rown <- rownames(obj)
      obj <- as.data.frame(obj, stringsAsFactors = FALSE)
    }

    if (!is.data.frame(obj)) return(NULL)

    # Filter by column number or name
    result <- if (is.numeric(cols)) {
      idx <- cols[cols >= 1 & cols <= ncol(obj)]
      obj[, idx, drop = FALSE]
    } else if (is.character(cols)) {
      keep <- intersect(cols, colnames(obj))
      obj[, keep, drop = FALSE]
    } else {
      obj
    }

    # Return in original type
    if (is_matrix) {
      result <- as.matrix(result)
      if (!is.null(rown)) rownames(result) <- rown
    }

    result
  }

  if (is.list(out)) {
    result <- lapply(out, filter_one)
    names(result) <- names(out)
    return(result)
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

  if (is.list(out)) {
    result <- lapply(out, filter_one)
    names(result) <- names(out)
    return(result)
  }

  filter_one(out)
}
