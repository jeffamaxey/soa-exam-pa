auto_install_packages <- function(packages) {
  # Install packages not yet installed
  installed_packages <- packages %in% rownames(installed.packages())
  if (any(installed_packages == FALSE)) {
    install.packages(packages[!installed_packages])
  }

  # Load packages
  invisible(lapply(packages, library, character.only = TRUE))


}

packages <- c(
  "bookdown",
  "bslib",
  "caret",
  "cli",
  "curl",
  "data.table",
  "desc",
  "downlit",
  "dplyr",
  "DT",
  "formatR",
  "fs",
  "gapminder",
  "ggforce",
  "ggplot2",
  "gh",
  "glmnet",
  "globals",
  "glue",
  "gridExtra",
  "hexSticker",
  "ISLR",
  "janitor",
  "jsonlite",
  "kableExtra",
  "knitr",
  "lares",
  "magick",
  "MASS",
  "methods",
  "openintro",
  "png",
  "pROC",
  "profvis",
  "purrr",
  "remotes",
  "renv",
  "rlang",
  "rmarkdown",
  "rpart",
  "rpart.plot",
  "rsconnect",
  "RSQLite",
  "sessioninfo",
  "shiny",
  "shinycssloaders",
  "shinyFeedback",
  "shinyloadtest",
  "shinytest",
  "shinythemes",
  "sysfonts",
  "testthat",
  "thematic",
  "tibble",
  "tidyverse",
  "tinytex",
  "vctrs",
  "vroom",
  "waiter",
  "waldo",
  "webshot",
  "xfun",
  "xml2",
  "yaml",
  "zeallot"
)

auto_install_packages(packages)
