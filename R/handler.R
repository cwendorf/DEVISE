# DEVISE
## Method Handler

### Argument Handling

arg_map <- list(
  "confintr::ci_mean_t" = c(x = "x", conf_level = "conf_level"),
  "statpsych::CImean"  = c(mean = "mean", sd = "sd", n = "n", conf_level = "level")
)

translate_args <- function(args, method_name, arg_map) {
  if (!method_name %in% names(arg_map)) {
    stop("No argument map defined for method: ", method_name)
  }

  map <- arg_map[[method_name]]
  translated_args <- list()

  for (standard_name in names(map)) {
    target_name <- map[[standard_name]]
    if (!is.null(args[[standard_name]])) {
      translated_args[[target_name]] <- args[[standard_name]]
    }
  }

  return(translated_args)
}

match_args_to_method <- function(args, method_name) {
  if (grepl("::", method_name)) {
    parts <- strsplit(method_name, "::")[[1]]
    pkg <- parts[1]
    fun <- parts[2]
    fn <- getExportedValue(pkg, fun)
  } else {
    fn <- match.fun(method_name)
  }

  formal_args <- names(formals(fn))
  matched_args <- args[names(args) %in% formal_args]
  return(matched_args)
}

### Main CI Function

ci <- function(
  x = NULL,
  y = NULL,
  mean = NULL,
  sd = NULL,
  n = NULL,
  proportion = NULL,
  conf_level = 0.95,
  method = c("confintr::ci_mean_t", "statpsych::CImean")
) {
  method <- match.arg(method)

  # Step 1: collect all standardized inputs
  args <- list(
    x = x, y = y,
    mean = mean, sd = sd, n = n,
    proportion = proportion,
    conf_level = conf_level
  )

  # Step 2: translate standardized args to method-specific names
  translated_args <- translate_args(args, method, arg_map)

  # Step 3: filter only valid args
  safe_args <- match_args_to_method(translated_args, method)

  # Step 4: evaluate the method dynamically
  if (grepl("::", method)) {
    parts <- strsplit(method, "::")[[1]]
    fn <- getExportedValue(parts[1], parts[2])
  } else {
    fn <- match.fun(method)
  }

  result <- do.call(fn, safe_args)
  return(result)
}
