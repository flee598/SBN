#' Find all downstream nodes
#'
#' Find all nodes downstream of a given node.
#'
#' @param g A river network as an igraph object. Must be a downstream directed graph.
#'
#' @param node target node to get all downstream nodes of.
#'
#' @return a vector of downstream node id's.
#'
#' @importFrom igraph shortest_paths
#'
#' @examples
#' g <- sbn_create(10, 0.7)
#' sbn_get_downstream(g, 10)
#'
#' @export
sbn_get_downstream <- function(g, node){
  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")
    x <- suppressWarnings(igraph::shortest_paths(g, from = node, to = sbn_get_outlet(g),
                      mode = "out"))[[1]][[1]]
  return(setdiff(x, node))
}
