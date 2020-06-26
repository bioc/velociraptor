% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/embedVelocity.R
\name{embedVelocity}
\alias{embedVelocity}
\title{Project velocities onto an embedding}
\usage{
embedVelocity(x, v, ...)
}
\arguments{
\item{x}{A numeric matrix of low-dimensional coordinates, e.g., after t-SNE.}

\item{v}{A \linkS4class{SingleCellExperiment} containing the output of the velocity calculations,
typically after running \code{\link{scvelo}}.}

\item{...}{Further arguments to pass to the \code{velocity_embedding} Python function from \pkg{scVelo}.}
}
\value{
A numeric matrix of the same dimensions as \code{x}, containing the projected velocity vectors in that embedding.
}
\description{
Project the velocity vector for each cell onto an existing low-dimensional embedding.
}
\details{
This is a simple wrapper around the \code{scvelo.tools.velocity_embedding} function.
Briefly, we construct a cell-cell transition matrix where a cell is more likely to transition to one of its neighbors
if its velocity vector is pointing in the same direction as that neighbor.
The resulting matrix is then used to compute a weighted average of the positions in \code{x},
allowing us to compute a velocity in the low-dimensional embedding.
}
\examples{
example(scvelo, echo=FALSE) # recycling that example.

# Making up a new embedding.
tsne.results <- matrix(rnorm(2*ncol(out)), ncol=2)

# Projecting the future state of each cell:
projected <- embedVelocity(tsne.results, out)

}
\author{
Aaron Lun
}