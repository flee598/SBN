#' Change the upstream/downstream direction of an SBN
#'
#' Change the upstream/downstream direction of an SBN to either, reversed or undirected.
#'
#' @param g A river network as an igraph object. Must be a downstream directed graph.
#'
#' @param method One of "rev" or "undir", determining what to convert the network to.
#'
#' @return A river network as an igraph object.
#'
#' @importFrom igraph as.undirected is.directed
#'
#' @examples
#' g <- sbn_create(10, 0.5)
#' sbn_change_dir(g, method = "rev")
#'
#' @export
sbn_change_dir <- function(g, method = c("rev", "undir")) {

  if (!igraph::is.directed(g)) stop("g must be a directed graph")

  if (method == "rev") {
    # taken from: https://lists.gnu.org/archive/html/igraph-help/2013-07/msg00085.html

    e <- igraph::get.data.frame(g, what = "edges")

    neworder <- 1:length(e)
    neworder[1:2] <- c(2, 1)
    e <- e[neworder]
    names(e) <- names(e)[neworder]

    if(!length(igraph::vertex_attr(g))) {
      res <- igraph::graph.data.frame(e)

    } else {
      res <- igraph::graph.data.frame(e,
                                      vertices =
                                        igraph::get.data.frame(g,
                                                               what = "vertices"))
   }
  }
  if (method == "undir") {
    res <- igraph::as.undirected(g)
  }
  return(res)
}
