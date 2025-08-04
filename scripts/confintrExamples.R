# DEVISE
## Examples with `confintr`

### Source the Functions

source("http://raw.githubusercontent.com/cwendorf/DEVISE/main/source-DEVISE.R")
source.github <- function(username, repo, branch) {
  url <- paste("https://github.com/", username, "/", repo, "/archive/refs/heads/", branch, ".zip", sep = "")
  name <- paste(repo, "-", branch, sep = "")
  file <- paste(name, ".zip", sep = "")
  download.file(url = url, destfile = file)
  unzip(zipfile = file)
  folder <- paste(name, "/R/", sep = "")
  paths <- list.files(path = folder, full.names = TRUE)
  for (i in 1:length(paths)) source(paths[i])
  unlink(file)
  unlink(name, recursive = TRUE)
}
source.github("mayer79", "confintr", "main")

### Input Data

Factor <- gl(2, 10, labels = c("Level1", "Level2"))
Outcome <- c(6, 8, 6, 8, 10, 8, 10, 9, 8, 7, 7, 13, 11, 10, 13, 8, 11, 14, 12, 11)
IndependentData <- data.frame(Factor, Outcome)

y1 <- IndependentData$Outcome[IndependentData$Factor == "Level1"]
y2 <- IndependentData$Outcome[IndependentData$Factor == "Level2"]

### Create Summary

ci_mean(y1) |> intervals() -> Level1
ci_mean(y2) |> intervals() -> Level2
ci_mean_diff(y2, y1) |> intervals() -> Comparison
Results <- rbind(Level1, Level2, Comparison)
rownames(Results) <- c("Level1", "Level2", "Comparison")

### Results

Results |> print_matrix(title = "Table 1: Comparison Confidence Intervals", style = "apa")
Results |> plot_comp(title = "Figure 1: Comparison Confidence Intervals", values = TRUE)
