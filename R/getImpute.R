#'
#' @title Partial Computation for Model Fitted Values
#' @description Calculates the fitted values in each data node.
#' @details Considering \code{y} as a response variable and x as study variable, the fitted values are the y-values that
#' would expect for the given x-values according to the best-fitting straight line.
#'
#' @param beta is a list of the regression coefficients.
#' @param formula a string character to be transformed as an object of class \code{formula}.
#'
#' @return a vector of fitted values.
#'
#' @section Dependencies:
#' \code{\link{getVarbyFormula}}
#'
#' @author Paula R. Costa e Silva
#' @export
#'

getImpute <- function(beta, formula, type, m) {
  
  #Format variables
  vars <- all.vars(formula)
  vars <- vars[-1]
  xColNames <- vars[-1]
  yColNames <- vars[1]
  
  #Data transformations
  beta.reg.aux <- as.numeric(unlist(strsplit(beta, split="x")))
  beta.reg <- data.matrix(beta.reg.aux)
  m <- as.integer(m)
  #dataset <- eval(parse(text="D"))
  bindxy <- dataset[,vars]
  
  row.sums <- rowSums(is.na(bindxy))
  naLines <- names(which(row.sums!=0))
  #Select subset of missing data
  xValuesMiss <- bindxy[which(rownames(bindxy) %in% naLines), ]
  #Select subset of complete data
  xValuesComplete <- bindxy[-which(rownames(bindxy) %in% naLines), ]
  
  #Select subset of xValues
  xValues <- as.data.frame(unique(bindxy[,xColNames]))
  colnames(xValues) <- xColNames
  
  #Formula to compute the estimated values
  xMiss <- as.matrix(xValuesMiss[-1]) #x values where y is missing
  xComplete <- as.matrix(xValuesComplete[-1])
  
  #Compute estimated values y_hat_miss and y_hat_obs
  yHatMis <- beta.reg[1] + xMiss %*% as.vector(beta.reg[-1])
  yHatObs <- beta.reg[1] + xComplete %*% as.vector(beta.reg[-1])
  
  toReturn <- NULL
  newDataSet <- NULL
  switch(type, 
         combine={
           toReturn <- list(yHatMis=yHatMis, yHatObs=yHatObs)
         },
         split={
           cont <- 1
           imputedValues <- c()
           teste <- list()
           for (value in yHatMis) {
             subtract <- data.frame(abs(mapply('-', value, yHatObs))) #same x values rownames
             colnames(subtract) <- "dif"
             rownames(subtract) <- rownames(yHatObs)
             subtract$names <- rownames(subtract)
             orderedDiff <- subtract[with(subtract, order(dif)), ]
             topDiff <- orderedDiff[1:m,]
             candidateMap <- sample(topDiff[,"names"], 1)
             #idValor <- orderedDiff[1,"names"]
             randomValue <- xValuesComplete[candidateMap, 1]
             imputedValues[cont] <- randomValue
             cont <- cont + 1
           }
           imputedValues <- as.data.frame(imputedValues)
           rownames(imputedValues) <- naLines
           colnames(imputedValues) <- yColNames
           toReturn <- imputedValues
           newDataSet <- dataset
           newDataSet[which(rownames(newDataSet) %in% rownames(imputedValues)), yColNames] <- imputedValues
           toReturn <- newDataSet
         }
  )
  
  # Update dataset global variable
  dataset <<- newDataSet
  
  return(toReturn)
  
}
