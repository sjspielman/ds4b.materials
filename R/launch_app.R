#' Message for what apps they can choose
#' @export
app_choice_message <- function() {
  
  cat('You need to specify what app you would like to run. Options are:
    - "data_figures"
    - "types_of_figures"
    - "intro_R"
    - "ggplot2"
    - "line_by_line"
    - "dplyr"
    
If you think are getting this message in error, you might have a typo or used the wrong case!'
  )  
}



#' Run learnr module or shiny app based on given argument
#' 
#' @param choice What to to run
#' @returns invisible choice or FALSE if failed
#' @export
launch_app <- function(choice = NULL)
{
  allowed <- c("data_figures",
               "types_of_figures",
               "intro_R",
               "ggplot2",
               "line_by_line",
               "dplyr")
  if (is.null(choice))
  {
    app_choice_message()
    return (invisible(FALSE))
  } else {
    if(!(choice %in% allowed))
    {
      app_choice_message()
      return (invisible(FALSE))
    }
    message(crayon::green(
      crayon::bold("The module is lauching! Give it a minute...")))
    
    # A real shiny app
    if (choice == "types_of_figures") {
      shiny::runApp(
        file.path(app_path, "types_of_plots")
      )
    } else if (choice == "line_by_line") {
      shiny::runApp(
        file.path(app_path, "line_by_line")
      )
    } else {
      # Learnr
      learnr_file <- file.path(
        learnr_path, 
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


