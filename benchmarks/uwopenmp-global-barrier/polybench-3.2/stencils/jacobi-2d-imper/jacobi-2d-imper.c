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

#include "header.h"

double **A;
double **B;

int __cani_enter(int i, int g, int *__gCnt) {
  //return 1;
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


//static void init_array(int n,double A[__SIZE__ + 0][__SIZE__ + 0],double B[__SIZE__ + 0][__SIZE__ + 0])
static void init_array(int n)
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

//static void print_array(int n,double A[__SIZE__ + 0][__SIZE__ + 0])
static void print_array(int n)
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

//static void kernel_jacobi_2d_imper(int tsteps,int n,double A[__SIZE__ + 0][__SIZE__ + 0],double B[__SIZE__ + 0][__SIZE__ + 0])
static void kernel_jacobi_2d_imper(int tsteps,int n)
{
  int t = 0;
  int i;
  int j;
  int __NPhase0 = ((n - 1) - 1) + 2;
  int __Phase[__NPhase0];
  memset(__Phase,0,__NPhase0*sizeof(int));
  int __S00 = 5; //edited
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
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][0])) {
            __H[i][0] = 1;
            __vWhile00[i] = (t < tsteps);
            __v01[i] = ((int )__vWhile00[i]) != 0;
          }
        }
        
#pragma omp for private(i,j)
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][1])) {
            __H[i][1] = 1;
            if (__v01[i]) {
              for (j = 1; j < (n - 1); j++) 
                B[i][j] = (0.2 * ((((A[i][j] + A[i][j - 1]) + A[i][1 + j]) + A[1 + i][j]) + A[i - 1][j]));
            }
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(i,j)
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][2])) {
            __H[i][2] = 1;
            if (__v01[i]) 
              __Phase[i]++;
          }
          if (__Phase[i] != __cp + 1) {
            __flag = 0;
          }
        }
#pragma omp single 
{
          __tempflag = __flag;
          if (__flag) {
            __cp++;
          }
          __flag = 1;
        }
        if (__tempflag) {
          continue; 
        }
/* **************End of barrier************* */
        
#pragma omp for private(i,j)
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][3])) {
            __H[i][3] = 1;
            if (__v01[i]) {
              for (j = 1; j < (n - 1); j++) 
                A[i][j] = B[i][j];
              if (i == 1) 
              {
                t++;

              }
              __reset(i,0,0);
            }
          }
        }
        
#pragma omp for private(i,j)
        for (i = 1; i < (n - 1); i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][4])) {
            __H[i][4] = 1;
            if (!(__vWhile00[i] != 0)) {
#pragma omp critical 
              __count0++;
              __i_exit(i,__gCnt);
            }
          }
        }

#pragma omp single //added
      {
        memset(__Phase,0,__NPhase0*sizeof(int));
        memset(__H,0,(__NH0 * __S00*sizeof(int)));
        memset(__gCnt, 0, __N*sizeof(int)); //added
        __cp = 0;
        __flag = 1;
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
  int n = __SIZE__;
  int tsteps = __TSTEPS__;
/* Variable declaration/allocation. */
  //double (*A)[__SIZE__ + 0][__SIZE__ + 0];
  //A = ((double (*)[__SIZE__ + 0][__SIZE__ + 0])(polybench_alloc_data(((__SIZE__ + 0) * (__SIZE__ + 0)),(sizeof(double )))));;
  //double (*B)[__SIZE__ + 0][__SIZE__ + 0];
  //B = ((double (*)[__SIZE__ + 0][__SIZE__ + 0])(polybench_alloc_data(((__SIZE__ + 0) * (__SIZE__ + 0)),(sizeof(double )))));;
	A = calloc(__SIZE__, sizeof(double *));
	B = calloc(__SIZE__, sizeof(double *));
	int i;
	for (i = 0; i < __SIZE__; i++) {
		A[i] = calloc(__SIZE__, sizeof(double));
		B[i] = calloc(__SIZE__, sizeof(double));
	}

/* Initialize array(s). */
  //init_array(n, *A, *B);
  init_array(n);
/* Start timer. */
  polybench_start_instruments;
/* Run kernel. */
  //kernel_jacobi_2d_imper(tsteps,n, *A, *B);
  kernel_jacobi_2d_imper(tsteps, n);
/* Stop and print timer. */
  polybench_stop_instruments;
	fprintf(stdout, "Run time = ");
  polybench_print_instruments;
/* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
//  polybench_prevent_dce(print_array(n, POLYBENCH_ARRAY(A)));
  //print_array(n, *A);
  print_array(n);
/* Be clean. */
  free(((void *)A));;
  free(((void *)B));;
  return 0;
}
