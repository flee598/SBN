#' Convert direction of SBN
#'
#' Convert a downstream directed SBN to either, reversed or undirected.
#'
#' @param g a river network as an igraph object
#'
#' @param method One of "rev" or "undir", determining what to convert the network to.
#'
#' @return An igraph SBN
#'
#' @importFrom igraph as.undirected is.directed
#'
#' @examples
#' \dontrun{
#' sbn_direction(g, method = "up")
#' }
#' @export
sbn_change_dir <- function(g, method = c("rev", "undir")) {

  if (!igraph::is.directed(g)) stop("g must be a directed graph")

  if (method == "rev") {
    el <- igraph::get.edgelist(g, names = FALSE)
    res <- igraph::graph(rbind(el[, 2], el[, 1]))
  }
  if (method == "undir") {
    res <- igraph::as.undirected(g)
  }
  return(res)
}
