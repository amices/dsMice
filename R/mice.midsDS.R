#' mice.mids algorithm for DataSHIELD server
#'
#' This function is a wrapper for \code{mice::mice.mids()}.
#' @param obj An object of class \code{mids}, typically produces by a previous
#'call to \code{mice()} or \code{mice.mids()}
#' @param \dots Arguments passed down to \code{mice::mice.mids()}
#' @return An object of class \code{mids}
#' @seealso \code{\link[mice]{mice.mids}}, \code{\link[mice]{mice}},
#' \code{\link[=mids-class]{mids}}
#' @examples
#' library(mice)
#' imp <- miceDS(nhanes, maxit = 0)
#' imp$iteration
#'
#' # Do one pass through the data
#' imp <- mice.midsDS(imp, print = FALSE)
#' imp$iteration
#' @export
mice.midsDS <- function(obj, ...) {

  # check if the input is valid (i.e. meets DataSHIELD privacy criteria)
  check <- isValidDS(obj$data)

  # return missing value if the input vector is not valid
  if (check) {
    result <- mice.mids(obj, ...)
  } else {
    result <- NA
  }

  return(result)
}
