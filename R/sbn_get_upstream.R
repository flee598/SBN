#' find all vertices downstream of a given vertex
#'
#' Find all vertices upstream of a given vertex.
#'
#' @param g an SBN as an igraph object. Must be a downstream directed graph.
#'
#' @param vert target vertex to get all upstream nodes of
#'
#' @return a vector of upstream vertex id's
#'
#' @importFrom igraph shortest_paths
#'
#' @examples
#' \dontrun{
#' sbn_get_upstream(g, 5)
#' }
#' @export
sbn_get_upstream <- function(g, vert){
  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")
  x <- suppressWarnings(unique(unlist(shortest_paths(g, from = 5, to = V(g),
                                                           mode = "in")[[1]])))
  return(setdiff(x, vert))
}
