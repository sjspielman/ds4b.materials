#' Download and/or open the homework assignment into homeworks/
#' 
#' @param number The number homework we're on
#' @returns invisible number
#' @export
#' @noRd
launch_homework <- function(number = NULL)
{
  allowed <- c(2:3, 5:11)
  script_hws <- c(2)
  
  # Ugh....
  if (is.null(number)) 
  {
    bad_homework_message()
    return(invisible(FALSE))
  } else {
    number <- as.numeric(number)
    if (!(number %in% allowed))
    {
      bad_homework_message()
      return(invisible(FALSE))
    } 
  }
  
  # Define
  homework_name <- glue::glue("hw{number}") 
  homework_path <- file.path(here::here(), "homeworks")
  
  homework_filename <- glue::glue("{homework_name}_template.Rmd")
  if (number %in% script_hws)  homework_filename <- gsub(".Rmd$", ".R", homework_filename) 

  homework_raw_url <- glue::glue(
    "https://raw.githubusercontent.com/sjspielman/datascience_for_biologists/master/docs/homeworks/{homework_name}/{homework_filename}"
  )

  # If HW exists, just open the HW
  if (file.exists(file.path(homework_path, homework_filename))) {
    message(
      glue::glue(
        stringr::str_wrap(
        "\nIt looks like you have already launched Homework {number}. I'll just open it for you.", width = 60)
      )
    )
    open_thing( file.path(homework_path, homework_filename) )
  } else {
    
    # Can it be downloaded?
    if (RCurl::url.exists(homework_raw_url) == FALSE) {
      message(
        stringr::str_wrap("\n\nSorry, this homework isn't yet ready for downloading. If you think this is incorrect and the homework should be available, reach out to Dr. Spielman for help!", 55))
      return(invisible(FALSE))
    }
    download_thing(homework_path, homework_filename, homework_raw_url)
    open_thing( file.path(homework_path, homework_filename) )
    message("Enjoy!")
  }
  return (invisible(number))
}



#' Download a HW
#' @export
download_thing <- function(path, file, url) {
  utils::download.file(url, quiet=TRUE, destfile = file.path(path, file) )
}


#' Open a HW
#' @export
open_thing <- function(file) {
  rstudioapi::navigateToFile(file)
}

#' Message a bad HW
#' @export
bad_homework_message <- function() {
  cat("\nYou need to provide an appropriate argument for which homework to launch. The argument can be any number 2-3 or 5-11. For example...
          
To launch homework #2, you would run:   " %+%
  crayon::bold("launch_homework(2)"))
}





