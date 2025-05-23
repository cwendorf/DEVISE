# DEVISE
## Intervals

### Plot

plot.intervals.main <- function(results, add = FALSE, main = NULL, ylab = "Outcome", xlab = "", ylim = NULL, line = NULL, rope = NULL, values = TRUE, digits = 3, connect = FALSE, pos = 2, pch = 16, col = "black", offset = 0, points = TRUE, intervals = TRUE, ...) {
  out <- results
  if (is.null(main)) main <- comment(results)
  results <- results[, cbind(1, which(colnames(results) == "LL"), which(colnames(results) == "UL")), drop = FALSE]
  comment(results) <- main
  if (!add) plot.main(results, main, ylab, xlab, ylim)
  if (points) points(seq_len(nrow(results)) + offset, results[, 1], pch = pch, cex = 1.5, col = col, lwd = 2, bg = .colorIntensity(col, .6))
  if (intervals) arrows(seq_len(nrow(results)) + offset, results[, 2], seq_len(nrow(results)) + offset, results[, 3], col = col, lwd = 2, length = 0)
  if (connect) {
    if (nrow(results) > 1) {
      for (i in 1:(nrow(results) - 1)) arrows(i + offset, results[i, 1], i + 1 + offset, results[i + 1, 1], code = 3, length = 0, lty = 1, col = "black")
    }
  }
  if (!is.null(line)) {
    abline(h = line, lty = 2, col = "black")
  }
  if (!is.null(rope)) {
    rect(0, rope[1], nrow(results) + 1, rope[2], col = .colorTransparent("black", 15), border = NA)
  }
  if (values) {
    results <- .formatFrame(results, digits = digits)
    text(seq_len(nrow(results)) + offset, as.numeric(results[, 1]), results[, 1], cex = .8, pos = pos, offset = .5, font = 2, col = col)
    text(seq_len(nrow(results)) + offset, as.numeric(results[, 2]), results[, 2], cex = .8, pos = pos, offset = .5, col = col)
    text(seq_len(nrow(results)) + offset, as.numeric(results[, 3]), results[, 3], cex = .8, pos = pos, offset = .5, col = col)
  }
  invisible(out)
}

plot.intervals.comp <- function(results, add = FALSE, main = NULL, ylab = "Outcome", xlab = "", ylim = NULL, slab = "Difference", rope = NULL, values = TRUE, digits = 3, connect = FALSE, pos = c(2, 2, 4), pch = c(15, 15, 17), col = "black", offset = 0, points = TRUE, intervals = TRUE, lines = TRUE, ...) {
  out <- results
  if (is.null(main)) main <- comment(results)
  results <- results[, cbind(1, which(colnames(results) == "LL"), which(colnames(results) == "UL"))]
  comment(results) <- main
  if (!add) plot.comp(results, main, ylab, xlab, ylim, slab)
  graph <- results
  graph[3, ] <- results[3, ] + results[1, 1]
  if (points) points(1:3 + offset, graph[, 1], pch = pch, cex = 1.5, col = col, lwd = 2, bg = .colorIntensity(col, .6))
  if (intervals) arrows(1:3 + offset, graph[, 2], 1:3 + offset, graph[, 3], col = col, lwd = 2, length = 0)
  if (lines) arrows(c(1, 2, 4) + offset, graph[1:2, 1], 4, graph[1:2, 1], code = 3, length = 0, lty = 2, col = col)
  if (connect) {
    arrows(1, results[1, 1], 2, results[2, 1], code = 3, length = 0, lty = 1, col = "black")
  }
  if (!is.null(rope)) {
    graphrope <- rope + as.vector(results[1, 1])
    rect(2.6, graphrope[1], 3.6, graphrope[2], col = .colorTransparent("black", 15), border = NA)
  }
  if (values) {
    results <- .formatFrame(results, digits = digits)
    text(1:3 + offset, graph[, 1], results[, 1], cex = .8, pos = pos, offset = .5, font = 2, col = col)
    text(1:3 + offset, graph[, 2], results[, 2], cex = .8, pos = pos, offset = .5, col = col)
    text(1:3 + offset, graph[, 3], results[, 3], cex = .8, pos = pos, offset = .5, col = col)
  }
  invisible(out)
}

plot.intervals.multi <- function(results, main, ylab, xlab, col) {
  if (is.null(main)) main <- comment(results[[1]])
  main <- paste(strwrap(main, width = 0.7 * getOption("width")), collapse = "\n")
  ylimmin <- floor(min(unlist(lapply(results, FUN = function(x) min(x[,"LL"]))))) - .5
  ylimmax <- ceiling(max(unlist(lapply(results, FUN = function(x) max(x[,"UL"]))))) + .5
  ylimrange <- range(c(ylimmin, ylimmax))
  xlimrange <- c(.4, nrow(results[[1]]) + .6)
  plot(NULL, xaxs = "i", yaxs = "i", xaxt = "n", xlim = xlimrange, ylim = ylimrange, ylab = ylab, xlab = xlab, cex.lab = 1.15, main = main, bty = "l")
  axis(1, 1:nrow(results[[1]]), row.names(results[[1]]))
  for (i in seq_along(results)) {
    if (length(col) == 1) {
      tempcol <- col
    } else {
      tempcol <- col[i]
    }
    for (j in 1:nrow(results[[i]])) {
      lines(x = c(j + (i - (length(results) + 1) / 2) * .15, j + (i - (length(results) + 1) / 2) * .15), y = c(results[[i]][, 4][j], results[[i]][, 5][j]), lwd = 2, col = tempcol)
    }
    if (class(results) == "wsml") lines(1:nrow(results[[i]]) + (i - (length(results) + 1) / 2) * .15, results[[i]][, 1], bty = "l", col = tempcol)
    points(1:nrow(results[[i]]) + (i - (length(results) + 1) / 2) * .15, results[[i]][, 1], cex = 1.5, pch = 16, bty = "l", col = tempcol, lwd = 2)
  }
}

.intervals.diffogram <- function(dm, emp, main = NULL, ylab = "", xlab = "", ylim = NULL, pch = 17, col = "black") {
  if (is.null(main)) main <- comment(emp)
  fm <- t(combn(dm[, 2], 2))
  dif <- (emp[, "UL"] - emp[, "LL"]) / 4
  lox <- fm[, 1] - dif
  hix <- fm[, 1] + dif
  loy <- fm[, 2] + dif
  hiy <- fm[, 2] - dif
  main <- paste(strwrap(main, width = 0.7 * getOption("width")), collapse = "\n")
  if (is.null(ylim)) {
    mn <- min(lox, loy, hix, hiy) - 2
    mx <- max(hix, hiy, lox, loy) + 2
    ylim <- c(mn, mx)
  }
  par(mar = c(5, 5, 6, 5))
  plot(NULL, bty = "l", cex.lab = 1.15, xlim = ylim, ylim = ylim, xlab = xlab, ylab = ylab)
  title(main, line = 4)
  arrows(mn, mn, mx, mx, length = 0, lty = 2, col = col)
  abline(v = dm[, 2], col = "gray90")
  mtext(rownames(dm), side = 3, at = dm[, 2], las = 2, line = -2)
  abline(h = dm[, 2], col = "gray90")
  mtext(rownames(dm), side = 4, at = dm[, 2], las = 1, line = -2)
  arrows(lox, loy, hix, hiy, length = 0, lwd = 2, col = col)
  points(fm[, 1], fm[, 2], pch = pch, col = col, lwd = 2, bg = .colorIntensity(col, .6))
}

plotIntervals <- function(x, ...) {
  UseMethod("plotIntervals")
}

plotIntervals.intervals.main <- function(x, ...) {
  plot.intervals.main(x, ...)
}

plotIntervals.intervals.comp <- function(x, ...) {
  plot.intervals.comp(x, ...)
}

addIntervals <- function(...) {
  plotIntervals(..., add = TRUE)
}
