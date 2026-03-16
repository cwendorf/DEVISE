# [`DEVISE`](https://github.com/cwendorf/DEVISE/)

## Retain an Object in a Pipeline

**Aliases:**

- `retain`

### Description

retain() assigns an object in the caller's environment
while returning the value invisibly. This makes it easy to save
intermediate results when using the native pipe (|>).

### Usage

```r
retain(x, name)
```

### Arguments

- **`x`**: The object to retain (typically coming from a pipeline).
- **`name`**: A symbol giving the name to assign x to in the
caller's environment.

### Value

Invisibly returns x, unchanged.

### Examples

```r
# Save a filtered dataset in a pipeline
iris |>
  subset(Species == "setosa") |>
  retain(setosa_only) |>
  summary()

# Save a model fit while still viewing its summary
iris |>
  lm(Sepal.Length ~ Sepal.Width, data = _) |>
  retain(model_fit) |>
  summary()

# Save an intermediate step for debugging
mtcars |>
  subset(cyl == 6) |>
  retain(six_cyls) |>
  transform(kpl = mpg * 0.425) |>
  head()
```

