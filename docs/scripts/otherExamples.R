# DEVISE
## Other Examples

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")

### Create Factor Groups and Data

df <- data.frame(
  Group = create_groups(k = 2, c(5, 5), labels = c("Group1", "Group2")),
  Quiz = c(5, 6, 7, 5, 6, 8, 9, 7, 8, 9),
  Exam = c(8, 7, 9, 6, 7, 10, 9, 9, 8, 10)
)

### Compute Summary Statistics

# 1) Multiple variables, no grouping
df |> compute_descriptives()
df |> compute_descriptives(Quiz, Exam) |> style_matrix(title = "Table 1: Descriptive Statistics", style = "apa")

# 2) Grouped, one variable
df |> compute_descriptives(Quiz ~ Group)
df |> compute_descriptives(Quiz ~ Group) |> style_matrix(title = "Table 1: Descriptive Statistics by Group", style = "apa")

# 3) Grouped, multiple variables
df |> compute_descriptives(c(Quiz, Exam) ~ Group)

# Multiple variables
df |> compute_correlations()
df |> compute_correlations(Quiz, Exam) |> style_matrix(title = "Table 2: Correlation Matrix", style = "apa")

# Grouped, multiple variables
df |> compute_correlations(c(Quiz, Exam) ~ Group)

# Covariance matrix
df |> compute_correlations(Quiz, Exam, type = "cov") |> style_matrix(title = "Table 3: Covariance Matrix", style = "apa")



### Write to a File

sink("Results.txt") # Create file and start redirecting
iris |> compute_descriptives(Sepal.Length, Petal.Length) |> style_matrix(title = "Table 1: Descriptive Statistics", style = "apa")
iris |> compute_correlations(Sepal.Length, Petal.Length) |> style_matrix(title = "Table 2: Correlation Matrix", style = "apa")
sink()  # Stop redirecting


### Extract a Vector

df |> compute_descriptives(Quiz, Exam) |> extract_vector("N")
df |> compute_descriptives(Quiz, Exam) |> extract_vector("M")
df |> compute_descriptives(Quiz, Exam) |> extract_vector("SD")


### Evaluate a Formula or Variables in a Data Frame

# single variable
df |> use_vars(Quiz) |> t.test()

# multiple variables
df |> use_vars(Quiz, Exam) |> t.test()
df |> use_vars(Quiz, Exam) |> cor()

# vector works too
df |> use_vars(c(Quiz, Exam)) |> t.test()

# using formula
df |> use_vars(Quiz ~ Group) |> t.test()
df |> use_vars(Quiz ~ Group) |> lm() |> summary()
df |> use_vars(Quiz ~ Group) |> aov()

# more complex formula
df |> use_vars(Exam ~ Group + Quiz) |> lm() |> summary()
df |> use_vars(Exam ~ Group + Quiz) |> aov()


### Retain Intermediate Results

# Save a filtered dataset in a pipeline
df |>
  subset(Group == "Group1") |>
  retain(group1_only) |>
  summary()
group1_only

# Save a model fit while still viewing its summary
df |>
  lm(Quiz ~ Group, data = _) |>
  retain(model_fit) |>
  summary()
model_fit

# Save an intermediate step for debugging
df |>
  subset(Group == "Group1") |>
  retain(group1_only) |>
  summary()
group1_only
