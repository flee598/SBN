#' get all headwater nodes
#'
#' @param g a dendritic network as an igraph object
#'
#' @return a vector of headwater node id's
#'
#' @import igraph
#'
#' @examples
#' \dontrun{
#' sbn_get_hw(g)
#' }
#' @export
sbn_get_hw <- function(g){
  if (!igraph::is.directed(g)) stop("g must be a downstream directed graph")
  which(igraph::degree(g, v = igraph::V(g), mode = "in") == 0)
}
