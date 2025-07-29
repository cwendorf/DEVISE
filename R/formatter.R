# DEVISE
## Matrix Formatting

### Basic Formatting

format_matrix <- function(results, digits = 3, padding = 0, width = 8, ...) {
  if (is.null(width)) width <- digits + (padding * 2)
  colnames(results) <- format(colnames(results), width = width, justify = "right")
  noquote(format(as.matrix(round(results, digits = digits)), width = width, justify = "right", digits = digits, nsmall = digits, trim = TRUE, scientific = FALSE, ...))
}

unformat_matrix <- function(results) {
  results <- as.matrix(results)
  results_clean <- gsub("[,$]", "", results)
  apply(results_clean, c(1, 2), as.numeric)
}

### Advanced Formatting and Printing

#' Print Formatted Matrix as Markdown Table
#'
#' Outputs a matrix or data frame in GitHub-flavored Markdown table format,
#' with aligned columns, optional row names, and a title header.
#'
#' @param results A numeric matrix or data frame.
#' @param title Optional character title to display above the table.
#' @param spacing Number of blank lines before and after the table.
#' @param digits Number of decimal digits to display.
#' @param width Minimum width of each numeric column.
#'
#' @return Invisibly returns NULL. Prints the formatted Markdown table to the console.
#' @export
style_md <- function(results, title = NULL, spacing = 1, digits = 3, width = 8) {

  if (is.null(title)) {
    title <- comment(results)
  }

  mat <- as.matrix(results)
  row_labels <- rownames(mat)
  col_labels <- colnames(mat)

  # Format numeric matrix (preserves trailing zeros)
  mat <- round(mat, digits = digits)
  mat <- format(mat, digits = digits, nsmall = digits, width = width, justify = "right", trim = TRUE, scientific = FALSE)

  # Calculate widths
  row_label_width <- if (!is.null(row_labels)) max(nchar(row_labels)) else 0
  data_col_widths <- apply(mat, 2, function(col) max(nchar(col)))
  col_labels_formatted <- format(col_labels, width = data_col_widths, justify = "right")
  col_widths <- pmax(data_col_widths, nchar(col_labels_formatted))  # ensure final alignment

  # Format header row
  header_cells <- c(
    if (row_label_width > 0) format("", width = row_label_width, justify = "left") else NULL,
    mapply(format, col_labels, width = col_widths, MoreArgs = list(justify = "right"))
  )
  header_line <- paste0("| ", paste(header_cells, collapse = " | "), " |")

  # Markdown separator line (right-aligned)
  separator_cells <- c(
    if (row_label_width > 0) strrep("-", row_label_width) else NULL,
    sapply(col_widths, function(w) paste0(strrep("-", w - 1), ":"))
  )
  separator_line <- paste0("| ", paste(separator_cells, collapse = " | "), " |")

  # Format data rows
  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- if (!is.null(row_labels)) format(row_labels[i], width = row_label_width, justify = "left") else NULL
    row_cells <- mapply(format, mat[i, ], width = col_widths, MoreArgs = list(justify = "right"))
    paste0("| ", paste(c(row_name, row_cells), collapse = " | "), " |")
  })

  # Title and spacing
  title_block <- if (!is.null(title)) c(title, "") else NULL
  blank_lines <- rep("", spacing)

  md_output <- c(
    blank_lines,
    title_block,
    header_line,
    separator_line,
    data_lines,
    blank_lines
  )

  cat(paste(md_output, collapse = "\n"), "\n")
}

#' Print Formatted Matrix in APA Style Table
#'
#' Displays a matrix or data frame in a plain-text APA-style format, using
#' aligned numeric columns, horizontal dividers, and optional row names.
#'
#' @param results A numeric matrix or data frame.
#' @param title Optional character title to display above the table.
#' @param spacing Number of blank lines before and after the table.
#' @param digits Number of decimal digits to display.
#' @param width Minimum width of each numeric column.
#'
#' @return Invisibly returns NULL. Prints the formatted APA-style table to the console.
#' @export
style_apa <- function(results, title = NULL, spacing = 1, digits = 3, width = 8) {

  if (is.null(title)) {
    title <- comment(results)
  }

  mat <- round(as.matrix(results), digits = digits)
  mat <- format(mat, digits = digits, nsmall = digits, width = width,
                justify = "right", trim = TRUE, scientific = FALSE)

  row_labels <- rownames(mat)
  col_labels <- colnames(mat)

  row_label_width <- if (!is.null(row_labels)) max(nchar(row_labels)) else 0
  col_widths <- apply(mat, 2, function(col) max(nchar(col)))
  col_labels_formatted <- format(col_labels, width = col_widths, justify = "right")

  header_line <- paste0(
    format("", width = row_label_width, justify = "left"), " ",
    paste(col_labels_formatted, collapse = " ")
  )

  total_width <- nchar(header_line)
  horizontal_line <- strrep("-", total_width)

  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- if (!is.null(row_labels)) format(row_labels[i], width = row_label_width, justify = "left") else ""
    row_cells <- mapply(format, mat[i, ], width = col_widths, MoreArgs = list(justify = "right"))
    paste0(row_name, " ", paste(row_cells, collapse = " "))
  })

  title_block <- if (!is.null(title)) c(title, "") else NULL
  blank_lines <- rep("", spacing)

  output <- c(
    blank_lines,
    title_block,
    horizontal_line,
    header_line,
    horizontal_line,
    data_lines,
    horizontal_line,
    blank_lines
  )

  cat(paste(output, collapse = "\n"), "\n")
}

#' Print Formatted Matrix in Plain Text Format
#'
#' Outputs a matrix or data frame in plain text format, with aligned numeric
#' columns and optional row names. Useful for basic console printing.
#'
#' @param results A numeric matrix or data frame.
#' @param title Optional character title to display above the table.
#' @param spacing Number of blank lines before and after the table.
#' @param digits Number of decimal digits to display.
#' @param width Minimum width of each numeric column.
#'
#' @return Invisibly returns NULL. Prints the formatted plain-text table to the console.
#' @export
style_plain <- function(results, title = NULL, spacing = 1, digits = 3, width = 8) {

  if (is.null(title)) {
    title <- comment(results)
  }

  mat <- round(as.matrix(results), digits = digits)
  mat <- format(mat, digits = digits, nsmall = digits, width = width,
                justify = "right", trim = TRUE, scientific = FALSE)

  row_labels <- rownames(mat)
  col_labels <- colnames(mat)

  row_label_width <- if (!is.null(row_labels)) max(nchar(row_labels)) else 0
  col_widths <- apply(mat, 2, function(col) max(nchar(col)))
  col_labels_formatted <- format(col_labels, width = col_widths, justify = "right")

  header_line <- paste0(
    if (row_label_width > 0) format("", width = row_label_width, justify = "left") else "",
    " ",
    paste(col_labels_formatted, collapse = " ")
  )

  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- if (!is.null(row_labels)) format(row_labels[i], width = row_label_width, justify = "left") else ""
    row_cells <- mapply(format, mat[i, ], width = col_widths, MoreArgs = list(justify = "right"))
    paste0(row_name, " ", paste(row_cells, collapse = " "))
  })

  title_block <- if (!is.null(title)) c(title, "") else NULL
  blank_lines <- rep("", spacing)

  output <- c(
    blank_lines,
    title_block,
    header_line,
    data_lines,
    blank_lines
  )

  cat(paste(output, collapse = "\n"), "\n")
}

#' Print Formatted Matrix in Boxed Table Format
#'
#' Outputs a matrix or data frame in a visually distinct boxed format with
#' borders, aligned numeric columns, and optional row names.
#'
#' @param results A numeric matrix or data frame.
#' @param title Optional character title to display above the table.
#' @param spacing Number of blank lines before and after the table.
#' @param digits Number of decimal digits to display.
#' @param width Minimum width of each numeric column.
#'
#' @return Invisibly returns NULL. Prints the boxed table to the console.
#' @export
style_boxed <- function(results, title = NULL, spacing = 1, digits = 3, width = 8) {

  if (is.null(title)) {
    title <- comment(results)
  }

  mat <- round(as.matrix(results), digits = digits)
  mat <- format(mat, digits = digits, nsmall = digits, width = width,
                justify = "right", trim = TRUE, scientific = FALSE)

  row_labels <- rownames(mat)
  col_labels <- colnames(mat)

  row_label_width <- if (!is.null(row_labels)) max(nchar(row_labels)) else 0
  col_widths <- apply(mat, 2, function(col) max(nchar(col)))
  col_labels_formatted <- format(col_labels, width = col_widths, justify = "right")
  full_col_widths <- c(row_label_width, col_widths)

  draw_border <- function(widths, left = "+", mid = "+", right = "+", fill = "-") {
    parts <- mapply(function(w) strrep(fill, w + 2), widths, SIMPLIFY = TRUE)
    paste0(left, paste(parts, collapse = mid), right)
  }

  draw_row <- function(cells, widths) {
    contents <- mapply(function(cell, w) {
      paste0(" ", format(cell, width = w, justify = "right"), " ")
    }, cells, widths, SIMPLIFY = TRUE)
    paste0("|", paste(contents, collapse = "|"), "|")
  }

  header_cells <- c("", col_labels_formatted)
  header_line <- draw_row(header_cells, full_col_widths)

  data_lines <- sapply(seq_len(nrow(mat)), function(i) {
    row_name <- if (!is.null(row_labels)) format(row_labels[i], width = row_label_width, justify = "left") else ""
    row_cells <- mapply(format, mat[i, ], width = col_widths, MoreArgs = list(justify = "right"))
    draw_row(c(row_name, row_cells), full_col_widths)
  })

  top_border <- draw_border(full_col_widths)
  mid_border <- draw_border(full_col_widths)
  bottom_border <- draw_border(full_col_widths)

  title_block <- if (!is.null(title)) c(title, "") else NULL
  blank_lines <- rep("", spacing)

  boxed_output <- c(
    blank_lines,
    title_block,
    top_border,
    header_line,
    mid_border,
    data_lines,
    bottom_border,
    blank_lines
  )

  cat(paste(boxed_output, collapse = "\n"), "\n")
}


#' Format and Print a Matrix Using a Selected Table Style
#'
#' Applies a consistent, formatted style to a numeric matrix or data frame and prints
#' it to the console. Supports multiple output styles including plain text, APA format,
#' boxed layout, and Markdown.
#'
#' @param results A numeric matrix or data frame to format.
#' @param digits Number of decimal digits to display in the formatted output.
#' @param width Minimum column width for numeric values.
#' @param style A character string specifying the output style. One of `"plain"`, `"apa"`, `"boxed"`, or `"md"`.
#' @param title Optional title to be displayed above the table.
#' @param spacing Number of blank lines to include above and below the table.
#'
#' @details
#' This is a convenience wrapper that dispatches to the appropriate table styling function:
#' \itemize{
#'   \item \code{style_plain()} - Simple plain-text format
#'   \item \code{style_apa()} - APA-style layout with rules
#'   \item \code{style_boxed()} - Boxed ASCII-style table
#'   \item \code{style_md()} - GitHub-flavored Markdown table
#' }
#'
#' @return Invisibly returns \code{NULL}. The table is printed to the console.
#' @export
print_table <- function(results, digits = 3, width = 8, style = c("plain", "apa", "boxed", "md"), title = NULL, spacing = 1) {
  style <- match.arg(style)
  
  # Dispatch to style function directly, passing results as-is
  switch(
    style,
    plain = style_plain(results, title = title, digits = digits, width = width, spacing = spacing),
    apa   = style_apa(results, title = title, digits = digits, width = width, spacing = spacing),
    boxed = style_boxed(results, title = title, digits = digits, width = width, spacing = spacing),
    md    = style_md(results, title = title, digits = digits, width = width, spacing = spacing)
  )
}
