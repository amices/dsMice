#' Construct blocks from \code{formulas} and \code{predictorMatrix} 
#'
#' This helper function attempts to find blocks of variables in the
#' specification of the \code{formulas} and/or \code{predictorMatrix}
#' objects. Blocks specified by \code{formulas} may consist of 
#' multiple variables. Blocks specified by \code{predictorMatrix} are
#' assumed to consist of single variables. Any duplicates in names are 
#' removed, and the formula specification is preferred.
#' \code{predictorMatrix} and \code{formulas}. When both arguments 
#' specify models for the same block, the model for the 
#' \code{predictMatrix} is removed, and priority is given to the 
#' specification given in \code{formulas}. 
#' @inheritParams mice 
#' @return A \code{blocks} object.
#' @seealso \code{\link{make.blocks}}, \code{\link{name.blocks}}
#' @examples
#' form <- name.formulas(list(bmi + hyp ~ chl + age, chl ~ bmi))
#' pred <- make.predictorMatrix(nhanes[, c("age", "chl")])
#' construct.blocks(formulas = form, pred = pred)
#' @export
construct.blocksDS <- function(formulas = NULL, predictorMatrix = NULL) {
  
  blocks.f <- blocks.p <- NULL
  if (!is.null(formulas)) {
    if (!all(sapply(formulas, is.formula))) return(NULL)
    blocks.f <- name.blocks(lapply(name.formulas(formulas), lhs))
    ct <- rep("formula", length(blocks.f))
    names(ct) <- names(blocks.f)
    attr(blocks.f, "calltype") <- ct
    if (is.null(predictorMatrix)) return(blocks.f)
  }
  
  if (!is.null(predictorMatrix)) {
    if (is.null(row.names(predictorMatrix)))
      stop("No row names in predictorMatrix", call. = FALSE)
    blocks.p <- name.blocks(row.names(predictorMatrix))
    ct <- rep("type", length(blocks.p))
    names(ct) <- names(blocks.p)
    attr(blocks.p, "calltype") <- ct
    if (is.null(formulas)) return(blocks.p)
  }
  
  # combine into unique blocks
  blocknames <- unique(c(names(blocks.f), names(blocks.p)))
  keep <- setdiff(blocknames, names(blocks.f))
  blocks <- c(blocks.f, blocks.p[keep])
  ct <- c(rep("formula", length(formulas)), 
          rep("type", length(keep)))
  names(ct) <- names(blocks)
  attr(blocks, "calltype") <- ct
  blocks
}