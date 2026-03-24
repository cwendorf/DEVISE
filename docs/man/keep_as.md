# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Keep an Object in a Pipeline

### Description

Assigns an object in the caller's environment
while returning the value invisibly. This makes it easy to save
intermediate results when using the native pipe (|>).

### Usage

```r
keep_as(x, name)
```

### Arguments

- **`x`**: The object to keep (typically coming from a pipeline).
- **`name`**: A symbol giving the name to assign x to in the
caller's environment.

### Value

Invisibly returns x, unchanged.

### Examples

```r
# Save a filtered dataset in a pipeline
iris |>
  subset(Species == "setosa") |>
  keep_as(setosa_only) |>
  summary()

# Save a model fit while still viewing its summary
iris |>
  lm(Sepal.Length ~ Sepal.Width, data = _) |>
  keep_as(model_fit) |>
  summary()

# Save an intermediate step for debugging
mtcars |>
  subset(cyl == 6) |>
  keep_as(six_cyls) |>
  transform(kpl = mpg * 0.425) |>
  head()
```

