split_sample <- function(
  prob
) {

  r_prob <- range(prob)
  delta <- min( r_prob[1], 1-r_prob[2] )/2
  n <- length(prob)

  # send our data to the C program
  r.result <- .C("R_split_sample",
                 as.double( prob ),   # probability vector
                 as.integer( n ),                   # length of prob and nrow of x 
                 as.double(delta)
  )
    
  return( r.result ) 
}







