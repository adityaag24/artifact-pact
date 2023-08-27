/**
 * jacobi-2d-imper.c: This file is part of the PolyBench/C 3.2 test suite.
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
/* Default data type is double, default size is 20x1000. */
#include "jacobi-2d-imper.h"
/* Array initialization. */

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


static void init_array(int n,double A[4000 + 0][4000 + 0],double B[4000 + 0][4000 + 0])
{
  int i;
  int j;
  for (i = 0; i < n; i++) 
    for (j = 0; j < n; j++) {
      A[i][j] = (((((double )i) * (j + 2)) + 2) / n);
      B[i][j] = (((((double )i) * (j + 3)) + 3) / n);
    }
}
/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */

static void print_array(int n,double A[4000 + 0][4000 + 0])
{
  int i;
  int j;
  for (i = 0; i < n; i++) 
    for (j = 0; j < n; j++) {
      fprintf(stderr,"%0.2lf ",A[i][j]);
      if ((((i * n) + j) % 20) == 0) 
        fprintf(stderr,"\n");
    }
  fprintf(stderr,"\n");
}
/* Main computational kernel. The whole function will be timed,
   including the call and return. */

static void kernel_jacobi_2d_imper(int tsteps,int n,double A[4000 + 0][4000 + 0],double B[4000 + 0][4000 + 0])
{
  int t;
  int i;
  int j;
//#pragma scop
  for (t = 0; t < tsteps; t++) {
    int __NPhase0 = (n - 1) - 1 + 2;
    int __Phase0[__NPhase0];
    memset(__Phase0,0,__NPhase0*sizeof(int));
    int __N = (n - 1) - 1 + 2;//added
    int __gCnt[__N]; //added
    memset(__gCnt, 0, __N*sizeof(int)); //added
    int __S00 = 3;
    int __NH0 = (n - 1) - 1 + 2;
    int __H0[__NH0][__S00];
    memset(__H0,0,__NH0 * __S00*sizeof(int));
    int __flag0 = 1;
    int __tempflag0 = 0;
    int __cp0 = 0;
#pragma omp parallel 
{
      do {
        
#pragma omp for  private(i,j)
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase0[i] == __cp0 && !__H0[i][0])) {
            __H0[i][0] = 1;
            for (j = 1; j < (n - 1); j++) 
              B[i][j] = (0.2 * ((((A[i][j] + A[i][j - 1]) + A[i][1 + j]) + A[1 + i][j]) + A[i - 1][j]));
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(i,j)
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase0[i] == __cp0 && !__H0[i][1])) {
            __H0[i][1] = 1;
            if (1) 
              __Phase0[i]++;
          }
          if (__Phase0[i] != __cp0 + 1) {
            __flag0 = 0;
          }
        }
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
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase0[i] == __cp0 && !__H0[i][2])) {
            __H0[i][2] = 1;
            for (j = 1; j < (n - 1); j++) 
              A[i][j] = B[i][j];
          }
        }
        break; 
      }while (1);
    }
  }
//#pragma endscop
}

int main(int argc,char **argv)
{
/* Retrieve problem size. */
  int n = 4000;
  int tsteps = 100;
/* Variable declaration/allocation. */
  double (*A)[4000 + 0][4000 + 0];
  A = ((double (*)[4000 + 0][4000 + 0])(polybench_alloc_data(((4000 + 0) * (4000 + 0)),(sizeof(double )))));;
  double (*B)[4000 + 0][4000 + 0];
  B = ((double (*)[4000 + 0][4000 + 0])(polybench_alloc_data(((4000 + 0) * (4000 + 0)),(sizeof(double )))));;
/* Initialize array(s). */
  init_array(n, *A, *B);
/* Start timer. */
  polybench_start_instruments;
/* Run kernel. */
  kernel_jacobi_2d_imper(tsteps,n, *A, *B);
/* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;
/* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
//  if ((argc > 42) && !(strcmp(argv[0],"") != 0)) 
    print_array(n, *A);
/* Be clean. */
  free(((void *)A));;
  free(((void *)B));;
  return 0;
}
