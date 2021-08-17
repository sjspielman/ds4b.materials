#' Crayon operator
#'
#'
#' @name %+%
#' @rdname crayon-pipe
#' @keywords internal
#' @export
#' @importFrom crayon %+%
#' @usage lhs \%+\% rhs
#' @param lhs crayonable string
#' @param rhs crayonable string
#' @return The strings....
NULL


#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
#' @param lhs A value or the magrittr placeholder.
#' @param rhs A function call using the magrittr semantics.
#' @return The result of calling `rhs(lhs)`.
NULL


#' Path to apps
app_path <- system.file("apps", package = "ds4b.materials")

#' Path to learnr
learnr_path <- system.file("learnr", package = "ds4b.materials")

#' Path to activities
activity_path <- system.file("inclass", package = "ds4b.materials")


#' Update materials
#' 
#' Forces updates to introverse and ds4b.materials packages
update_materials <- function(){
  cat(
    crayon::bold(
      crayon::blue(
      "You have requested to update BIOL01301 materials. 
This means your current environment will be DELETED.\n\n") %+%
  "Enter 1 to CONTINUE with the update.\n" %+%
  stringr::str_wrap("Enter 2 to CANCEL the update so you can save whatever you need to save first.\n", width = 60)
    )
  )
  entered_value <- readline()
  if (entered_value == 2) {
    cat(
      crayon::bold(
        crayon::red("\n\nCanceling materials update.")
      ))
    return (invisible(FALSE))
  } else if (entered_value == 1)  {
    cat(
      crayon::bold(
        crayon::green(
          stringr::str_wrap("\n\nMaterials will now be updated...\nWhen the R session restarts, you will need to RELOAD any libraries you want to use.", width = 65))))
  } else {
    cat(
      crayon::bold(
        crayon::red("\n\nYou need to enter either 1 or 2.")))
    return (invisible(FALSE))
  }

  remotes::install_github("sjspielman/ds4b.materials", force = TRUE, quiet = TRUE)
  remotes::install_github("spielmanlab/introverse", force = TRUE, quiet = TRUE)
  cat("\n\n" %+%
    crayon::bold(
      crayon::green(stringr::str_wrap("Your R session will now restart for these updates to take effect. You will need to RELOAD ALL LIBRARIES you were using after R restarts!", width = 60))))
  rstudioapi::restartSession()
  return (invisible(TRUE))
}
