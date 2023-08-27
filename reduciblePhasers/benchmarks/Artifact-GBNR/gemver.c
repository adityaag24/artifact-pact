#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include "../../../src/utility/static-opt/header.h"
#define N 16384 

double **A;
double *u1;
double *v1;
double *u2;
double *v2;
double *w;
double *x;
double *y;
double *z;

double alpha;
double beta;

void init(){
  int i, j;
  alpha = 43532;
  beta = 12313;
  for (i = 0; i < N; i++)
    {
      u1[i] = i;
      u2[i] = (i+1)/N/2.0;
      v1[i] = (i+1)/N/4.0;
      v2[i] = (i+1)/N/6.0;
      y[i] = (i+1)/N/8.0;
      z[i] = (i+1)/N/9.0;
      x[i] = 0.0;
      w[i] = 0.0;
      for (j = 0; j < N; j++)
	    A[i][j] = ((double) i*j) / N;
    }
}


int main(){
	A = calloc(N, sizeof(double *));
	int i;
	for (i = 0; i < N; i++) {
		A[i] = calloc(N, sizeof(double));
	}
  
	u1 = calloc(N, sizeof(double));
	v1 = calloc(N, sizeof(double));
	u2 = calloc(N, sizeof(double));
	v2 = calloc(N, sizeof(double));
	w = calloc(N, sizeof(double));
	x = calloc(N, sizeof(double));
	y = calloc(N, sizeof(double));
	z = calloc(N, sizeof(double));
  init();
    double itime,ftime;
    init();
    itime = omp_get_wtime();
#pragma omp parallel 
  {
		int i, j;
#pragma omp for private(i,j)
    for (i = 0; i < N; i++) {
      for (j = 0; j < N; j++){
        A[i][j] = A[i][j] + u1[i] * v1[j] + u2[i] * v2[j];
      }
      WAITALL(1)
      for (j = 0; j < N; j++){
        x[i] = x[i] + beta * A[j][i] * y[j];
      }
      x[i] = x[i] + z[i];
      WAITALL(1)
      for (j = 0; j < N; j++){
        w[i] = w[i] +  alpha * A[i][j] * x[j];
      }
    }
  }
    ftime = omp_get_wtime();
    fprintf(stdout,"Run time = %lf seconds\n",(ftime - itime));
}
