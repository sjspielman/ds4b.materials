#' Message for what activities they can choose
#' @export
activity_choice_message <- function() {
  
  cat('You need to specify what activity you would like to run. Options are:
    - "rmarkdown"

If you think are getting this message in error, you might have a typo or used the wrong case!'
  )  
}



#' Run activity based on given argument
#' 
#' @param choice What to to run
#' @returns invisible choice or FALSE if failed
#' @export
launch_activity <- function(choice = NULL)
{
  allowed <- c("rmarkdown", "linear_modeling", "logistic_regression")
  if (is.null(choice))
  {
    activity_choice_message()
    return (invisible(FALSE))
  } else {
    if(!(choice %in% allowed))
    {
      activity_choice_message()
      return (invisible(FALSE))
    }
    message(crayon::green(
      crayon::bold("The activity is lauching!")))
    
    # Define
    activity_name <- dplyr::case_when(
      choice == "rmarkdown" ~ "demonstration_rmarkdown.Rmd",
      choice == "linear_modeling" ~ "linear_modeling.Rmd",
      choice == "logistic_regression" ~ "logistic_regression.Rmd",
      TRUE ~ ""
    )
    if(activity_name == "") stop()
    
    activity_path <- file.path(here::here(), "activities")
    final_activity_path <- file.path(activity_path, activity_name)
    
    activity_raw_url <- glue::glue(
      "https://raw.githubusercontent.com/sjspielman/datascience_for_biologists/master/docs/inclass/{activity_name}"
    )
    
    # If HW path and HW exist, just open the HW
    if (dir.exists(final_activity_path)) {
      message(
        glue::glue(
          stringr::str_wrap(
            "\nIt looks like you have already launched this activity. I'll just open it for you.", width = 60)
        )
      )
      open_thing(final_activity_path)
    } else {
      download_thing(activity_path, activity_name, activity_raw_url)
      open_thing(final_activity_path)
    }
    return (invisible(choice))
  }
}
