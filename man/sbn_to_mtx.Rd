% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sbn_to_mtx.R
\name{sbn_to_mtx}
\alias{sbn_to_mtx}
\title{Convert network to various adjacency/distance matrix formats}
\usage{
sbn_to_mtx(
  g,
  method = c("dwn_mtx", "undir_mtx", "up_mtx", "n2n_dist_up", "n2n_dist_dwn",
    "n2n_dist_undir"),
  unconnected = Inf,
  weights = NULL
)
}
\arguments{
\item{g}{a river network as an igraph object. Must be a downstream directed graph.}

\item{method}{one of "dwn_mtx", an adjacency matrix for a downstream directed SBN, "up_mtx", an adjacency matrix for a upstream directed SBN, "undir_mtx", an adjacency matrix for a  undirected SBN, "n2n_dist_up", "n2n_dist_dwn" or "n2n_dist_undir", an adjacency matrix of upstream, downstream or undirected node to node distances.}

\item{unconnected}{when generating node-to-node distance matrices, what value should be used for unconnected elements. For example, in a downstream directed network, all upstream links are considered unconnected. Default value is \code{Inf} but other options are possible, such as \code{NA} or \code{0}.}

\item{weights}{passed to \code{\link[igraph:distances]{igraph::shortest.paths()}}. Possibly a numeric vector giving edge weights. If this is \code{NULL} and the graph has a weight edge attribute, then the attribute is used. If this is \code{NA} then no weights are used (even if the graph has a weight attribute).}
}
\value{
An adjacency or distance matrix.
}
\description{
Convert a downstream directed SBN to various adjacency or distance matrix formats.
}
\examples{
g <- sbn_create(10, 0.7)
sbn_to_mtx(g, method = "dwn_mtx")

}
