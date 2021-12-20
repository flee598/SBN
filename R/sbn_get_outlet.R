#' Find river mouth vertex
#'
#' Find river mouth node from a directed graph.
#'
#' @param g a igraph directed graph representation of a river, e.g. an SBN or OCN.
#'
#' @return an integer identifying the river mouth  vertex
#'
#' @import igraph
#'
#'
#' @examples
#' \dontrun{
#' sbn_get_outlet(g)
#' }
#' @export
sbn_get_outlet <- function(g){

  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")

  g_dwn <- igraph::adjacent_vertices(g, v = igraph::V(g), mode = "out")
  riv_mouth <- which(sapply(g_dwn, function(x) length(x) == 0))
  return(riv_mouth)
}
