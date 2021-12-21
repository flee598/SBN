#' Convert network to various adjacency/distance matrix formats
#'
#' Convert a downstream directed SBN to various adjacency or distance matrix formats.
#'
#' @param g A river network as an igraph object. Must be a downstream directed graph.
#'
#' @param method One of "dwn_mtx", an adjacency matrix for a downstream directed SBN, "up_mtx", an adjacency matrix for a upstream directed SBN, "undir_mtx", an adjacency matrix for a  undirected SBN, "n2n_dist_up", "n2n_dist_dwn" or "n2n_dist_undir", an adjacency matrix of upstream, downstream or undirected node to node distances.
#'
#' @param unconnected When generating node-to-node distance matrices, what value should be used for unconnected elements. For example, in a downstream directed network, all upstream links are considered unconnected. Default value is `Inf` but other options are possible, such as `NA` or `0`.
#'
#' @param weights Passed to `igraph::shortest.paths()`. Possibly a numeric vector giving edge weights. If this is `NULL` and the graph has a weight edge attribute, then the attribute is used. If this is `NA` then no weights are used (even if the graph has a weight attribute).
#'
#' @return An adjacency or distance matrix.
#'
#' @import igraph
#'
#' @examples
#' g <- sbn_create(10, 0.7)
#' sbn_to_mtx(g, method = "dwn_mtx")
#'
#' @export
sbn_to_mtx <- function(g, method = c("dwn_mtx", "undir_mtx",
                                                "up_mtx", "n2n_dist_up",
                                                "n2n_dist_dwn", "n2n_dist_undir"),
                            unconnected = Inf, weights = NULL) {

  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")

  if (method == "dwn_mtx") res <- igraph::as_adj(g, sparse = FALSE)
  if (method == "up_mtx") res <- t(igraph::as_adj(g, sparse = FALSE))
  if (method == "undir_mtx") {
    undir_mtx <- igraph::as.undirected(g)
    res <- igraph::as_adj(undir_mtx, sparse = FALSE)
  }

  if (method == "n2n_dist_dwn") {
    res <- igraph::shortest.paths(g, mode = "out", weights = weights)
    res[is.infinite(res)] <- unconnected
  }

  if (method == "n2n_dist_up") {
    res <- igraph::shortest.paths(g, mode = "in", weights = weights)
    res[is.infinite(res)] <- unconnected
  }

  if (method == "n2n_dist_undir") {
    res <- igraph::shortest.paths(g, mode = "all", weights = weights)
    res[is.infinite(res)] <- unconnected
  }
  return(res)
}
