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

# Use retained model for further analysis
model_fit |> anova()
model_fit |> coef()

# Save transformed data for comparison
df |>
  transform(Total = Quiz + Exam) |>
  retain(df_with_total) |>
  compute_descriptives(Total)
df_with_total

# Compare original and transformed data
df |> compute_descriptives(Quiz, Exam)
df_with_total |> compute_descriptives(Quiz, Exam, Total)

# Save multiple intermediate steps
df |>
  subset(Group == "Group1") |>
  retain(step1_filtered) |>
  compute_descriptives() |>
  retain(step2_descriptives) |>
  extract_vector("M")
step1_filtered  # Filtered data
step2_descriptives  # Descriptive statistics

# Retain for later use in separate analyses
df |>
  subset(Quiz > 6) |>
  retain(high_performers) |>
  nrow()
high_performers |> compute_descriptives()
high_performers |> use_vars(Quiz, Exam) |> cor()
