# DEVISE
## Matrix Formatting

### Basic Formatting

format_matrix <- function(results, digits = 3, padding = 0, width = 8, ...) {
  if (is.null(width)) width <- digits + (padding * 2)
  colnames(results) <- format(colnames(results), width = width, justify = "right")
  format(as.matrix(round(results, digits = digits)), width = width, justify = "right", digits = digits, nsmall = digits, trim = TRUE, scientific = FALSE, ...)
}

format_table <- function(results, digits = 3, padding = 0, width = 8, ...) {
  if (is.null(width)) width <- digits + (padding * 2)
  colnames(results) <- format(colnames(results), width = width, justify = "right")
  noquote(format(as.matrix(round(results, digits = digits)), width = width, justify = "right", digits = digits, nsmall = digits, trim = TRUE, scientific = FALSE, ...))
}

unformat_matrix <- function(results) {
  results <- as.matrix(results)
  results_clean <- gsub("[,$]", "", results)
  apply(results_clean, c(1, 2), as.numeric)
}

### Style Tables

style_md <- function(display_matrix, title = NULL, spacing = 1) {
  mat <- as.matrix(display_matrix)
  
  # Row and column names
  row_labels <- rownames(mat)
  col_labels <- colnames(mat)

  # Determine width of row label column
  row_label_width <- max(nchar(row_labels))
  
  # Determine widths for each data column
  data_col_widths <- apply(mat, 2, function(col) max(nchar(col)))
  header_col_widths <- nchar(col_labels)
  col_widths <- pmax(data_col_widths, header_col_widths)

  # Format column headers (left-align first col, rest right)
  header_cells <- c(
    format("", width = row_label_width, justify = "left"),
    mapply(format, col_labels, width = col_widths, justify = "right", USE.NAMES = FALSE)
  )
  header_line <- paste0("| ", paste(header_cells, collapse = " | "), " |")

  # Format separator line (left-align for first, right-align rest)
  separator_cells <- c(
    paste(rep("-", row_label_width), collapse = ""),
    sapply(col_widths, function(w) paste0(paste(rep("-", w - 1), collapse = ""), ":"), USE.NAMES = FALSE)
  )
  separator_line <- paste0("| ", paste(separator_cells, collapse = " | "), " |")

  # Format data rows (left-align first col, rest right)
  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- format(row_labels[i], width = row_label_width, justify = "left")
    row_cells <- mapply(format, mat[i, ], width = col_widths, justify = "right", USE.NAMES = FALSE)
    paste0("| ", paste(c(row_name, row_cells), collapse = " | "), " |")
  })

  # Optional title
  title_block <- NULL
  if (!is.null(title)) {
    title_lines <- strsplit(title, "\n", fixed = TRUE)[[1]]
    title_block <- c(title_lines, "")  # One blank line after title
  }

  # Blank lines before and after the table
  blank_lines <- rep("", spacing)

  # Compose full output
  md_output <- c(
    blank_lines,
    title_block,
    header_line,
    separator_line,
    data_lines,
    blank_lines
  )

  # Print
  cat(paste(md_output, collapse = "\n"), "\n")
}


style_apa <- function(display_matrix, title = NULL, spacing = 1) {
  mat <- as.matrix(display_matrix)
  
  # Row and column labels
  row_labels <- rownames(mat)
  col_labels <- colnames(mat)

  # Compute column widths
  row_label_width <- max(nchar(row_labels))
  data_col_widths <- apply(mat, 2, function(col) max(nchar(col)))
  header_col_widths <- nchar(col_labels)
  col_widths <- pmax(data_col_widths, header_col_widths)

  # Format header row (left-align first, right-align rest)
  header_cells <- mapply(format, col_labels, width = col_widths, justify = "right", USE.NAMES = FALSE)
  header_line <- paste0(
    format("", width = row_label_width, justify = "left"), " ",
    paste(header_cells, collapse = " ")
  )

  # Total table width
  total_width <- nchar(header_line)
  horizontal_line <- strrep("-", total_width)

  # Format data rows (left-align first, right-align rest)
  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- format(row_labels[i], width = row_label_width, justify = "left")
    row_cells <- mapply(format, mat[i, ], width = col_widths, justify = "right", USE.NAMES = FALSE)
    paste0(row_name, " ", paste(row_cells, collapse = " "))
  })

  # Optional left-aligned title with one blank line below
  title_block <- if (!is.null(title)) {
    c(title, "")
  } else {
    NULL
  }

  # Blank lines before and after the full block
  blank_lines <- rep("", spacing)

  # Compose output
  apa_output <- c(
    blank_lines,
    title_block,
    horizontal_line,
    header_line,
    horizontal_line,
    data_lines,
    horizontal_line,
    blank_lines
  )

  # Print
  cat(paste(apa_output, collapse = "\n"), "\n")
}


style_plain <- function(display_matrix, title = NULL, spacing = 1) {
  mat <- as.matrix(display_matrix)
  
  row_labels <- rownames(mat)
  col_labels <- colnames(mat)
  
  # Calculate widths
  row_label_width <- max(nchar(row_labels))
  col_widths <- sapply(seq_len(ncol(mat)), function(j) {
    max(nchar(c(col_labels[j], mat[, j])))
  })
  
  # Format header line (left-align row label column)
  header_cells <- mapply(format, col_labels, width = col_widths, justify = "right", USE.NAMES = FALSE)
  header_line <- paste0(format("", width = row_label_width, justify = "left"), " ", paste(header_cells, collapse = " "))
  
  # Format data rows (left-align row labels)
  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- format(row_labels[i], width = row_label_width, justify = "left")
    row_cells <- mapply(format, mat[i, ], width = col_widths, justify = "right", USE.NAMES = FALSE)
    paste0(row_name, " ", paste(row_cells, collapse = " "))
  })
  
  # Title and spacing
  title_block <- if (!is.null(title)) c(title, "") else NULL
  blank_lines <- rep("", spacing)
  
  # Output without horizontal rules
  output <- c(
    blank_lines,
    title_block,
    header_line,
    data_lines,
    blank_lines
  )
  
  cat(paste(output, collapse = "\n"), "\n")
}
