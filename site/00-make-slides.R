if (!file.exists("_quarto.yml")) {
  stop("Please run this script from the quarto site base directory")
}

render_all_slides <- function(dir = "_slides") {
  owd <- setwd(dir)
  on.exit(setwd(owd))

  # Add Rmd files that should not be auto-rendered to this variable
  # ex. c("not-a-slide-deck.Rmd")
  EXCLUDE_RMDS <- c()
  
  # Clean up the libs/ directory so we get a clean render
  unlink("libs", recursive = TRUE)
  
  # Find Rmds that need to be rendered
  rmds <- dir(pattern = '[.][Rr]md')
  rmds <- setdiff(rmds, EXCLUDE_RMDS)
  
  # Render each slide deck
  for (rmd in rmds) {
    message("Rendering ", rmd)
    rmarkdown::render(rmd, quiet = TRUE)
  }
  
  invisible(rmds)
}

render_all_slides()
