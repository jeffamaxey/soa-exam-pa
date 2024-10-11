# Introduction {-}

## Getting Started {#getting-started .unnumbered}

Before we continue, make sure you have all the software you need for this book:

-   **R**: If you don't have R installed already, you may be reading the wrong book; I assume a basic familiarity with R throughout this book.
    If you'd like to learn how to use R, I'd recommend my [*R for Data Science*](https://r4ds.had.co.nz/) which is designed to get you up and running with R with a minimum of fuss.

-   **RStudio**: RStudio is a free and open source integrated development environment (IDE) for R.
    While you can write and use Shiny apps with any R environment (including R GUI and [ESS](http://ess.r-project.org)), RStudio has some nice features specifically for authoring, debugging, and deploying Shiny apps.
    We recommend giving it a try, but it's not required to be successful with Shiny or with this book.
    You can download RStudio Desktop from <https://www.rstudio.com/products/rstudio/download>

## System Requirements {#system-requirements .unnumbered}

This book was written in [RStudio](http://www.rstudio.com/ide/) using [bookdown](http://bookdown.org/).

The [website](http://jeffamaxey.github.io/soa-exam-pa) is hosted with [Github Pages](https://github.com/), and automatically updated after every commit by [Github Actions](https://github.com/features/actions).
The complete source is available from [GitHub](https://github.com/jeffamaxey/soa-exa-pa).

This version of the book was built with R version 4.3.3 (2024-02-29 ucrt) and the following packages:

<table class="table table-striped table-hover table-condensed table-responsive" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-1)R Packages</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> package </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> version </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> source </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> bookdown </td>
   <td style="text-align:left;"> 0.40 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> dplyr </td>
   <td style="text-align:left;"> 1.1.4 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> forcats </td>
   <td style="text-align:left;"> 1.0.0 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ggplot2 </td>
   <td style="text-align:left;"> 3.5.1 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> gridExtra </td>
   <td style="text-align:left;"> 2.3 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> kableExtra </td>
   <td style="text-align:left;"> 1.4.0 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> knitr </td>
   <td style="text-align:left;"> 1.48 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> lubridate </td>
   <td style="text-align:left;"> 1.9.3 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> purrr </td>
   <td style="text-align:left;"> 1.0.2 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> readr </td>
   <td style="text-align:left;"> 2.1.5 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> shiny </td>
   <td style="text-align:left;"> 1.9.1 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> stringr </td>
   <td style="text-align:left;"> 1.5.1 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tibble </td>
   <td style="text-align:left;"> 3.2.1 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tidyr </td>
   <td style="text-align:left;"> 1.3.1 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tidyverse </td>
   <td style="text-align:left;"> 2.0.0 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tinytex </td>
   <td style="text-align:left;"> 0.53 </td>
   <td style="text-align:left;"> CRAN (R 4.3.3) </td>
  </tr>
</tbody>
</table>



