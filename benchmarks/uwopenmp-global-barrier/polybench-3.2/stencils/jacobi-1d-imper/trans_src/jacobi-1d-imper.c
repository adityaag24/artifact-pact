/**
 * jacobi-1d-imper.c: This file is part of the PolyBench/C 3.2 test suite.
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
//#include <polybench.h>
#include <polybench.h>
/* Include benchmark-specific header. */
/* Default data type is double, default size is 100x10000. */
#include "jacobi-1d-imper.h"
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

static void init_array(int n,double A[10000 + 0],double B[10000 + 0])
{
  int i;
  for (i = 0; i < n; i++) {
    A[i] = ((((double )i) + 2) / n);
    B[i] = ((((double )i) + 3) / n);
  }
}
/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */

static void print_array(int n,double A[10000 + 0])
{
  int i;
  for (i = 0; i < n; i++) {
    fprintf(stderr,"%0.2lf ",A[i]);
    if ((i % 20) == 0) 
      fprintf(stderr,"\n");
  }
  fprintf(stderr,"\n");
}
/* Main computational kernel. The whole function will be timed,
   including the call and return. */

static void kernel_jacobi_1d_imper(int tsteps,int n,double A[10000 + 0],double B[10000 + 0])
{
  int t = 0;
  int i;
  int j;
  int __NPhase0 = ((n - 1) - 1) + 2;
  int __Phase[__NPhase0];
  memset(__Phase,0,__NPhase0*sizeof(int));
  int __S00 = 6; //edited
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

#pragma omp for private(i)
      for (i = 1; i < (n - 1); i++) {
        if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][0])) {
          __H[i][0] = 1;
          __vWhile00[i] = (t < tsteps);
          __v01[i] = ((int )__vWhile00[i]) != 0;
	  if (__v01[i]) {
		  B[i] = (0.33333 * ((A[i - 1] + A[i]) + A[i + 1]));
	  }
  	  if (__v01[i]) 
            __Phase[i]++;
        }
	if (__Phase[i] != __cp + 1) {
		__flag = 0;
	}
      }

      /* *************Start of barrier************** */


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

#pragma omp for private(i)
      for (i = 1; i < (n - 1); i++) {
        if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][3])) {
          __H[i][3] = 1;
          if (__v01[i]) {
            A[i] = B[i];

            if (i == 1) 
            {
              //printf("t = %d\n", t);
              t++;
            }
            __reset(i,0,0);
          }
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
        __cp = 0;
        __flag = 1;
      }
//#pragma omp for  private(i)
//        for(i=1;i < (n-1);i++){
//            memset(__H[i], 0, __S00);
//	    __Phase[i] = 0;
//	    if(i==1) {
//		__cp == 0; 
//		__flag=1;
//		__Phase[0]=0;
//		__Phase[n-1]=0;
//	    }
//        }

      if (__count0 > __NWhile00 - 1) 
        break; 
      /* Code generated to While loop ends */

//#pragma omp for private(i)
//      for (i = 1; i < (n - 1); i++) {
//        if ((__cani_enter(i,0,__gCnt) != 0) && ((__Phase[i] == __cp) && !(__H[i][5] != 0))) {
//          __H[i][5] = 1;
//          if (i == 1) 
//          {
//            printf("t = %d\n", t);
//            t++;
//          }
//        }
//      }

//#pragma omp single //added
//      {
//        memset(__Phase,0,__NPhase0*sizeof(int));
//        memset(__H,0,(__NH0 * __S00*sizeof(int)));
//        __cp = 0;
//        __flag = 1;
//      }

    }while (1);
    /* Code generated for while loop starts */
  }
  //#pragma endscop
}

int main(int argc,char **argv)
{
  /* Retrieve problem size. */
  int n = 10000;
  int tsteps = 100;
  //int tsteps = 2000;
  /* Variable declaration/allocation. */
  double (*A)[10000 + 0];
  A = ((double (*)[10000 + 0])(polybench_alloc_data((10000 + 0),(sizeof(double )))));;
  double (*B)[10000 + 0];
  B = ((double (*)[10000 + 0])(polybench_alloc_data((10000 + 0),(sizeof(double )))));;
  /* Initialize array(s). */
  init_array(n, *A, *B);
  /* Start timer. */
  polybench_start_instruments;
  /* Run kernel. */
  kernel_jacobi_1d_imper(tsteps,n, *A, *B);
  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;
/* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, *A);
/* Be clean. */
  free(((void *)A));;
  free(((void *)B));;
  return 0;
}
