#' Creates a \code{predictorMatrix} argument
#'
#' This helper function creates a valid \code{predictMatrix}. The 
#' \code{predictorMatrix} is an argument to the \code{mice} function. 
#' It specifies the target variable or block in the rows, and the 
#' predictor variables on the columns. An entry of \code{0} means that 
#' the column variable is NOT used to impute the row variable or block.
#' A nonzero value indicates that it is used.
#' @param data A \code{data.frame} with the source data
#' @param blocks An optional specification for blocks of variables in 
#' the rows. The default assigns each variable in its own block.
#' @return A matrix
#' @seealso \code{\link{make.blocks}}
#' @examples
#' make.predictorMatrix(nhanes)
#' make.predictorMatrix(nhanes, blocks = make.blocks(nhanes, "collect"))
#' @export
#' 
make.predictorMatrixDS <- function(data, blocks = make.blocks(data)) {
  data <- check.dataform(data)
  predictorMatrix <- matrix(1, nrow = length(blocks), ncol = ncol(data))
  dimnames(predictorMatrix) <- list(names(blocks), colnames(data))
  for (i in row.names(predictorMatrix)) 
    predictorMatrix[i, colnames(predictorMatrix) %in% i] <- 0
  
  return(predictorMatrix)
}

