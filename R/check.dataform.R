#'
#' @title Partial Computation for Model Fitted Values
#' @description Calculates the fitted values in each data node.
#' @details Considering \code{y} as a response variable and x as study variable, the fitted values are the y-values that
#' would expect for the given x-values according to the best-fitting straight line.
#'
#' @param beta is a list of the regression coefficients.
#' @param formula a string character to be transformed as an object of class \code{formula}.
#' @param x is a study variable.
#'
#' @return a vector of fitted values.
#'
#' @section Dependencies:
#' \code{\link{getVarbyFormula}}
#'
#'

check.dataform <- function(data) {
  if (!(is.matrix(data) || is.data.frame(data)))
    stop("Data should be a matrix or data frame", call. = FALSE)
  if (ncol(data) < 2)
    stop("Data should contain at least two columns", call. = FALSE)
  data <- as.data.frame(data)
  mat <- sapply(data, is.matrix)
  if (any(mat)) stop("Cannot handle columns with class matrix: ", 
                     colnames(data)[mat])
  
  dup <- duplicated(colnames(data))
  if (any(dup)) stop("Duplicate names found: ", 
                     paste(colnames(data)[dup], collapse = ", "))
  
  return(data)
}