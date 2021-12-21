
# SBN

<!-- badges: start -->
<!-- badges: end -->

Warning, currently a WIP, will likely be code breaking changes
occurring, until v 1.0.0!

The purpose of this package is to generate Stochastic Branching Networks
(SBNs), which are frequently used to represent the branching structure
of rivers in ecological models. The functions in this package rely
heavily on the [igraph](https://igraph.org/r/) package.

The fundamental unit of the SBN package is a downstream directed
`igraph` object. The package contains functions for generating and
manipulating these networks. The functions *should* also work on river
networks generated in other packages, which have subsequently been
converted to `igraph` objects
(e.g. [OCNs](https://cran.r-project.org/web/packages/OCNet/vignettes/OCNet.html)).

### Installation

SBN is currently only accessible via the GitHub repo.

``` r
devtools::install_github("flee598/SBN")
```

### Generatting SBNs

``` r
library(SBN)
# generate an SBN with 10 nodes and a branching probability of 0.7
g <- sbn_create(10, 0.7)
g
#> IGRAPH 9a49e51 D--- 10 9 -- 
#> + edges from 9a49e51:
#> [1]  2->1  3->2  4->2  5->3  6->4  7->5  8->6  9->7 10->7
```

### Basic manipulation

The SBN package has a handful of functions for basic manipulation of
networks.

``` r
# identify all headwater nodes
sbn_get_hw(g)
#> [1]  8  9 10

# get all nodes downstream of node 10
sbn_get_downstream(g, 10)
#> [1] 7 5 3 2 1

# get all nodes upstream of node 2
sbn_get_upstream(g, 2)
#> [1]  3  4  5  6  7  8  9 10

# get the id of the outlet node
sbn_get_outlet(g)
#> [1] 1

# get the node-to-node distance of an undirected network
sbn_to_mtx(g, method = "n2n_dist_undir")
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#>  [1,]    0    1    2    2    3    3    4    4    5     5
#>  [2,]    1    0    1    1    2    2    3    3    4     4
#>  [3,]    2    1    0    2    1    3    2    4    3     3
#>  [4,]    2    1    2    0    3    1    4    2    5     5
#>  [5,]    3    2    1    3    0    4    1    5    2     2
#>  [6,]    3    2    3    1    4    0    5    1    6     6
#>  [7,]    4    3    2    4    1    5    0    6    1     1
#>  [8,]    4    3    4    2    5    1    6    0    7     7
#>  [9,]    5    4    3    5    2    6    1    7    0     2
#> [10,]    5    4    3    5    2    6    1    7    2     0

# downstream directed network to upstream directed network
sbn_change_dir(g, method = "rev")
#> IGRAPH 9a52e86 DN-- 10 9 -- 
#> + attr: name (v/c)
#> + edges from 9a52e86 (vertex names):
#> [1] 1->2  2->3  2->4  3->5  4->6  5->7  6->8  7->9  7->10
```

### Calculating Strahler order

Calculate the Strahler order of nodes in a network.

``` r
# Strahler order
sbn_strahler(g)
#>  1  2  3  4  5  6  7  8  9 10 
#>  2  2  2  1  2  1  2  1  1  1
```

### A note on plotting SBNs

For quick plotting I have generally used
[ggraph](https://www.data-imaginist.com/2017/ggraph-introduction-layouts/)
with the `tree` layout. As far as I can tell, the `tree` algorithm
doesn’t play nice with a downstream weighted network, and therefore for
plotting purposes you need to reverse the network to an upstream
weighted one and it works fine. It is a bit fiddly, but I haven’t found
any simple “out-of-the-box” alternative as of yet. Another option is to
generate your own node coordinates (as OCNet does), but I haven’t gotten
around to implementing that.
