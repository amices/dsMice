##'
#' @title Sum of Study Variable Elements
#' @description It computes the sum of all values into a numeric vector.
#' @details Logical true values are regarded as one, false values as zero. For historical reasons,
#' NULL is accepted and treated as if it were integer(0).
#' Loss of accuracy can occur when summing values of different signs: this can even occur for sufficiently long
#' integer inputs if the partial sums would cause integer overflow. Where possible extended-precision accumulators are
#' used, but this is platform-dependent.
#' @param x numeric vector.
#' @return The sum.
#' If all of vakues are of type integer or logical, then the sum is integer, and in that case the result
#' will be NA (with a warning) if integer overflow occurs. Otherwise it is a length-one numeric or complex vector.
#' @author Paula R. Costa e Silva
#' @section Dependencies:
#' \code{\link{getVarByName}}
#' @export
#'
#'

getHistogram <- function(x) {
  bind.x <- getVarByName(x)
  hist <- unique(bind.x)
  # colnames(hist) <- c("value", "freq")
  # for (value in intervalList) {
  #   freq <- listValues[(listValues<=value)]
  #   hist <- rbind(hist, data.frame(value, length(freq)))
  # }
  # colnames(hist) <- c("value", "freq")
  # 
  # hist2 <- hist
  # for (i in 2:nrow(hist)) {
  #   hist2$freq[i] <- hist$freq[i] - hist$freq[i-1]
  # }

  return(hist)

}
