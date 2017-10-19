library(BalancedSampling)

N <- 1000 
n <- 2 
p <- 2 

for( i in 1:10) {
cat(sprintf("%d\n",i))
set.seed(i)
x <- matrix(rnorm(N*p),ncol=p)

prob <- rep(n/N,N)

set.seed(i)
y <- c( lpm2(prob,x), lpm2(prob,x) )
#print(y)
set.seed(i)
y_kdtree <- lpm2_kdtree(prob,x,resample=2)
y_kdtree <- y_kdtree %% N
y_kdtree[y_kdtree == 0] <- N
#print(y_kdtree)
print( sum(y != y_kdtree) )

}

