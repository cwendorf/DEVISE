% File man/plotCorrelations.Rd
% Part of the DEVISE package, https://github.com/cwendorf/DEVISE

\name{plotCorrelations}
\alias{plotCorrelations}
\title{Plot Correlations}
\description{Provides a plot of all correlations and their confidence intervals for a set of variables.}

\usage{
\method{plotCorrelations}{data.frame}(frame, , ylab="Correlation", xlab="", conf.level=.95, values=TRUE, main=NULL, ylim=NULL, digits=3)

\method{plotCorrelations}{wsm}(moments, corrs, ylab="Correlation", xlab="", mu=0, conf.level=.95, rope=NULL, values=TRUE, main=NULL, ylim=NULL, digits=3)
}

\arguments{
\item{frame}{a set of (non-empty) numeric vectors of data values}
\item{moments}{a matrix/frame of descriptive/summary statistics}
\item{corrs}{a matrix/frame of correlations among the measures}
\item{ylab}{a label for the y-axis}
\item{xlab}{a label for the x-axis}
\item{conf.level}{confidence level of the interval}
\item{values}{whether the points should be labeled with their values}
\item{main}{a custom title for the graph}
\item{ylim}{custom limits for the y axis}
\item{digits}{the specified number of decimal places}
}

\value{
The returned plot contains the following components:
\item{R}{the correlations for the variables}
\item{LL}{the lower limit of the confidence interval for the correlations}
\item{UL}{the upper limit of the confidence interval for the correlations}
}