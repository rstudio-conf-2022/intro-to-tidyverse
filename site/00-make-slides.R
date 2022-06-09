if (!file.exists("_quarto.yml")) {
  stop("Please run this script from the quarto site base directory")
}

copy_slides_to_site <- function(from = "../slides", to = "_slides") {
  message("Moving ", from, " into ", to)
  if (fs::dir_exists(to)) fs::dir_delete(to)
  fs::dir_copy(from, to)
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
    callr::r_safe(
      function(rmd) rmarkdown::render(rmd, quiet = TRUE),
      args = list(rmd = rmd)
    )
  }
  
  invisible(rmds)
}

copy_slides_to_site()
render_all_slides()
