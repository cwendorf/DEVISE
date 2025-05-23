% File man/plotScatter.Rd
% Part of the DEVISE package, https://github.com/cwendorf/DEVISE

\name{plotScatter}
\alias{plotScatter}
\title{Plot Scatter}
\description{Provides a scatterplot and/or confidence ellipse.}

\usage{
\method{plotScatter}{data.frame}(frame, add=FALSE, main=NULL, ylab="Outcome", xlab="", xlim=NULL, ylim=NULL, ellipse=FALSE, conf.level=.95, points=TRUE, col="black", pch=16, add=FALSE)

\method{plotScatter}{wsm}(moments, corrs, add=FALSE, main=NULL, ylab="Outcome", xlab="", xlim=NULL, ylim=NULL, ellipse=TRUE, conf.level=.95, col="black", add=FALSE)
}

\arguments{
\item{frame}{a set of (non-empty) numeric vectors of data values}
\item{moments}{a matrix/frame of descriptive/summary statistics for the variables}
\item{corrs}{a matrix/frame of correlations for the data set}
\item{add}{whether the plot should added to the existing plot}
\item{ylab}{a label for the y-axis}
\item{xlab}{a label for the x-axis}
\item{main}{a custom title for the graph}
\item{xlim}{custom limits for the x axis}
\item{ylim}{custom limits for the y axis}
\item{ellipse}{whether a confidence ellipse should be plotted}
\item{conf.level}{confidence level for the ellipse}
\item{points}{whether the data points should be plotted}
\item{col}{a value for the shaded color of the points}
\item{pch}{a value indicating the symbol for the points}
}

\value{

The returned plot contains the scatterplot.}