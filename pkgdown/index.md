
# nzffdr

<!-- badges: start -->
<!-- badges: end -->

Warning, currently a WIP, will likely be code breaking changes
occurring, until v 1.0.0!

The purpose of this package is to generate Stochastic Branching Networks
(SBNs), which are frequently used to represent the branching structure
of rivers in ecological models. The functions in the package rely
heavily on the [igraph](https://igraph.org/r/) package.

The fundamental unit of the SBN package is a downstream directed igraph
object. The package contains functions for generating and manipulating
these networks. THe functions *should* also work on river networks
generated in other packages, which have subsequently been converted to
[igraph](https://igraph.org/r/) objects
(e.g. [OCNs](https://cran.r-project.org/web/packages/OCNet/vignettes/OCNet.html)).

### Installation

SBN is currently only accessible the via GitHub.

``` r
devtools::install_github("flee598/SBN")
```

### Generatting SBNs

The SBNs generated are

### Basic manipulation

The SBN package has a handful of functions for basic manipulation of
networks.

### Calculating Strahler order

We can quickly calculate the Strahler order of vertices in a network.

### A note on plotting SBNs

For quick plotting I have generally used
[ggraph](https://www.data-imaginist.com/2017/ggraph-introduction-layouts/)
with the `tree` layout. As far as I can tell, the `tree` algorithm
doesn’t play nice with a downstream weighted network, and therefore for
plotting purposes you need to reverse the network to an upstream
weighted one and it works fine. It is a bit fiddly, but I haven’t found
any simple “out-of-the-box” alternative as of yet. Another option is to
generate your own vertex coordinates (as OCNet does), but I haven’t
gotten around to implementing that.