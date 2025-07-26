# DEVISE
## Interval Plots

# Helper function to find LL and UL columns flexibly
find_interval_columns <- function(colnames) {
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


plot_set <- function(results, 
                    main = NULL, 
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

  if (is.null(main)) main <- comment(results)
  main <- paste(strwrap(main, width = 0.7 * getOption("width")), collapse = "\n")
  
  # Keep the first column for point estimates, find LL and UL dynamically
  cols <- find_interval_columns(colnames(results))
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


plot_comp <- function(results, 
                    main = NULL, 
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

  if (is.null(main)) main <- comment(results)
  main <- paste(strwrap(main, width = 0.7 * getOption("width")), collapse = "\n")
  
  cols <- find_interval_columns(colnames(results))
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
