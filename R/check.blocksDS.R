#' Name imputation blocks
#'
#' This helper function names any unnamed elements in the \code{blocks} 
#' specification. This is a convenience function.
#' @inheritParams mice
#' @param prefix A character vector of length 1 with the prefix to
#' be using for naming any unnamed blocks with two or more variables.
#' @return A named list of character vectors with variables names.
#' @seealso \code{\link{mice}}
#' @details 
#' This function will name any unnamed list elements specified in 
#' the optional argument \code{blocks}. Unnamed blocks 
#' consisting of just one variable will be named after this variable.
#' Unnamed blocks containing more than one variables will be named 
#' by the \code{prefix} argument, padded by an integer sequence 
#' stating at 1.
#' @examples
#' blocks <- list(c("hyp", "chl"), AGE = "age", c("bmi", "hyp"), "edu")
#' name.blocks(blocks)
#' @export
#' 
check.blocksDS <- function(blocks, data, calltype = "type") {
  
  data <- check.dataform(data)
  blocks <- name.blocks(blocks)
  
  # check that all variable names exists in data
  bv <- unique(unlist(blocks))
  notFound <- !bv %in% colnames(data)
  if (any(notFound)) 
    stop(paste("The following names were not found in `data`:",
               paste(bv[notFound], collapse = ", ")))
  
  if (length(calltype) == 1L) {
    ct <- rep(calltype, length(blocks))
    names(ct) <- names(blocks)
    attr(blocks, "calltype") <- ct
  }
  else {
    ct <- calltype
    names(ct) <- names(blocks)
    attr(blocks, "calltype") <- ct
  }
  
  return(blocks)
}