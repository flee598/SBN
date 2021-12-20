#' Convert to a downstream directed network
#'
#'Convert a non-directed network to a downstream directed network.
#'
#' @param g a river network as an igraph object
#'
#' @param mouth the rivermouth vertex
#'
#' @return a downstream directed network.
#'
#' @import igraph
#'
#' @examples
#' \dontrun{
#' sbn_down_dir(g, mouth = 1)
#' }
#' @export
sbn_down_dir <- function(g, mouth){

  g2 <- igraph::as.directed(igraph::as.undirected(g), mode = "mutual")

  x <- igraph::shortest_paths(graph = g2, from = mouth,
                              to = igraph::V(g2),
                              output = "epath", mode = "in")[2][[1]]

  y <- igraph::ends(g2, igraph::E(g2))
  y <- y[unique(unlist(lapply(x, igraph::as_ids))), ]
  g <- igraph::graph_from_edgelist(y)
  return(g)
}
