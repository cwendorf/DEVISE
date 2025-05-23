% File man/plotDensity.Rd
% Part of the DEVISE package, https://github.com/cwendorf/DEVISE

\name{plotDensity}
\alias{plotDensity}
\alias{addDensity}
\title{Plot Density}
\description{Provides a density plot for each group or variable.}

\usage{
\method{plotDensity}{data.frame}(frame, add=FALSE, main=NULL, ylab="Outcome", xlab="", ylim=NULL, offset=.07, scale=.8, border=rgb(0, 0, 0, .2), col=rgb(0, 0, 0, .1))

\method{plotDensity}{formula}(formula, add=FALSE, main=NULL, ylab="Outcome", xlab="", ylim=NULL, offset=.07, scale=.8, border=rgb(0, 0, 0, .2), col=rgb(0, 0, 0, .1))
}

\arguments{
\item{frame}{a set of (non-empty) numeric vectors of data values}
\item{formula}{a formula of the form \code{lhs ~ rhs} where \code{lhs} is a numeric variable giving the data values and \code{rhs} a factor giving the corresponding groups}
\item{add}{whether the plot should added to the existing plot}
\item{ylab}{a label for the y-axis}
\item{xlab}{a label for the x-axis}
\item{main}{a custom title for the graph}
\item{ylim}{custom limits for the y axis}
\item{offset}{a value indicating the offset of the plot}
\item{scale}{a value that indicates the width of the plot}
\item{col}{a value for the shaded color of the plot}
\item{border}{a value for the border color of the plot}
}

\details{
`plotDensity` can be used to initialize a new plot or add to an existing plot (using the `add` argument). `addDensity` is identical to `plotDensity` without the need to utilize the `add` argument.
}

\value{
The returned plot contains densities for the groups or variables.
}