library("arrow")
library("phytools")
library("ape")
library("optparse")



main <- function(opt) {

    tree <- ape::read.tree(opt$tree)
    df_bm_simu <- fastBM(
            tree = tree,
            a = as.double(opt$a),
            sig2 = as.double(opt$sig2),
            bounds = c(as.double(opt$bound_inf), as.double(opt$bound_sup)),
            nsim = as.integer(opt$nsim))
    print(df_bm_simu)
    write_f(df = df_bm_simu, output = opt$output)
}


write_f <- function(df, output) {
    write_feather(x = as.data.frame(df), sink = output, version = 2)
}

option_list <- list(
    make_option("--tree", type="character", default=NULL,help="--tree", metavar="character"),
    make_option("--a", type="character", default=NULL,  help="--a", metavar="character"),
    make_option("--mu", type="character", default=NULL, help="--mu", metavar="character"),
    make_option("--sig2", type="character", default=NULL, help="--sig2", metavar="character"),
    make_option("--bound_inf", type="character", default=NULL, help="--bound_inf", metavar="character"),
    make_option("--bound_sup", type="character", default=NULL, help="--bound_sup", metavar="character"),
    make_option("--alpha", type="character", default=NULL, help="--alpha", metavar="character"),
    make_option("--theta", type="character", default=NULL, help="--theta", metavar="character"),
    make_option("--nsim", type="character", default=NULL, help="--nsim", metavar="character"),
    make_option("--output", type="character", default=NULL, help="--output", metavar="character")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

if (is.null(opt$tree)) {
  print_help(opt_parser)
   stop("", call. = FALSE)
}

main(opt = opt)