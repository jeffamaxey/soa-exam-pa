# load shiny first to avoid any conflict messages later
library(shiny)
library(methods)
library(knitr)
library(bookdown)
library(tinytex)
library(kableExtra)
library(ggplot2)
library(gridExtra)

set.seed(1234)


# Do not run apps when knitting
shinyApp <- function(...) {
  if (isTRUE(getOption("knitr.in.progress"))) {
    invisible()
  } else {
    shiny::shinyApp(...)
  }
}

knitr::opts_chunk$set(
  background = "#FCFCFC",
  # code chunk color in latex
  comment = "#>",
  collapse = TRUE,
  message = FALSE,
  warning = FALSE,
  include = TRUE,
  echo = TRUE,
  # The following line speeds-up the build.
  # Uncomment it to avoid cached data (which can cause issues):
  cache = TRUE,
  fig.pos = "t",
  fig.path = "figures/",
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618,
  # 1 / phi
  fig.show = "hold",
  out.width = "100%",
  dpi = 105 # this creates 2*105 dpi at 6in, which is 300 dpi at 4.2in, see the  EmilHvitfeldt/smltar repo
)


options(
  knitr.table.format = function() {
    if (knitr::is_latex_output())
      'latex'
    else
      'pandoc'
  },
  htmltools.dir.version = FALSE,
  formatR.indent = 2,
  width = 55,
  digits = 4,
  warnPartialMatchAttr = FALSE,
  warnPartialMatchDollar = FALSE,
  dplyr.print_min = 4,
  dplyr.print_max = 4,
  crayon.enabled = FALSE,
  rlang_trace_top_env = rlang::current_env()
)


# In final book can go up to 81
# http://oreillymedia.github.io/production-resources/styleguide/#code
# See preamble.tex for tweak that makes this work in pdf output
#knitr::opts_chunk$set(width = 81)
#options(width = 81)

# Reactive console simulation  -------------------------------------------------
# From https://github.com/rstudio/shiny/issues/2518#issuecomment-507408379
reactive_console_funs <- list(
  reactiveVal = function(value = NULL, label = NULL) {
    if (missing(label)) {
      call <- sys.call()
      label <- shiny:::rvalSrcrefToLabel(attr(call, "srcref", exact = TRUE))
    }

    rv <- shiny::reactiveVal(value, label)
    function(x) {
      if (missing(x)) {
        rv()
      } else {
        on.exit(shiny:::flushReact(), add = TRUE, after = FALSE)
        rv(x)
      }
    }
  },
  reactiveValues = function(...) {
    rv <- shiny::reactiveValues(...)
    class(rv) <- c("rv_flush_on_write", class(rv))
    rv
  },
  `$<-.rv_flush_on_write` = function(x, name, value) {
    on.exit(shiny:::flushReact(), add = TRUE, after = FALSE)
    NextMethod()
  },
  observe = function(...) {
    on.exit(shiny:::flushReact(), add = TRUE, after = FALSE)
    shiny::observe(...)
  }
)

# override shiny::reactiveConsole() with shims that work in knitr
reactiveConsole <- function(enabled = TRUE) {
  options(shiny.suppressMissingContextError = enabled)
  if (enabled) {
    attach(reactive_console_funs,
           name = "reactive_console",
           warn.conflicts = FALSE)
    vctrs::s3_register("base::$<-", "rv_flush_on_write")
  } else {
    detach("reactive_console")
  }
}

# Code extraction ---------------------------------------------------------

section_get <- function(path, name) {
  lines <- vroom::vroom_lines(path)
  start <- which(grepl(paste0("^\\s*#<< ", name), lines))

  if (length(start) == 0) {
    stop("Couldn't find '#<<", name, "'", call. = FALSE)
  }
  if (length(start) > 1) {
    stop("Found multiple '#<< ", name, "'", call. = FALSE)
  }

  # need to build stack of #<< #>> so we can have nested components

  end <- which(grepl("\\s*#>>", lines))
  end <- end[end > start]

  if (length(end) == 0) {
    stop("Couldn't find '#>>", call. = FALSE)
  }
  end <- end[[1]]

  lines[(start + 1):(end - 1)]
}

section_strip <- function(path) {
  lines <- vroom::vroom_lines(path)
  sections <- grepl("^#(>>|<<)", lines)
  lines[!sections]
}

# Errors ------------------------------------------------------------------

# Make error messages closer to base R
sew.error <- function(x, options) {
  msg <- conditionMessage(x)

  call <- conditionCall(x)
  if (is.null(call)) {
    msg <- paste0("Error: ", msg)
  } else {
    msg <- paste0("Error in ", deparse(call)[[1]], ": ", msg)
  }

  msg <- error_wrap(msg)
  knitr:::msg_wrap(msg, "error", options)
}

error_wrap <- function(x, width = getOption("width")) {
  lines <- strsplit(x, "\n", fixed = TRUE)[[1]]
  paste(strwrap(lines, width = width), collapse = "\n")
}

is_on_ghactions = identical(Sys.getenv("GITHUB_ACTIONS"), "true")
is_online = curl::has_internet()
is_html = knitr::is_html_output()
is_latex = knitr::is_latex_output()
