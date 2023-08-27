/**
 * gemver.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
/* Include polybench common header. */
#include <polybench.h>
/* Include benchmark-specific header. */
/* Default data type is double, default size is 4000. */
#include "gemver.h"
/* Array initialization. */

int __cani_enter(int i, int g, int *__gCnt) {
   return 1;
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

void __reset(int i, int j, int k) {
  return;
}


static void init_array(int n,double *alpha,double *beta,double A[8000 + 0][8000 + 0],double u1[8000 + 0],double v1[8000 + 0],double u2[8000 + 0],double v2[8000 + 0],double w[8000 + 0],double x[8000 + 0],double y[8000 + 0],double z[8000 + 0])
{
  int i;
  int j;
   *alpha = 43532;
   *beta = 12313;
  for (i = 0; i < n; i++) {
    u1[i] = i;
    u2[i] = (((i + 1) / n) / 2.0);
    v1[i] = (((i + 1) / n) / 4.0);
    v2[i] = (((i + 1) / n) / 6.0);
    y[i] = (((i + 1) / n) / 8.0);
    z[i] = (((i + 1) / n) / 9.0);
    x[i] = 0.0;
    w[i] = 0.0;
    for (j = 0; j < n; j++) 
      A[i][j] = ((((double )i) * j) / n);
  }
}
/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */

static void print_array(int n,double w[8000 + 0])
{
  int i;
  for (i = 0; i < n; i++) {
    fprintf(stderr,"%0.2lf ",w[i]);
    if ((i % 20) == 0) 
      fprintf(stderr,"\n");
  }
}
/* Main computational kernel. The whole function will be timed,
   including the call and return. */

static void kernel_gemver(int n,double alpha,double beta,double A[8000 + 0][8000 + 0],double u1[8000 + 0],double v1[8000 + 0],double u2[8000 + 0],double v2[8000 + 0],double w[8000 + 0],double x[8000 + 0],double y[8000 + 0],double z[8000 + 0])
{
  int i;
  int j;
  int __NPhase0 = n - 0;
  int __Phase0[__NPhase0];
  memset(__Phase0,0,__NPhase0*sizeof(int));
  int __S00 = 3;
  int __NH0 = n - 0;
  int __H0[__NH0][__S00];
  memset(__H0,0,__NH0 * __S00*sizeof(int));
  int __flag0 = 1;
  int __tempflag0 = 0;
  int __cp0 = 0;
  int __N = n - 0;
  int __gCnt[__N]; //added
  memset(__gCnt, 0, __N*sizeof(int)); //added


#pragma omp parallel 
{
    do {
      
#pragma omp for private(i,j) 
      for (i = 0; i < n; i++) {
        if (__cani_enter(i,0,__gCnt) && (__Phase0[i] == __cp0 && !__H0[i][0])) {
          __H0[i][0] = 1;
          for (j = 0; j < n; j++) 
            A[i][j] = ((A[i][j] + (u1[i] * v1[j])) + (u2[i] * v2[j]));
          __Phase0[i]++;
        }
        if (__Phase0[i] != __cp0 + 1) {
          __flag0 = 0;
        }
      }
/* *************Start of barrier************** */
      
#pragma omp single 
{
        __tempflag0 = __flag0;
        if (__flag0) {
          __cp0++;
        }
        __flag0 = 1;
      }
      if (__tempflag0) {
        continue; 
      }
/* **************End of barrier************* */
      
#pragma omp for private(i,j)
      for (i = 0; i < n; i++) {
        if (__cani_enter(i,0,__gCnt) && (__Phase0[i] == __cp0 && !__H0[i][1])) {
          __H0[i][1] = 1;
          for (j = 0; j < n; j++) 
            x[i] = (x[i] + ((beta * A[j][i]) * y[j]));
          x[i] = (x[i] + z[i]);
          __Phase0[i]++;
        }
        if (__Phase0[i] != __cp0 + 1) {
          __flag0 = 0;
        }
      }
/* *************Start of barrier************** */
      
#pragma omp single 
{
        __tempflag0 = __flag0;
        if (__flag0) {
          __cp0++;
        }
        __flag0 = 1;
      }
      if (__tempflag0) {
        continue; 
      }
/* **************End of barrier************* */
      
#pragma omp for private(i,j)
      for (i = 0; i < n; i++) {
        if (__cani_enter(i,0,__gCnt) && (__Phase0[i] == __cp0 && !__H0[i][2])) {
          __H0[i][2] = 1;
          for (j = 0; j < n; j++) 
            w[i] = (w[i] + ((alpha * A[i][j]) * x[j]));
        }
      }
      break; 
    }while (1);
  }
}

int main(int argc,char **argv)
{
/* Retrieve problem size. */
  int n = 8000;
/* Variable declaration/allocation. */
  double alpha;
  double beta;
  double (*A)[8000 + 0][8000 + 0];
  A = ((double (*)[8000 + 0][8000 + 0])(polybench_alloc_data(((8000 + 0) * (8000 + 0)),(sizeof(double )))));;
  double (*u1)[8000 + 0];
  u1 = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*v1)[8000 + 0];
  v1 = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*u2)[8000 + 0];
  u2 = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*v2)[8000 + 0];
  v2 = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*w)[8000 + 0];
  w = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*x)[8000 + 0];
  x = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*y)[8000 + 0];
  y = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
  double (*z)[8000 + 0];
  z = ((double (*)[8000 + 0])(polybench_alloc_data((8000 + 0),(sizeof(double )))));;
/* Initialize array(s). */
  init_array(n,&alpha,&beta, *A, *u1, *v1, *u2, *v2, *w, *x, *y, *z);
/* Start timer. */
  polybench_start_instruments;
/* Run kernel. */
  kernel_gemver(n,alpha,beta, *A, *u1, *v1, *u2, *v2, *w, *x, *y, *z);
/* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;
/* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
//polybench_prevent_dce(print_array(n, POLYBENCH_ARRAY(w)));
  print_array(n, *w);
/* Be clean. */
  free(((void *)A));;
  free(((void *)u1));;
  free(((void *)v1));;
  free(((void *)u2));;
  free(((void *)v2));;
  free(((void *)w));;
  free(((void *)x));;
  free(((void *)y));;
  free(((void *)z));;
  return 0;
}
