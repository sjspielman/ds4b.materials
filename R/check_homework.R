#' Let them know if they have bugs - NOTHING FANCY!!
#' Don't export though since not used Fall 2021
#' 
#' @param number The number homework we're on
#' @returns invisible number
#' @noRd
check_homework <- function(number = NULL)
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
  homework_filename <- file.path(here::here(), "homeworks", 
                                 glue::glue("hw{number}_template.Rmd"))
  if (number %in% script_hws)  homework_filename <- gsub(".Rmd$", ".R", homework_filename) 
  
  # In a totally clean environment, run! 
  clean_env <-  #NO PARENT
  tryCatch(
    expr = 
    {
      if (number %in% script_hws)
      {
        # Can't figure out how to dev/null this
        source(homework_filename, clean_env) 
      } else {
        rmarkdown::render(homework_filename, envir = new.env() , quiet=TRUE) 
      }
    },
    error = function(e)
    {
      stop(
        stringr::str_wrap("\n\n\n\nERRORS DETECTED! Make sure to test your code in a clean environment.", width = 60)
      )
    }
  )
  message(
    stringr::str_wrap( "\n\nHURRAY, NO ERRORS DETECTED!! There could still be bugs, but there are no bugs that prevent the code from running.", width = 60)
  )
}
  