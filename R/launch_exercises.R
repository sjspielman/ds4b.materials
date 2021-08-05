#' Run learnr module or shiny app based on given argument
#' 
#' @param choice What to to run
#' @returns invisible choice or FALSE if failed
launch_exercises <- function(choice = NULL)
{
  allowed <- c("data_figures",
               "types_of_figures",
               "intro_R",
               "ggplot2_part1",
               "dplyr_part1")
  if (is.null(choice) | !(choice %in% allowed))
  {
    cat("\n You need to specify what you'd like to run. Options include:\n\n
    - 'data_figures'
    - 'types_of_figures'
    - 'intro_R'
    - 'ggplot2_part1'
    - 'dplyr_part1'
    
    If you think are getting this message in error, you might have a typo or used the wrong case!")
    return (FALSE)
  } else {
    message("The module is lauching!")

    # A real shiny app
    if (choice == "types_of_figures")
    {
      shiny::runApp(
        file.path(app_path, "types_of_plots")
      )
      return (choice)
    } 
    # Learnr
    learnr_file <- file.path(
      app_path, 
      dplyr::case_when(
        choice == "data_figures"  ~ "module_intro_data-figures.Rmd",
        choice == "intro_R"       ~ "module_intro_R.Rmd",
        choice == "ggplot2_part1" ~ "module_intro_ggplot.Rmd",
        choice == "dplyr_part1"   ~ "module_intro_dplyr.Rmd"
      )
    )
    rmarkdown::run(learnr_file, 
                   render_args = list(quiet=TRUE))
    return(choice)
  }
}
   
  
  