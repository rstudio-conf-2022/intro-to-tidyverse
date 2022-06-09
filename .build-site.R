#!/usr/bin/env Rscript

message("---- Building workshop website and slides ----")
message("Entering 'site/'")
setwd("site")
source("00-make-slides.R")
message("\nRendering quarto website...")
quarto::quarto_render()

message("Rendering quarto website...done!")
if (!nzchar(Sys.getenv("CI"))) {
  message('Use `quarto::quarto_preview("site")` to preview the site')
}