#' Get strahler order
#'
#' @param g a dendritic network as an igraph object
#'
#' @return a vector of stream strahler orders
#'
#' @import igraph
#'
#' @examples
#' \dontrun{
#' sbn_strahler(g)
#' }
#' @export
sbn_strahler <- function(g) {

  if (max(igraph::degree(g, igraph::V(g), mode = "in")) > 2) stop("network must not have vertices with more that two connected upstream verticies")

  res <- rep(0, igraph::gorder(g))
  names(res) <- 1:igraph::gorder(g)

  dg <- igraph::degree(g, mode = "in")
  res[dg == 0] <- 1

  while(any(res == 0)) {
    xx <- unique(unlist(igraph::adjacent_vertices(g,
                                          v = names(res[res > 0]),
                                          mode = "out")))

    xx <- res[xx]
    xx <- as.numeric(names(xx[xx == 0]))

    for (i in xx) {

      zz <- igraph::adjacent_vertices(g, v = i, mode = "in")
      vs <- res[unlist(zz)]
      if (all(vs > 0)) {
        if (length(unique(vs)) == 1 & length(vs) == 2) {
          res[i] <- max(vs) + 1
        } else {res[i] <- max(vs)}
      }
    }
  }
  return(res)
}

