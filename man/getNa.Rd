% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getNa.R
\name{getNa}
\alias{getNa}
\title{Partial Computation for Model Fitted Values}
\usage{
getNa(formula, v1 = NULL, v2 = NULL)
}
\arguments{
\item{formula}{a string character to be transformed as an object of class \code{formula}.}

\item{beta}{is a list of the regression coefficients.}

\item{x}{is a study variable.}
}
\value{
a vector of fitted values.
}
\description{
Calculates the fitted values in each data node.
}
\details{
Considering \code{y} as a response variable and x as study variable, the fitted values are the y-values that
would expect for the given x-values according to the best-fitting straight line.
}
\section{Dependencies}{

\code{\link{getVarbyFormula}}
}

\author{
Paula R. Costa e Silva
}
