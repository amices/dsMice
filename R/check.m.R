#'
#' @title Partial Computation for Model Fitted Values
#' @description Calculates the fitted values in each data node.
#' @details Considering \code{y} as a response variable and x as study variable, the fitted values are the y-values that
#' would expect for the given x-values according to the best-fitting straight line.
#'
#' @param m is a list of the regression coefficients.
#
#' @return a vector of fitted values.
#'
#' @section Dependencies:
#' \code{\link{getVarbyFormula}}
#'

check.m <- function(m) {
  m <- m[1L]
  if (!is.numeric(m))
    stop("Argument m not numeric", call. = FALSE)
  m <- floor(m)
  if (m < 1L)
    stop("Number of imputations (m) lower than 1.", call. = FALSE)
  return(m)
}