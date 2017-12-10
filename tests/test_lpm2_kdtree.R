library(BalancedSampling)

if( F ) {
set.seed(100)
N <- 1000
n <- 10
x <- cbind( runif(N), runif(N))
m <- 10
# compare lpm2 to lpm2_kdtree

set.seed(100)
Cprog <- proc.time()
sampled <- lpm2( rep(n/N,N), x)
print("lpm2_kdtree running time")
print(proc.time() - Cprog)


set.seed(100)
Cprog <- proc.time()
sampled_kdtree <- lpm2_kdtree( rep(n/N,N), x)
print("lpm2_kdtree running time")
print(proc.time() - Cprog)

print(sum( sampled != sampled_kdtree) /n)


# compare multiple runs of lpm2_kdtree to lpm2 with resampling
set.seed(100)
Cprog <- proc.time()
sampled_kdtree <- c()
for( i in 1:m) sampled_kdtree <- c( sampled_kdtree, lpm2_kdtree( rep(n/N,N), x) )
sampled_kdtree <- matrix( sampled_kdtree, ncol=m)
print("lpm2_kdtree running time")
print(proc.time() - Cprog)


set.seed(100)
Cprog <- proc.time()
resample <-  lpm2_kdtree( rep(n/N,N), x, resample = m) 
print("lpm2_kdtree running time")
print(proc.time() - Cprog)



print(sum( sampled_kdtree != resample) /n)
}

# run a prob tree

if( F ) {
set.seed(100)
N <- 10
n <- 4 
x <- cbind( runif(N), runif(N))
#x <- runif(N)
m <- 2 

print(x)

set.seed(100)
Cprog <- proc.time()
resample <-  lpm2_kdtree( rep(n/N,N), x, m=m, probTree=FALSE) 
print("lpm2_kdtree running time")
print(proc.time() - Cprog)

set.seed(100)
Cprog <- proc.time()
resample_prob <-  lpm2_kdtree( rep(n/N,N), x, m=m, probTree=TRUE) 
print("lpm2_kdtree running time")
print(proc.time() - Cprog)

}
N <- 100
n <- 10
m <- 10
x <- cbind( runif(N), runif(N))

#x    <- c( 0.1, 0.3, 0.4, 0.7, 0.9, 1.2 )
#prob <- c( 1/6, 1/6, 2/6, 2/6, 3/6, 3/6 ) 
set.seed(100)

resample_prob <-  lpm2_kdtree( rep(n/N,N), x, m=m, probTree=FALSE, returnTree=TRUE,returnBounds=TRUE) 

a <- resample_prob$bounds 
a[ a[,1] == -Inf,1] <- min(x[,1])
a[ a[,2] == -Inf,2] <- min(x[,2])
a[ a[,3] == Inf,3] <- max(x[,1])
a[ a[,4] == Inf,4] <- max(x[,2])

plot(x, col=resample_prob$nodes + 1)
for( i in 1:NROW(a) ) { 
  lines(x= a[i,c(1,1)], y=a[i,c(2,4)] )
  lines(x= a[i,c(3,3)], y=a[i,c(2,4)] )
  lines(x= a[i,c(1,3)], y=a[i,c(2,2)] )
  lines(x= a[i,c(1,3)], y=a[i,c(4,4)] )
}










