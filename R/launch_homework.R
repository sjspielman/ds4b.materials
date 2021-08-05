#' Create and populate a homework directory
#' 
#' @param number The number homework we're on
#' @returns invisible number
launch_homework <- function(number = NULL)
{
  allowed <- c(0,2:11)
  script_hws <- c(2)
  
  # Ugh....
  if (is.null(number)) 
  {
    bad_homework_message()
    return(FALSE)
  } else {
    number <- as.numeric(number)
    if (!(number %in% allowed))
    {
      bad_homework_message()
      return(FALSE)
    } 
  }
  
  # Define
  homework_name <- glue::glue("hw{number}") 
  homework_path <- file.path(here::here(), "homeworks", homework_name)
  
  homework_filename <- glue::glue("{homework_name}_template.Rmd")
  if (number %in% script_hws)  homework_filename <- gsub(".Rmd$", ".R", homework_filename) 
  ### TODO: THIS MAY ALSO NEED TO BE 
  homework_raw_url <- glue::glue(
    "https://raw.githubusercontent.com/sjspielman/datascience_for_biologists/master/docs/homeworks/{homework_name}/raw_{homework_name}.zip"
  )

  # If HW path and HW exist, just open the HW
  if (dir.exists(homework_path)) {
    if (file.exists(file.path(homework_path, homework_filename))) {
      message(
        glue::glue(
          stringr::str_wrap(
          "\nIt looks like you have already launched Homework {number}. I'll just open it for you.", width = 60)
        )
      )
      open_homework(homework_path, homework_filename)
    } else {
      download_homework(homework_path, homework_raw_url)
      open_homework(homework_path, homework_filename)
      message("Enjoy!")
    }
  } else {
    dir.create(homework_path)
    download_homework(homework_path, homework_raw_url)
    open_homework(homework_path, homework_filename)
    message("Enjoy!")
  }
  return (invisible(number))
}




download_homework <- function(hwpath, hwurl)
{
  setwd(hwpath)
  utils::download.file(hwurl, destfile = "tempzip", quiet=T)
  utils::unzip("tempzip")
  file.remove("tempzip")
}

open_homework <- function(hwpath, hwfile)
{
  setwd(hwpath)
  rstudioapi::navigateToFile(hwfile)
}

bad_homework_message <- function()
{
  cat("\nYou need to provide an appropriate argument for which homework to launch or check. Arguments can be any number 2-11. For example...
          
To launch homework #4, you would run:   " %+%
  crayon::bold("launch_homework(4)")
%+% "\nTo check homework #4, you would run:    " %+%
  crayon::bold('check_homework(4)') 
  )
}