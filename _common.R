library(methods)
library(knitr)

knitr::opts_chunk$set(
  background = "#FCFCFC", # code chunk color in latex
  comment = "#>",
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  include=TRUE,
  echo = TRUE,
  # The following line speeds-up the build.
  # Uncomment it to avoid cached data (which can cause issues):
  cache = TRUE,
  fig.pos = "t",
  fig.path = "figures/",
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618,  # 1 / phi
  fig.show = "hold",
  out.width = "100%",
  dpi = 105 # this creates 2*105 dpi at 6in, which is 300 dpi at 4.2in, see the  EmilHvitfeldt/smltar repo
)

set.seed(2017)

options(
  htmltools.dir.version = FALSE,
  formatR.indent = 2,
  width = 55,
  digits = 4,
  warnPartialMatchAttr = FALSE,
  warnPartialMatchDollar = FALSE,
  dplyr.print_min = 4,
  dplyr.print_max = 4
)

local({
  r = getOption('repos')
  if (!length(r) || identical(unname(r['CRAN']), '@CRAN@'))
    r['CRAN'] = 'https://cran.rstudio.com'
  options(repos = r)
})

lapply(c('DT', 'formatR', 'svglite', 'rticles', 'tinytex', 'bookdown', 'rmarkdown'), function(pkg) {
  if (system.file(package = pkg) == '')
    install.packages(pkg)
})

lapply(c('ggplot2', 'tidyverse', 'gridExtra'), function(pkg) {
  if (system.file(package = pkg) == '')
    install.packages(pkg)
})

library(bookdown)
library(tinytex)
is_on_ghactions = identical(Sys.getenv("GITHUB_ACTIONS"), "true")
is_online = curl::has_internet()
is_html = knitr::is_html_output()
