#!/usr/bin/env Rscript

message("Building site/")
setwd("site")
source("00-make-slides.R")
message("Rendering quarto website...")
quarto::quarto_render()

message("All done.")
message('Use `quarto::quarto_preview("site")` to preview the site')