#include <Rcpp.h>
using namespace Rcpp;

//**********************************************
// Author: Anton Grafström
// Last edit: 2014-03-18 
// Licence: GPL (>=2)
//**********************************************

// [[Rcpp::export]]
NumericVector lpm2(NumericVector prob, NumericMatrix x){
	int N = prob.size();
	int ncol = x.ncol();
	NumericVector index(N), p(N), nearest(N);
	
	double wp,lp,mindist,d,dp=0.0;
	int ri,rj,count;

  int i;  
	for(i=0;i<N;i++){index[i]=i; p[i]=prob[i];}
		
	NumericVector r1 = runif(N);
	NumericVector r2 = runif(N);

  //for( i = 0; i < N;i++) printf("r1[%d] = %f\n", (int) i, r1[i]);
  //for( i = 0; i < N;i++) printf("r2[%d] = %f\n", (int) i, r2[i]);

	int move;
	int temp;
	double a;
  //NumericVector tmp1(1);
  //NumericVector tmp2(1);
	
	for(int i=0;i<N-1;i++){	
		ri = i+floor((r1[i]*(N-i)));
		count = 0;
		mindist = 1e+200;
		for(int j=i;j<N;j++){
			if(j!=ri){
				d = 0.0;
				for(int k=0;k<ncol;k++){
					dp = x(index[ri],k)-x(index[j],k);
					d += dp*dp;
				}
				if(d==mindist){
					nearest[count] = j;
					count = count + 1;
						
				}
				if(d < mindist){
					nearest[0] = j;
					count = 1;
					mindist = d;
				}
			}
		}
	  // not needed if count	
    if( count > 1 ) {
      rj = nearest[floor(count*runif(1)[0])];
    } else {
      rj = nearest[0];
    }
    //printf("rj: %d\n", count);
		a = p[index[ri]]+p[index[rj]];
		if(a > 1){
			wp = 1;
		}else{
			wp = a;
		}
		lp = p[index[ri]]+p[index[rj]]-wp;
		if( r2[i] < (wp-p[index[rj]])/(wp-lp) ){
			p[index[ri]] = wp;
			p[index[rj]] = lp;
		}else{
			p[index[ri]] = lp;
			p[index[rj]] = wp;
		}
		if(i==N-2){
      //printf("before p[index[ri]] = %f\n",p[index[ri]]);
      //printf("before p[index[rj]] = %f\n",p[index[rj]]);

      /*
      tmp1 = runif(1);
      tmp2 = runif(1);
      printf("%f, %f\n", tmp1[0], tmp2[0]);
      */
			if(0.5<p[index[ri]]){
				p[index[ri]]=1;
			}else{
				p[index[ri]]=0;
			}
			if(0.5<p[index[rj]]){
				p[index[rj]]=1;
			}else{
				p[index[rj]]=0;
			}
       
      
      //printf("after p[index[ri]] = %f\n",p[index[ri]]);
      //printf("after p[index[rj]] = %f\n",p[index[rj]]);
		}	
		move = rj;
		if( p[index[ri]]==0 || p[index[ri]]==1 ){
			move = ri;
		}
		temp = index[i];
		index[i] = index[move];
		index[move] = temp;
	}
	int n = round(sum(p));
	NumericVector s(n);
	count = 0;
	for(int i=0;i<N;i++){
		if(p[i]==1){
			s[count]=i+1;
			count++;
		}
	}
	return s;
}
