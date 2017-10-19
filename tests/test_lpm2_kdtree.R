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

set.seed(100)
N <- 10
n <- 4 
#x <- cbind( runif(N), runif(N))
x <- runif(N)
m <- 2 

print(x)

set.seed(100)
Cprog <- proc.time()
resample <-  lpm2_kdtree( rep(n/N,N), x, m=m, probTree=TRUE) 
print("lpm2_kdtree running time")
print(proc.time() - Cprog)

