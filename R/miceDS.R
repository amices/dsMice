#' mice algorithm for DataSHIELD server
#'
#' This function is a wrapper for \code{mice::mice()}.
#' @param data A data frame or a matrix containing the incomplete data.
#' Missing values are coded as \code{NA}.
#' @param \dots Arguments passed down to \code{mice::mice()}
#' @return An object of class \code{mids}
#' @seealso \code{\link[mice]{mice}}, \code{\link[=mids-class]{mids}}
#' @export
#' @examples
#' library(mice)
#' imp <- miceDS(nhanes, maxit = 0)
miceDS <- function(data, ...) {

  # check if the input is valid (i.e. meets DataSHIELD privacy criteria)
  check <- isValidDS(data)

  # return missing value if the input vector is not valid
  if (check) {
    result <- mice(data, ...)
  } else {
    result <- NA
  }

  return(result)
}
