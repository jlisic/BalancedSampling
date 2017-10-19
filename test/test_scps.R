library(BalancedSampling)

N <- 200
n <- 10
p <- 3 

i <- 100

set.seed(i)
x <- matrix(rnorm(N*p),ncol=p)

prob <- rep(n/N,N)

set.seed(i)
y <- scps(prob,x)

#set.seed(i)
#y_kdtree <- lpm2_kdtree(prob,x)
#
#print( sum(y != y_kdtree) )

