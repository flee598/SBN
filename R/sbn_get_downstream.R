#' find all vertices downstream of a given vertex
#'
#' @param g an SBN as an igraph object. Must be a downstream directed graph.
#'
#' @param vert target vertex to get all downstream nodes of
#'
#' @return a vector of downstream vertex id's
#'
#' @importFrom igraph shortest_paths
#'
#' @examples
#' \dontrun{
#' sbn_get_downstream(g, 5)
#' }
#' @export
sbn_get_downstream <- function(g, vert){
  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")
    x <- suppressWarnings(igraph::shortest_paths(g, from = vert, to = sbn::sbn_get_outlet(g),
                      mode = "out"))[[1]][[1]]
  return(setdiff(x, vert))
}
