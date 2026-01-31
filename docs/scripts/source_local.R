# Purpose: Source all R functions from a Local Repo
# Updated: 2025-06-26

source_local <- function(directory) {
  if (!dir.exists(directory)) {
    stop("Directory does not exist: ", directory)
  }
  r_files <- list.files(
    path = directory,
    pattern = "\\.R$",
    full.names = TRUE,
    recursive = TRUE
  )
  if (length(r_files) == 0) {
    warning("No R files found in directory: ", directory)
  }
  for (file in r_files) {
    message("Sourcing: ", file)
    source(file)
  }
}

# Dummy Example - Replace with your real path
source_local("C:/Users/cwendorf/OneDrive - UWSP/GitHub/DEVISE/R")
