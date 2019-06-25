#'
#' @title Identify missing values
#' @description ...
#' @details ...
#'
#' @return the variables names with missing values.
#'
#'
#' @author Paula Silva, Rui Camacho
#' @export
#

identifyNas <- function(execution) {
  
  # if(is.null(vars)) {
  #   dataset <<- eval(parse(text="D"))
  # } else {
  #   dataset <<- getVarByName(vars)
  # }
  
  if(execution == 1) {
    dataset <<- eval(parse(text="D")) ##Define dataset of globalenv.
  } else if (execution > 1) {
    dataset <- dataset
  }
  # Filter only numeric data
  numericDataset <- Filter(is.numeric, dataset)
  
  col.sums <- colSums(is.na(numericDataset))
  naCols <- names(which(col.sums!=0))
  completeCols <- names(which(col.sums==0))
  nas <- is.na(numericDataset)
  
  data.nas <- as.data.frame(numericDataset[,naCols])
  data.complete <- as.data.frame(numericDataset[,completeCols])
  colnames(data.complete) <- completeCols
  rownames(data.complete) <- rownames(numericDataset)
  
  return(list(naCols=naCols, nas=nas, completeCols=completeCols, data.nas=data.nas, data.complete=data.complete))
  
}