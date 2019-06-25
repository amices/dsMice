#' Creates a \code{visitSequence} argument
#'
#' This helper function creates a valid \code{visitSequence}. The 
#' \code{visitSequence} is an argument to the \code{mice} function that 
#' specifies the sequence in which blocks are imputed.
#' @inheritParams mice
#' @return Vector containing block names
#' @seealso \code{\link{mice}}
#' @examples
#' make.visitSequence(nhanes)
#' @export
#' 

make.visitSequence <- function(data = NULL, blocks = NULL) {
  
  if (!is.null(blocks)) {
    blocks <- name.blocks(blocks)
    return(names(blocks))
  }
  
  data <- check.dataform(data)
  blocks <- make.blocks(data)
  names(blocks)
}