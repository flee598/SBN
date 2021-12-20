#' Convert SBN to various adjacency matrix formats
#'
#' Convert a downstream directed SBN to various adjacency matrix or distance matrix formats.
#'
#' @param g An SBN
#'
#' @param method One of "dwn_mtx", an adjacency matrix for a downstream directed SBN, "up_mtx", an adjacency matrix for a upstream directed SBN, "undir_mtx", an adjacency matrix for a  undirected SBN or "v2v_dist", an adjacency matrix of vertex to vertex distances.
#'
#' @param unconnected When generating vertext-to-vertex distance matrices, what value should be used for unconnected elements. For example, in a downstream directed network, all upstream links are considered unconnected. Default value is `Inf` but other options are possible, such as `NA` or `0`.
#'
#' @param weights Passed to `igraph::shortest.paths()`. Possibly a numeric vector giving edge weights. If this is `NULL`` and the graph has a weight edge attribute, then the attribute is used. If this is `NA` then no weights are used (even if the graph has a weight attribute).
#'
#' @return An adjacency or distance matrix
#'
#' @import igraph
#'
#' @examples
#' \dontrun{
#' sbn_to_mtx(g, method = "dwn_mtx")
#' }
#' @export
sbn_to_mtx <- function(g, method = c("dwn_mtx", "undir_mtx",
                                                "up_mtx", "v2v_dist_up",
                                                "v2v_dist_dwn", "v2v_dist_undir",
                                                "v2v_dist_dwn"),
                            unconnected = Inf, weights = NULL) {

  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")

  if (method == "dwn_mtx") res <- igraph::as_adj(g, sparse = FALSE)
  if (method == "up_mtx") res <- t(igraph::as_adj(g, sparse = FALSE))
  if (method == "undir_mtx") {
    undir_mtx <- igraph::as.undirected(g)
    res <- igraph::as_adj(undir_mtx, sparse = FALSE)
  }

  if (method == "v2v_dist_dwn") {
    res <- igraph::shortest.paths(g, mode = "out", weights = weights)
    res[is.infinite(res)] <- unconnected
  }

  if (method == "v2v_dist_up") {
    res <- igraph::shortest.paths(g, mode = "in", weights = weights)
    res[is.infinite(res)] <- unconnected
  }

  if (method == "v2v_dist_undir") {
    res <- igraph::shortest.paths(g, mode = "all", weights = weights)
    res[is.infinite(res)] <- unconnected
  }
  return(res)
}
