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
name.blocksDS <- function(blocks, prefix = "B") {
  if (!is.list(blocks)) return(make.blocks(blocks))
  if (is.null(names(blocks))) names(blocks) <- rep("", length(blocks))
  inc <- 1
  for (i in seq_along(blocks)) {
    if (names(blocks)[i] != "") next
    if (length(blocks[[i]]) == 1) names(blocks)[i] <- blocks[[i]][1]
    else {
      names(blocks)[i] <- paste0(prefix, inc)
      inc <- inc + 1
    }
  }
  blocks
}