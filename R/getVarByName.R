#'
#' @export
#' @title Access Data from Study Variables by name.
#' @description Access the values for a given study variable or a list of variables.
#' @details Internal function.
#' @param x a string character: the names of the studies variables.
#' @return a data matrix which each column is a study variable and its respecive values.
#' @author Paula R. Costa e Silva
#'

getVarByName <- function(x) {

  model.variables <- unlist(strsplit(x, split="0506"))

  x.vars.aux <- list()
  x.vars <- list()

  for (j in 1:length(model.variables)) {
    x.vars.aux[[j]] <- eval(parse(text=model.variables[j]))
    x.vars <- cbind(x.vars, x.vars.aux[[j]])
  }
  colnames(x.vars) <- model.variables

  return(x.vars)

}
