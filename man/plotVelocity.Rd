% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotVelocity.R
\name{plotVelocity}
\alias{plotVelocity}
\title{Phase and velocity graphs for a set of genes}
\usage{
plotVelocity(
  x,
  genes,
  use.dimred = 1,
  assay.splicedM = "Ms",
  assay.unsplicedM = "Mu",
  which.plots = c("phase", "velocity", "expression"),
  genes.per.row = 1,
  color_by = "#222222",
  color.alpha = 0.4,
  colors.velocity = c("#A50026", "#D73027", "#F46D43", "#FDAE61", "#FEE08B", "#FFFFBF",
    "#D9EF8B", "#A6D96A", "#66BD63", "#1A9850", "#006837"),
  colors.expression = c("#440154", "#482576", "#414487", "#35608D", "#2A788E", "#21908C",
    "#22A884", "#43BF71", "#7AD151", "#BBDF27", "#FDE725"),
  max.abs.velo = 0.001
)
}
\arguments{
\item{x}{A \linkS4class{SingleCellExperiment} object with RNA velocity results
as returned by \code{\link{scvelo}}, and low-dimensional coordinates, e.g.,
after t-SNE, in its \code{\link{reducedDims}}.}

\item{genes}{A character vector with one or several genes for which to plot
phase and velocity graphs. \code{genes} have to be in \code{rownames(x)}.}

\item{use.dimred}{String or integer scalar specifying the reduced dimensions
to retrieve from \code{x}.}

\item{assay.splicedM}{An integer scalar or string specifying the assay of
\code{x} containing the moments of spliced abundances.}

\item{assay.unsplicedM}{An integer scalar or string specifying the assay of
\code{x} containing the moments unspliced abundances.}

\item{which.plots}{A character vector specifying which plots to create for
each gene. Possible values are \code{"phase", "velocity", "expression"} and
correspond to the phase graph or reduced dimension graphs with cells
colored by velocity or (spliced) expression.}

\item{genes.per.row}{An integer scalar with the numbers of genes to visualize
per row of plots. For example, if \code{which.plots =  c("phase","expression")}
and \code{genes.per.row = 2}, the resulting figure will have four plot
panels per row.}

\item{color_by}{A character scalar specifying a column in \code{colData(x)}
to color cells in the phase graph. Alternatively, \code{color_by} can be
set to vector of valid R colors, either of length one (recycled for all
cells) or of length \code{ncol(x)}, which will then be used to color cells
in the phase graph.}

\item{color.alpha}{An integer scalar giving the transparency of colored
cells. Possible values are between 0 (fully transparent) and 1.0 (opaque).}

\item{colors.velocity, colors.expression}{Character vectors specifying the
color ranges used for mapping velocities and expression values. The
defaults are \code{RColorBrewer::brewer.pal(11, "RdYlGn")} for the
velocities and \code{viridisLite::viridis(11)} for the expression values.}

\item{max.abs.velo}{A numeric scalar greater than zero giving the maximum
absolute velocity to limit the color scale for the \code{"velocity"} graph.}
}
\value{
A patchwork object with the plots selected by \code{which.plot} for
  the genes in \code{genes}, arranged in a grid according to \code{genes.per.row}.
}
\description{
For a each gene in a set of genes, show the phase graph (spliced versus
unspliced counts and fitted model) and reduced dimension graphs with
cell colored by velocity and (spliced) expression.
}
\details{
Please note that \code{plotVelocity} will modify parameters of
  the current graphics device using \code{\link{layout}} and \code{\link{par}},
  in order to create the layout for the generated graph panels.
}
\examples{
library(scuttle)
set.seed(42)
sce1 <- mockSCE(ncells = 100, ngenes = 500)
sce2 <- mockSCE(ncells = 100, ngenes = 500)

datlist <- list(X=counts(sce1), spliced=counts(sce1), unspliced=counts(sce2))

out1 <- scvelo(datlist, mode = "steady_state")
out2 <- scvelo(datlist, mode = "dynamical")

plotVelocity(out1, c("Gene_0031","Gene_0268"))
plotVelocity(out2, c("Gene_0031","Gene_0268"))

}
\seealso{
\code{\link{scvelo}}, to generate \code{x},
\code{\link[RColorBrewer]{brewer.pal}} and \code{\link[viridisLite]{viridis}}
for creation of color palettes, packages \pkg{ggplot2} and \pkg{patchwork}
used to generate and arrange the plots.
}
\author{
Michael Stadler
}
