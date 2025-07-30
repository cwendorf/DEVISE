# DEVISE
## Interval Plots

#' Find Confidence Interval Columns by Common Aliases
#'
#' Identifies the lower and upper limit columns in a dataset using common naming conventions.
#' This helper function searches for column names that match typical labels for lower and upper
#' confidence interval bounds (e.g., "ll", "ul", "lower", "upper", "ci_lower", etc.).
#'
#' @param colnames A character vector of column names (e.g., from `colnames(dataframe)`).
#'
#' @return An integer vector of length 2. The first element is the index of the lower limit column,
#' and the second is the index of the upper limit column.
#' 
#' @noRd
find_intervals <- function(colnames) {
  ll_patterns <- c("ll", "lower", "lowerlimit", "ci_lower", "lcl")
  ul_patterns <- c("ul", "upper", "upperlimit", "ci_upper", "ucl")
  
  find_col <- function(patterns) {
    idx <- which(tolower(colnames) %in% patterns)
    if (length(idx) == 0) stop("Could not find LL or UL columns with reasonable aliases.")
    idx[1]
  }
  
  ll_idx <- find_col(ll_patterns)
  ul_idx <- find_col(ul_patterns)
  
  c(ll_idx, ul_idx)
}

#' Plot Point Estimates with Confidence Intervals
#'
#' Creates an interval plot displaying point estimates and their associated lower and upper
#' confidence bounds for a set of outcomes. Useful for visualizing statistical estimates across
#' multiple conditions or variables.
#'
#' @param results A data frame or matrix containing point estimates in the first column, and
#' confidence limits in columns that match common naming patterns (e.g., "ll", "ul", "ci_lower", "ci_upper").
#' @param title Character string for the plot title. If `NULL`, the function uses the `comment()` attribute of `results`.
#' @param ylab Character label for the Y-axis.
#' @param xlab Character label for the X-axis.
#' @param ylim Numeric vector specifying Y-axis limits. If `NULL`, limits are auto-calculated.
#' @param digits Number of decimal places for value labels if `values = TRUE`.
#' @param offset Numeric horizontal offset to nudge plotted points (useful for overlapping points).
#' @param pch Plotting character (point shape).
#' @param col Color for points and interval lines.
#' @param points Logical; if `TRUE`, draws point estimates.
#' @param intervals Logical; if `TRUE`, draws confidence intervals.
#' @param values Logical; if `TRUE`, displays numeric values beside points and intervals.
#' @param pos Integer or vector specifying text position relative to points (see `text()`).
#' @param connect Logical; if `TRUE`, connects adjacent points with arrows.
#' @param line Numeric; if specified, draws a horizontal reference line at the given Y value.
#' @param rope Numeric vector of length 2 indicating a "region of practical equivalence" to shade.
#' @param ... Additional graphical parameters passed to `plot()`.
#'
#' @return Invisibly returns the `results` object (modified to include only point and interval columns).
#'
#' #' @examples
#' # Create example data frame with estimate and confidence intervals
#' results <- data.frame(
#'   estimate = c(0.3, 0.5, 0.7),
#'   ci_lower = c(0.1, 0.3, 0.5),
#'   ci_upper = c(0.5, 0.7, 0.9)
#' )
#' rownames(results) <- c("A", "B", "C")
#'
#' # Basic interval plot
#' plot_set(results)
#'
#' # Add value labels and a horizontal reference line at 0
#' plot_set(results, values = TRUE, line = 0)
#'
#' # Customize point style and add rope
#' plot_set(results, pch = 19, col = "blue", rope = c(-0.1, 0.1))
#'
#' @export
plot_set <- function(results, 
                    title = NULL, 
                    ylab = "Outcome", 
                    xlab = "", 
                    ylim = NULL, 
                    digits = 3,
                    offset = 0,
                    pch = 16, 
                    col = "black", 
                    points = TRUE, 
                    intervals = TRUE,
                    values = FALSE,
                    pos = 2,
                    connect = FALSE,
                    line = NULL,
                    rope = NULL,
                    ...) {

  if (is.null(title)) title <- comment(results)
  main <- paste(strwrap(title, width = 0.7 * getOption("width")), collapse = "\n")
  
  cols <- find_intervals(colnames(results))
  results <- results[, c(1, cols), drop = FALSE]
  
  if (is.null(ylim)) {
    ylim <- range(pretty(c(floor(min(results[, 2]) - 0.5), ceiling(max(results[, 3]) + 0.5))))
  }
  
  par(mar = c(5, 5, 5, 3))
  plot(NULL, xaxs = "i", yaxs = "i", xaxt = "n", 
       xlim = c(0.4, nrow(results) + 0.6), ylim = ylim, 
       xlab = xlab, cex.lab = 1.15, ylab = ylab, main = main, las = 1, bty = "l")
  axis(1, seq_len(nrow(results)), row.names(results))
  
  if (points) {
    points(seq_len(nrow(results)) + offset, results[, 1], pch = pch, cex = 1.5, col = col, lwd = 2)
  }
  
  if (intervals) {
    arrows(seq_len(nrow(results)) + offset, results[, 2], seq_len(nrow(results)) + offset, results[, 3], col = col, lwd = 2, length = 0)
  }
  
  if (connect && nrow(results) > 1) {
    for (i in 1:(nrow(results) - 1)) {
      arrows(i + offset, results[i, 1], i + 1 + offset, results[i + 1, 1], code = 3, length = 0, lty = 1, col = "black")
    }
  }
  
  if (!is.null(line)) {
    abline(h = line, lty = 2, col = "black")
  }
  
  if (!is.null(rope)) {
    rect(0, rope[1], nrow(results) + 1, rope[2], col = rgb(0, 0, 0, alpha = 0.1), border = NA)
  }
  
  if (values) {
    formatted <- apply(results, 2, function(x) format(round(x, digits), trim = TRUE, nsmall = digits, scientific = FALSE))
    text(seq_len(nrow(results)) + offset, results[, 1], formatted[, 1], cex = 0.8, pos = pos, offset = 0.5, font = 2, col = col)
    text(seq_len(nrow(results)) + offset, results[, 2], formatted[, 2], cex = 0.8, pos = pos, offset = 0.5, col = col)
    text(seq_len(nrow(results)) + offset, results[, 3], formatted[, 3], cex = 0.8, pos = pos, offset = 0.5, col = col)
  }

  invisible(results)
}

#' Plot Comparison of Two Groups with Difference Estimate
#'
#' Plots two group means and their confidence intervals, along with a third point showing the
#' estimated difference and its interval. Designed for paired or between-group comparisons.
#'
#' @param results A data frame or matrix with three rows: two group estimates and a third row for
#' the difference (with placeholder values in the first two columns).
#' @param title Character string for the plot title. If `NULL`, uses the `comment()` attribute of `results`.
#' @param ylab Character label for the Y-axis.
#' @param xlab Character label for the X-axis.
#' @param ylim Numeric vector specifying Y-axis limits. If `NULL`, they are auto-computed.
#' @param slab Label for the secondary Y-axis (typically "Difference").
#' @param rope Numeric vector of length 2 defining a shaded region of practical equivalence (on the difference scale).
#' @param digits Number of decimal places for value labels if `values = TRUE`.
#' @param values Logical; if `TRUE`, displays numeric values beside points and intervals.
#' @param connect Logical; if `TRUE`, draws a connecting line between group points.
#' @param pos Integer vector specifying text positions (used for estimate, lower, upper labels).
#' @param pch Vector of plotting characters for each point (e.g., group1, group2, diff).
#' @param col Color for all plotted elements.
#' @param offset Numeric horizontal offset to avoid overlapping points.
#' @param points Logical; if `TRUE`, draws the three points.
#' @param intervals Logical; if `TRUE`, draws confidence intervals.
#' @param lines Logical; if `TRUE`, adds horizontal dashed lines from group points to difference estimate.
#' @param ... Additional graphical parameters passed to `plot()`.
#'
#' @return Invisibly returns the `results` object (modified to include only point and interval columns).
#'
#' #' @examples
#' # Create comparison data for two groups and their difference
#' comp_data <- data.frame(
#'   estimate = c(0.6, 0.4, 0.2),
#'   ci_lower = c(0.4, 0.2, 0.0),
#'   ci_upper = c(0.8, 0.6, 0.4)
#' )
#' rownames(comp_data) <- c("Group 1", "Group 2", "Difference")
#'
#' # Basic comparison plot
#' plot_comp(comp_data)
#'
#' # Add ROPE, value labels, and connect groups
#' plot_comp(comp_data, rope = c(-0.1, 0.1), values = TRUE, connect = TRUE)
#'
#' # Customize plotting characters and color
#' plot_comp(comp_data, pch = c(15, 17, 18), col = "darkgreen", lines = FALSE)
#'
#' @export
plot_comp <- function(results, 
                    title = NULL, 
                    ylab = "Outcome", 
                    xlab = "", 
                    ylim = NULL, 
                    slab = "Difference", 
                    rope = NULL, 
                    digits = 3,
                    values = FALSE, 
                    connect = FALSE, 
                    pos = c(2, 2, 4), 
                    pch = c(15, 15, 17), 
                    col = "black", 
                    offset = 0, 
                    points = TRUE, 
                    intervals = TRUE, 
                    lines = TRUE, 
                    ...) {

  if (is.null(title)) title <- comment(results)
  main <- paste(strwrap(title, width = 0.7 * getOption("width")), collapse = "\n")
  
  cols <- find_intervals(colnames(results))
  results <- results[, c(1, cols), drop = FALSE]
  
  graph <- results
  graph[3, ] <- results[3, ] + results[1, 1]
  
  if (is.null(ylim)) {
    ylim <- range(pretty(c(floor(min(graph[, 2]) - 0.5), ceiling(max(graph[, 3]) + 0.5))))
  }
  
  par(mar = c(5, 5, 5, 5))
  plot(NULL, xaxt = "n", yaxt = "n", xaxs = "i", yaxs = "i", 
       xlim = c(0.4, 3.6), ylim = ylim, 
       xlab = xlab, ylab = ylab, main = main, las = 1, cex.lab = 1.15, bty = "n")
  
  axis(1, 0.4:2.5, labels = FALSE, lwd.tick = 0)
  axis(1, 2.6:3.6, labels = FALSE, lwd.tick = 0)
  axis(1, at = c(1, 2), labels = rownames(graph)[1:2])
  axis(1, at = 3, labels = rownames(graph)[3])
  
  axis(2)
  axis(2, at = ylim, labels = FALSE, lwd.tick = 0)
  
  if (results[1, 1] < results[2, 1]) {
    td <- graph[1, 1] - axTicks(4)[max(which(axTicks(4) < graph[1, 1]))]
  } else {
    td <- graph[1, 1] - axTicks(4)[min(which(axTicks(4) > graph[1, 1]))]
  }
  
  val <- axTicks(4) - graph[1, 1] + td
  loc <- axTicks(4) + td
  axis(4, at = ylim, labels = FALSE, lwd.tick = 0)
  axis(4, at = loc, labels = val, las = 1)
  mtext(slab, side = 4, las = 3, cex = 1.15, line = 3)
  
  if (!is.null(rope)) {
    graphrope <- rope + as.vector(results[1, 1])
    rect(2.6, graphrope[1], 3.6, graphrope[2], col = rgb(0, 0, 0, alpha = 0.1), border = NA)
  }
  
  if (intervals) {
    arrows(1:3 + offset, graph[, 2], 1:3 + offset, graph[, 3], col = col, lwd = 2, length = 0)
  }
  
  if (points) {
    points(1:3 + offset, graph[, 1], pch = pch, cex = 1.5, col = col, lwd = 2)
  }
  
  if (lines) {
    arrows(c(1, 2, 4) + offset, graph[1:2, 1], 4, graph[1:2, 1], code = 3, length = 0, lty = 2, col = col)
  }
  
  if (connect) {
    arrows(1, results[1, 1], 2, results[2, 1], code = 3, length = 0, lty = 1, col = "black")
  }
  
  if (values) {
    formatted <- apply(results, 2, function(x) format(round(x, digits), trim = TRUE, nsmall = digits, scientific = FALSE))
    text(1:3 + offset, graph[, 1], formatted[, 1], cex = 0.8, pos = pos, offset = 0.5, font = 2, col = col)
    text(1:3 + offset, graph[, 2], formatted[, 2], cex = 0.8, pos = pos, offset = 0.5, col = col)
    text(1:3 + offset, graph[, 3], formatted[, 3], cex = 0.8, pos = pos, offset = 0.5, col = col)
  }

  invisible(results)
}
