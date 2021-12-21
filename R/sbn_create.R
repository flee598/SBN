#' Create SBNs
#'
#' An SBN river network as a downstream directed igraph object.
#'
#' SBNs are generated using a stochastic branching process. The network generation process starts from an initial downstream node (the river mouth). At each iteration a random node in the network, with no upstream connections is selected, and zero, one or two nodes are added upstream of it, depending on a branching probability (*p*). This process is repeated until a pre-determined number of nodes across the entire network is attained (*n*).
#'
#' @param n Desired number of nodes.
#'
#' @param p Branching probability, from 0 - 1. Passed to `stats::rbinom()`, the probability of success in two attempts at adding upstream branches.
#'
#' @return A river network as an igraph object.
#'
#' @importFrom stats rbinom
#' @importFrom igraph graph_from_adjacency_matrix
#'
#' @examples
#' sbn_create(10, 0.7)
#'
#' @export
sbn_create <- function(n, p) {

  if (p < 0 | p > 1) stop("p must be >= 0 & <= 1")
  if (n < 1) stop("n must be an integer > 0")

  resample <- function(x, ...) x[sample.int(length(x), ...)]
  ntw <- vector(length = n, mode = "list")
  names(ntw) <- 1:n
  crnt <- 1
  mx <- 1

  while (mx < n) {
    adLst <- vector(length = n, mode = "list")
    for (i in crnt) {
      if (p == 0) {
        ad <- 1} else{
          if(p > 0) ad <- stats::rbinom(1, 2 , p)
          #if(p == 0) ad <- 1
        }
      if (ad > 0) {
        ntw[[i]] <- mx + 1:ad
        adLst[[i]] <- mx + 1:ad
        mx <- max(mx + 1:ad)
      } else {
        adLst[[i]] <- NA
        ntw[[i]] <- NA
      }
    }
    crnt <- unlist(adLst)
    crnt <- crnt[!is.na(crnt)]

    if (length(crnt) == 0 ) {
      crnt <- resample(as.numeric(names(ntw)[is.na(ntw)]), 1)
    }
  }
  ntw <- rapply(ntw, function(x) ifelse(x > n, NA, x), how = "replace")

  adj_mtx <- matrix(0, nrow = n, ncol = n)
  for (i in 1:length(ntw)) {
    ntw[[i]]
    adj_mtx[i, ntw[[i]]] <- 1
  }
  dwn_adj <- t(adj_mtx)
  g <- igraph::graph_from_adjacency_matrix(dwn_adj)
  return(g)

}
