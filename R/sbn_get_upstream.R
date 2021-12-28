#' Find all nodes upstream of a given node
#'
#' Find all nodes upstream of a given node.
#'
#' @param g a river network as an igraph object. Must be a downstream directed graph.
#'
#' @param node target node to get all upstream nodes of.
#'
#' @return A vector of upstream node id's.
#'
#' @importFrom igraph shortest_paths is.directed V
#'
#' @examples
#' g <- sbn_create(10, 0.7)
#' sbn_get_upstream(g, 2)
#'
#' @export
sbn_get_upstream <- function(g, node){
  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")
  x <- suppressWarnings(unique(unlist(igraph::shortest_paths(g, from = node, to = igraph::V(g),
                                                           mode = "in")[[1]])))
  return(setdiff(x, node))
}
