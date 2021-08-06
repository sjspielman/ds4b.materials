choice_message <- function() {
  
  cat('You need to specify what you would like to run. Options are:
    - "data_figures"
    - "types_of_figures"
    - "intro_R"
    - "ggplot2"
    - "dplyr"
    
If you think are getting this message in error, you might have a typo or used the wrong case!'
  )  
}


#' Run learnr module or shiny app based on given argument
#' 
#' @param choice What to to run
#' @returns invisible choice or FALSE if failed
launch_exercises <- function(choice = NULL)
{
  allowed <- c("data_figures",
               "types_of_figures",
               "intro_R",
               "ggplot2",
               "dplyr")
  if (is.null(choice))
  {
    choice_message()
    return (invisible(FALSE))
  } else {
    if(!(choice %in% allowed))
    {
      choice_message()
      return (invisible(FALSE))
    }
    message(crayon::green(
      crayon::bold("The module is lauching! Give it a minute...")))

    # A real shiny app
    if (choice == "types_of_figures")
    {
      shiny::runApp(
        file.path(app_path, "types_of_plots")
      )
    } else {
      # Learnr
      learnr_file <- file.path(
        app_path, 
        dplyr::case_when(
          choice == "data_figures"  ~ "module_intro_data-figures.Rmd",
          choice == "intro_R"       ~ "module_intro_R.Rmd",
          choice == "ggplot2"       ~ "module_intro_ggplot.Rmd",
          choice == "dplyr"         ~ "module_intro_dplyr.Rmd"
        )
      )

    rmarkdown::shiny_prerendered_clean(learnr_file)
    rmarkdown::run(learnr_file, 
                   render_args = list(quiet=TRUE))
    }
    return(invisible(choice))
  }
}
   
  
  