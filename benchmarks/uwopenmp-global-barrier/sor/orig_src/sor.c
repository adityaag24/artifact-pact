#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "header.h"
#include <math.h>

double **A;

void getruntime(struct timeval tv1, struct timeval tv2) {
  time_t sec1, sec2;
  suseconds_t usec1, usec2;

  sec1 = tv1.tv_sec;
  sec2 = tv2.tv_sec;
  usec1 = tv1.tv_usec;
  usec2 = tv2.tv_usec;

  double start_time = (double)sec1 + (usec1/1000000.0);
  double end_time = (double)sec2 + (usec2/1000000.0);
  fprintf(stderr, "%f\n", end_time - start_time);
}
printArray(double **A, int m, int n) {
  int i, j;
  for(i = 0; i < n; i++) {
    for(j = 0; j < n; j++)
      fprintf(stderr, "%f ", A[i][j]);
    fprintf(stderr, "\n");
  }
}
int main()
{
  int i, j, k;
  int m, n, niters;
  struct timeval tv1, tv2;
  
  m = M; n = N; niters = NITERS;
  srand48(101); // initialize the prng with a fixed seed.
  
  A = (double **)malloc(sizeof(double*) * m);
  for(i = 0; i < n; i++) {
    A[i] = (double *) malloc (sizeof(double) * n);
  }

  for (j = 0; j < m; j++) {
    for (k = 0; k < m; k++) {
      A[j][k] = drand48();
      //fprintf (stderr, "a[j] %.2lf", oldA[j]);
    }
  }

  gettimeofday(&tv1, NULL);
  for(i = 0; i < niters; i++) {
#pragma omp parallel shared(A) 
    {
#pragma omp for private(j, k)
      for(j = 1; j < m-1; j++) {
        for(k = 1; k < n-1; k++) {
          if((j + k) % 2 == 0)
            A[j][k] = 0.25*(A[j-1][k] + A[j+1][k] + A[j][k-1] + A[j][k+1]);
        }
#pragma omp barrier
        for(k = 1; k < n-1; k++) {
          if((j + k) % 2 == 1)
            A[j][k] = 0.25*(A[j-1][k] + A[j+1][k] + A[j][k-1] + A[j][k+1]);
        }
      }
    }
  }
  gettimeofday(&tv2, NULL);
  fprintf(stderr, "Run time = ");
  getruntime(tv1, tv2);
  return 0;
}
