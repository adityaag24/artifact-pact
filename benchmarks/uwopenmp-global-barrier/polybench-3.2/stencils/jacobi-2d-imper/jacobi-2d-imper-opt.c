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
  int t = 0;
  int i;
  int j;
  int __NPhase0 = ((n - 1) - 1) + 2;
  int __Phase[__NPhase0];
  memset(__Phase,0,__NPhase0*sizeof(int));
  int __S00 = 2; //edited
  int __NH0 = ((n - 1) - 1) + 2;
  int __H[__NH0][__S00];
  memset(__H,0,(__NH0 * __S00*sizeof(int)));
  int __flag = 1;
  int __tempflag = 0;
  int __cp = 0;
  int __NWhile00 = ((n - 1) - 1) + 2;
  int __vWhile00[__NWhile00];
  int __count0 = 0;
  int __N01 = (n - 1) - 1 + 2;
  int __v01[__N01];
  int __N = ((n - 1) - 1) + 2; //added
  int __gCnt[__N]; //added
  memset(__gCnt, 0, __N*sizeof(int)); //added

#pragma omp parallel 
  {
    do {

#pragma omp for private(i,j)
      for (i = 1; i < (n - 1); i++) {
        __vWhile00[i] = (t < tsteps);
        __v01[i] = ((int )__vWhile00[i]) != 0;
        if (__v01[i]) {
          for (j = 1; j < (n - 1); j++) 
            B[i][j] = (0.2 * ((((A[i][j] + A[i][j - 1]) + A[i][1 + j]) + A[1 + i][j]) + A[i - 1][j]));
        }
      }


#pragma omp for private(i,j)
      for (i = 1; i < (n - 1); i++) {
        if (__v01[i]) {
          for (j = 1; j < (n - 1); j++) 
            A[i][j] = B[i][j];
          if (i == 1) 
          {
            t++;

          }
        }
        if (!(__vWhile00[i] != 0)) {
#pragma omp critical 
          __count0++;
        }

      }
      if (__count0 > __NWhile00) 
        break; 
      /* Code generated to While loop ends */
    }while (1);
    /* Code generated for while loop starts */
  }
}

int main(int argc,char **argv)
{
/* Retrieve problem size. */
  int n = 4000;
  //int tsteps = 100;
  int tsteps = TSTEPS;
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
//  polybench_prevent_dce(print_array(n, POLYBENCH_ARRAY(A)));
  print_array(n, *A);
/* Be clean. */
  free(((void *)A));;
  free(((void *)B));;
  return 0;
}
