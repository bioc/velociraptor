% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotVelocityStream.R
\name{plotVelocityStream}
\alias{plotVelocityStream}
\title{Velocity stream plot in low-dimensional space}
\usage{
plotVelocityStream(
  sce,
  embedded,
  use.dimred = 1,
  color_by = "#444444",
  color.alpha = 0.2,
  grid.resolution = 60,
  scale = TRUE,
  stream.L = 10,
  stream.min.L = 0,
  stream.res = 4,
  stream.width = 8,
  color.streamlines = FALSE,
  color.streamlines.map = c("#440154", "#482576", "#414487", "#35608D", "#2A788E",
    "#21908C", "#22A884", "#43BF71", "#7AD151", "#BBDF27", "#FDE725"),
  arrow.angle = 8,
  arrow.length = 0.8
)
}
\arguments{
\item{sce}{A \linkS4class{SingleCellExperiment} object containing
low-dimensional coordinates, e.g., after t-SNE, in its
\code{\link{reducedDims}}.}

\item{embedded}{A low-dimensional projection of the velocity vectors into the
embedding of \code{sce}. This should be of the same dimensions as \code{sce}
and is typically produced by \code{\link{embedVelocity}}.}

\item{use.dimred}{String or integer scalar specifying the reduced dimensions
to retrieve from \code{sce}.}

\item{color_by}{A character scalar specifying a column in \code{colData(sce)}
to color cells in the phase graph. Alternatively, \code{color_by} can be
set to a valid R color to be used to color cells.}

\item{color.alpha}{An integer scalar giving the transparency of colored
cells. Possible values are between 0 (fully transparent) and 1.0 (opaque).}

\item{grid.resolution}{Integer scalar specifying the resolution of the grid,
in terms of the number of grid intervals along each axis.}

\item{scale}{Logical scalar indicating whether the averaged vectors should be
scaled by the grid resolution.}

\item{stream.L}{Integer scalar giving the typical length of a streamline
low-dimensional space units.}

\item{stream.min.L}{A numeric scalar with the minimum length of segments to be shown.}

\item{stream.res}{Numeric scalar specifying the resolution of estimated
streamlines (higher numbers increase smoothness of lines but also the time
for computation).}

\item{stream.width}{A numeric scalar controlling the width of streamlines.}

\item{color.streamlines}{Logical scalar. If \code{TRUE} streamlines will
be colored by local velocity. Arrows cannot be shown in that case.}

\item{color.streamlines.map}{A character vector specifying the
color range used for mapping local velocities to streamline colors. The
default is \code{viridisLite::viridis(11)}.}

\item{arrow.angle, arrow.length}{Numeric scalars giving the \code{angle} and
\code{length} of arrowheads.}
}
\value{
A \code{ggplot2} object with the streamline plot.
}
\description{
Plot velocities embedded into low-dimensional space as a stream plot. Stream
lines are lines that follow the gradient in the velocity field and illustrate
paths that cells could follow based on observed RNA velocities.
}
\details{
\code{grid.resolution} and \code{scale} are passed to
  \code{\link{gridVectors}}, which is used to summarized the velocity vectors
  into an initial grid. A full regular grid is computed from that and used
  in \code{\link[metR]{geom_streamline}} to calculate streamlines. The
  following arguments are passed to the arguments given in parenthesis of
  \code{\link[metR]{geom_streamline}}:
  \code{stream.L} (\code{L}), \code{stream.res} (\code{res}),
  \code{stream.min.L} (\code{min.L}), \code{arrow.angle} (\code{arrow.angle})
  and \code{arrow.length} (\code{arrow.length}).
  Streamlines are computed by simple integration with a forward Euler method,
  and \code{stream.L} and \code{stream.res} are used to compute the number of
  steps and the time interval between steps for the integration.
  \code{stream.width} is multiplied with \code{..step..} estimated by
  \code{\link[metR]{geom_streamline}} to control the width of streamlines.
}
\examples{
library(scuttle)
set.seed(42)
sce1 <- mockSCE(ncells = 100, ngenes = 500)
sce2 <- mockSCE(ncells = 100, ngenes = 500)

datlist <- list(X=counts(sce1), spliced=counts(sce1), unspliced=counts(sce2))

out <- scvelo(datlist, mode = "dynamical")

em <- embedVelocity(reducedDim(out, 1), out)[,1:2]

# https://github.com/kevinrue/velociraptor/issues/90

if (!basilisk.utils::isMacOSX()){
plotVelocityStream(out, em)
plotVelocityStream(out, em, color.streamlines = TRUE)
}

}
\seealso{
\code{\link{gridVectors}} used to summarize velocity vectors into
  a grid (velocity field), the \pkg{ggplot2} package used for plotting,
  \code{\link[metR]{geom_streamline}} in package \pkg{metR} used to
  calculate and add streamlines from the RNA velocity field to the plot,
  \code{\link[viridisLite]{viridis}} for creation of color palettes.
}
\author{
Michael Stadler
}
