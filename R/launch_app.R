#' Message for what apps they can choose
#' @export
app_choice_message <- function() {
  
  cat('You need to specify what app you would like to run. Options are:
    - "data_figures"
    - "types_of_plots"
    - "line_by_line"
    - "intro_R"
    - "ggplot2"
    - "dplyr"
    
If you think are getting this message in error, you might have a typo or used the wrong case!\n\n'
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
               "types_of_plots",
               "line_by_line",
               "intro_R",
               "ggplot2",
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
    if (choice == "types_of_plots") {
      # this only works if printed, and I'm not going to question it *shrug*
      print( types.of.plots::run_app() )
    } else if (choice == "line_by_line") {
      shiny::runApp(
        file.path(app_path, "line_by_line")
      )
    } else {
      # Learnr
      learnr::run_tutorial(choice, package = "ds4b.materials")
    }
    return(invisible(choice))
  }
}


