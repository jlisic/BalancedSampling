/* Copyright (c) 2015-2017 Jonathan Lisic 
 * Last edit: 17/10/19 - 10:57:03 
 * License: GPL (>=2) 
 */  

#ifndef LPM3_HEADER

#define LPM3_HEADER


#include <stdio.h>
#include <stdlib.h>

#include "R.h"
#include "Rinternals.h"
#include "Rmath.h"
#define PRINTF Rprintf

#include "kdtree_lpm.h"


/********************************/
/* Function Prototypes          */
/********************************/


/* return new prob */
void updateProb( 
    double * xPtr, 
    double * yPtr, 
    double U );


/* function to update the mapping and inverse mapping */
void updateMapping(size_t j,size_t i, size_t * indexMap, size_t * reverseIndexMap);


/* the R interface */
void R_lpm3(
    double * x,
    double * pi,
    int * nPtr,
    int * KPtr, 
    int * mPtr,
    int * algorithmPtr,
    int * maxCountPtr,
    double * termDist,
    int * recordOrder, 
    int * drawsPtr, /* resampling count */
    int * useProbPtr,
    int * nodeAssignment,
    double * bound 
  );


/* the R interface */
void R_lpm4(
    double * x,
    double * pi,
    int * nPtr,
    int * KPtr, 
    int * mPtr,
    int * useProbPtr,
    int * nodeAssignment
  );



#endif
