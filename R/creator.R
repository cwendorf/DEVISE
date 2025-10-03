# DEVISE
## Creating Variables and Matrices

#' Create Groups
#'
#' Generate a factor with `k` groups and a specified number of observations.
#' Groups can be balanced (equal size) if `n` is a single integer, or weighted
#' (unequal size) if `n` is a vector of group sizes.
#'
#' @param k Integer. Number of groups.
#' @param n Integer. Either:
#'   - A single value: total number of observations (must be divisible by `k`), or
#'   - A vector of length `k`: group sizes (must sum to total `n`).
#' @param labels Character vector of group labels. Defaults to `1:k`.
#'
#' @return A factor of length `sum(n)` with `k` groups in sequence.
#'
#' @examples
#' # Example 1: Balanced groups (n = 12, k = 3 → 4 per group)
#' create_groups(k = 3, n = 12, labels = c("GroupA", "GroupB", "GroupC"))
#'
#' # Example 2: Weighted groups (sizes 2, 5, 5)
#' create_groups(k = 3, n = c(2, 5, 5), labels = c("GroupA", "GroupB", "GroupC"))
#'
#' # Example 3: Default labels when none supplied
#' create_groups(k = 3, n = c(4, 6, 2))
#'
#' @export
create_groups <- function(k, n, labels = seq_len(k)) {
  # Weighted case: n is a vector
  if (length(n) > 1L) {
    if (length(n) != k) stop("Length of `n` must equal `k` when using group sizes.")
    return(factor(rep(labels, times = n), levels = labels))
  }
  
  # Balanced case: n is scalar
  if (n %% k != 0L) {
    stop("`n` must be divisible by `k` for balanced groups.")
  }
  reps <- n / k
  factor(rep(labels, each = reps), levels = labels)
}
