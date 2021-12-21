#' Find river mouth node
#'
#' Find river mouth node from a directed graph.
#'
#' @param g A river network as an igraph object. Must be a downstream directed graph.
#'
#' @return An integer identifying the id of river mouth node.
#'
#' @import igraph
#'
#'
#' @examples
#' g <- sbn_create(10, 0.5)
#' sbn_get_outlet(g)
#'
#' @export
sbn_get_outlet <- function(g){

  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")

  g_dwn <- igraph::adjacent_vertices(g, v = igraph::V(g), mode = "out")
  riv_mouth <- which(sapply(g_dwn, function(x) length(x) == 0))
  return(riv_mouth)
}
