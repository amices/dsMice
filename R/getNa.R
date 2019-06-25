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
#' @author Paula R. Costa e Silva
#' @export
#'

getNa <- function(formula, v1=NULL, v2=NULL) {
  bindxy <- getVarbyFormula(formula)
  bindxy$ID <- seq.int(nrow(bindxy))
  naLines <- subset(bindxy, is.na(bindxy[,1]))
  # if(!is.null(v1)){
  #   naLines$imp1 <- naLines[,2] * as.numeric(v1)
  # } 
  # if(!is.null(v2)) {
  #   naLines$imp2 <- naLines[,3] * as.numeric(v2)
  # }
  return(naLines)
}