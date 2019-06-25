#' Creates a \code{blocks} argument
#'
#' This helper function generates a list of the type needed for 
#' \code{blocks} argument in the \code{[=mice]{mice}} function.
#' @param data A \code{data.frame}, character vector with
#' variable names, or \code{list} with variable names.
#' @param partition A character vector of length 1 used to assign 
#' variables to blocks when \code{data} is a \code{data.frame}. Value 
#' \code{"scatter"} (default) will assign each column to it own 
#' block. Value \code{"collect"} assigns all variables to one block, 
#' whereas \code{"void"} produces an empty list.
#' @param calltype A character vector of \code{length(block)} elements 
#' that indicates how the imputation model is specified. If 
#' \code{calltype = "type"} (the default), the underlying imputation 
#' model is called by means of the \code{type} argument. The 
#' \code{type} argument for block \code{h} is equivalent to  
#' row \code{h} in the \code{predictorMatrix}.
#' The alternative is \code{calltype = "formula"}. This will pass 
#' \code{formulas[[h]]} to the underlying imputation 
#' function for block \code{h}, together with the current data.
#' The \code{calltype} of a block is set automatically during 
#' initialization. Where a choice is possible, calltype 
#' \code{"formula"} is preferred over \code{"type"} since this is 
#' more flexible and extendable. However, what precisely happens
#' depends also on the capabilities of the imputation 
#' function that is called.
#' @return A named list of character vectors with variables names.
#' @details Choices \code{"scatter"} and \code{"collect"} represent to two 
#' extreme scenarios for assigning variables to imputation blocks. 
#' Use \code{"scatter"} to create an imputation model based on 
#' \emph{fully conditionally specification} (FCS). Use \code{"collect"} to 
#' gather all variables to be imputed by a \emph{joint model} (JM). 
#' Scenario's in-between these two extremes represent 
#' \emph{hybrid} imputation models that combine FCS and JM.
#' 
#' Any variable not listed in will not be imputed. 
#' Specification \code{"void"} represents the extreme scenario that 
#' skips imputation of all variables. 
#' 
#' A variable may be a member of multiple blocks. The variable will be 
#' re-imputed in each block, so the final imputations for variable 
#' will come from the last block that was executed. This scenario 
#' may be useful where the same complete background factors appear in 
#' multiple imputation blocks.
#' 
#' A variable may appear multiple times within a given block. If a univariate 
#' imputation model is applied to such a block, then the variable is 
#' re-imputed each time as it appears in the block.
#' @examples
#' make.blocks(nhanes)
#' make.blocks(c("age", "sex", "edu"))
#' @export
make.blocksDS <- function(data, 
                        partition = c("scatter", "collect", "void"),
                        calltype = "type") {
  if (is.vector(data) && !is.list(data)) {
    v <- as.list(as.character(data))
    names(v) <- as.character(data)
    ct <- rep(calltype, length(v))
    names(ct) <- names(v)
    attr(v, "calltype") <- ct
    return(v)
  }
  if (is.list(data) && !is.data.frame(data)) {
    v <- name.blocks(data)
    if (length(calltype) == 1L) {
      ct <- rep(calltype, length(v))
      names(ct) <- names(v)
      attr(v, "calltype") <- ct
    }
    else {
      ct <- calltype
      names(ct) <- names(v)
      attr(v, "calltype") <- ct
    }
    return(v)
  }
  data <- as.data.frame(data)
  partition <- match.arg(partition)
  switch(partition, 
         scatter = {
           v <- as.list(names(data))
           names(v) <- names(data)
         },
         collect = {
           v <- list(names(data))
           names(v) <- "collect"
         },
         void = {
           v <- list()
         },
         {
           v <- as.list(names(data))
           names(v) <- names(data)
         })
  if (length(calltype) == 1L) {
    ct <- rep(calltype, length(v))
    names(ct) <- names(v)
    attr(v, "calltype") <- ct
  }
  else {
    ct <- calltype
    names(ct) <- names(v)
    attr(v, "calltype") <- ct
  }
  return(v)
}