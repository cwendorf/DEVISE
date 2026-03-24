# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Create Groups

### Description

Generate a factor with k groups and a specified number of observations.
Groups can be balanced (equal size) if n is a single integer, or weighted
(unequal size) if n is a vector of group sizes.

### Usage

```r
create_groups(k, n, labels = seq_len(k))
```

### Arguments

- **`k`**: Integer. Number of groups.
- **`n`**: Integer. Either:

 A single value: total number of observations (must be divisible by k), or
 A vector of length k: group sizes (must sum to total n).
- **`labels`**: Character vector of group labels. Defaults to 1:k.

### Value

A factor of length sum(n) with k groups in sequence.

### Examples

```r
# Example 1: Balanced groups (n = 12, k = 3 → 4 per group)
create_groups(k = 3, n = 12, labels = c("GroupA", "GroupB", "GroupC"))

# Example 2: Weighted groups (sizes 2, 5, 5)
create_groups(k = 3, n = c(2, 5, 5), labels = c("GroupA", "GroupB", "GroupC"))

# Example 3: Default labels when none supplied
create_groups(k = 3, n = c(4, 6, 2))
```

