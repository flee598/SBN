#' Find all headwater nodes
#'
#' Find all headwater nodes in a network.
#'
#' @param g A river network as an igraph object. Must be a downstream directed graph.
#'
#' @return A vector of headwater node id's.
#'
#' @import igraph
#'
#' @examples
#' g <- sbn_create(10, 0.5)
#' sbn_get_hw(g)
#'
#' @export
sbn_get_hw <- function(g){
  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")
  which(igraph::degree(g, v = igraph::V(g), mode = "in") == 0)
}
