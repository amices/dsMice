#' is.na() for DataSHIELD server
#'
#' This function is a wrapper for \code{base::is.na()}.
#' @details If the length of input vector is less than the set filter
#' a missing value is returned.
#' @inheritParams base::is.na
#' @return A logical object conforming to \code{x}
#' @author Adapted from \url{https://github.com/gflcampos/dsMice/blob/master/R/notNaDS.R}
#' @seealso \code{\link[base]{is.na}}
#' @export
#' @examples
#' library(mice)
#' pat <- is.naDS(nhanes)
is.naDS <- function(x) {

  # check if the input vector is valid (i.e. meets DataSHIELD privacy criteria)
  check <- dsBase::isValidDS(x)

  # return missing value if the input vector is not valid
  if (check) {
    result <- is.na(x)
  } else {
    result <- NA
  }

  return(result)
}
