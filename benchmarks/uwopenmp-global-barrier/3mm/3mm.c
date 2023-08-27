#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <omp.h>
#include "header.h"

int __cani_enter(int i, int g, int *__gCnt) {
  if(__gCnt[i] == 2*g) {
    __gCnt[i]++;
    return 1;
  }
  if(__gCnt[i] == 2*g + 1) {
    return 1;
  }
  return 0;
}

void __i_exit(int i, int *__gCnt) {
  __gCnt[i]++;
}

float **A;
float **B;
float **C;
float **D;
float **E;
float **F;
float **G;

void getruntime(struct timeval tv1,struct timeval tv2)
{
  time_t sec1;
  time_t sec2;
  suseconds_t usec1;
  suseconds_t usec2;
  sec1 = tv1.tv_sec;
  sec2 = tv2.tv_sec;
  usec1 = tv1.tv_usec;
  usec2 = tv2.tv_usec;
  double start_time = (((double )sec1) + (usec1 / 1000000.0));
  double end_time = (((double )sec2) + (usec2 / 1000000.0));
  fprintf(stdout,"%f\n",(end_time - start_time));
}

void init()
{
  int i;
  int j;
  srandom(1000);
  A = ((float **)(malloc((sizeof(float *) * N))));
  B = ((float **)(malloc((sizeof(float *) * N))));
  C = ((float **)(malloc((sizeof(float *) * N))));
  D = ((float **)(malloc((sizeof(float *) * N))));
  E = ((float **)(malloc((sizeof(float *) * N))));
  F = ((float **)(malloc((sizeof(float *) * N))));
  G = ((float **)(malloc((sizeof(float *) * N))));
  for (i = 0; i < N; i++) {
    A[i] = ((float *)(malloc((sizeof(float ) * N))));
    B[i] = ((float *)(malloc((sizeof(float ) * N))));
    C[i] = ((float *)(malloc((sizeof(float ) * N))));
    D[i] = ((float *)(malloc((sizeof(float ) * N))));
    E[i] = ((float *)(malloc((sizeof(float ) * N))));
    F[i] = ((float *)(malloc((sizeof(float ) * N))));
    G[i] = ((float *)(malloc((sizeof(float ) * N))));
  }
  for (i = 0; i < N; i++) 
    for (j = 0; j < N; j++) {
      A[i][j] = (((float )(random())) / 2147483647);
      B[i][j] = (((float )(random())) / 2147483647);
      C[i][j] = 0.0;
      D[i][j] = (((float )(random())) / 2147483647);
      E[i][j] = (((float )(random())) / 2147483647);
      F[i][j] = 0.0;
      G[i][j] = 0.0;
    }
}

void printMatrix(float **M)
{
  int i;
  int j;
  for (i = 0; i < N; i++) 
    for (j = 0; j < N; j++) 
      fprintf(stderr,"%f ",M[i][j]);
  fprintf(stderr,"\n");
}

int main(int argc,char **argv)
{
  int i;
  int j;
  int k;
  struct timeval tv1;
  struct timeval tv2;
  init();
  gettimeofday(&tv1,0);
  int __NPhase = N - 0;
  int __Phase[__NPhase];
  memset(__Phase,0,__NPhase*sizeof(int));
  int __N = N - 0;
  int __gCnt[__N];
  memset(__gCnt,0,__N*sizeof(int));
  int __S00 = 3;
  int __NH = N - 0;
  int __H[__NH][__S00];
  memset(__H,0,(__NH * __S00*sizeof(int)));
  int __flag = 1;
  int __tmpflag = 0;
  int __cp = 0;
#pragma omp parallel  shared(A,B,C,D,E,F,G)
{
{
      do {{
          
#pragma omp for private(i, j, k)
          for (i = 0; i < N; i++) {
            if ((__cani_enter(i,0, __gCnt) != 0) && ((__Phase[i] == __cp) && !(__H[i][0] != 0))) {
              __H[i][0] = 1;
              for (j = 0; j < N; j++) {
                for (k = 0; k < N; k++) {
                  C[i][j] += (A[i][k] * B[k][j]);
                  F[i][j] += (D[i][k] * E[k][j]);
                }
              }
            }
          }
/* *************Start of barrier************** */
          
#pragma omp for private(i, j, k)
          for (i = 0; i < N; i++) {
            if ((__cani_enter(i,0, __gCnt) != 0) && ((__Phase[i] == __cp) && !(__H[i][1] != 0))) {
              __H[i][1] = 1;
              if (1) 
                __Phase[i]++;
            }
            if (__Phase[i] != (__cp + 1)) {
              __flag = 0;
            }
          }
#pragma omp single 
{
            __tmpflag = __flag;
            if (__flag != 0) {
              __cp++;
            }
            __flag = 1;
          }
          if (__tmpflag != 0) {
            continue; 
          }
/* **************End of barrier************* */
          
#pragma omp for private(i,j,k)
          for (i = 0; i < N; i++) {
            if ((__cani_enter(i,0, __gCnt) != 0) && ((__Phase[i] == __cp) && !(__H[i][2] != 0))) {
              __H[i][2] = 1;
              for (j = 0; j < N; j++) {
                for (k = 0; k < N; k++) {
                  G[i][j] += (C[i][k] * F[k][j]);
                }
              }
              __i_exit(i, __gCnt);
            }
          }
          break; 
        }
      }while (1);
    }
  }
  gettimeofday(&tv2,0);
  fprintf(stdout,"Run time = ");
  getruntime(tv1,tv2);
//  fprintf(stderr, "Parallel Outuput:\n");
  //printMatrix(G);
  return 0;
}
