#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "header.h"
#include <math.h>
double **A;

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


//int __cani_enter(int j,int k) {
//  return 1;
//}
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
  int i;
  int j;
  int k;
  int m;
  int n;
  int niters;
  struct timeval tv1;
  struct timeval tv2;
  m = M;
  n = N;
  niters = NITERS;
// initialize the prng with a fixed seed.
  srand48(101);
  A = ((double **)(malloc((sizeof(double *) * m))));
  for (i = 0; i < n; i++) {
    A[i] = ((double *)(malloc((sizeof(double ) * n))));
  }
  for (j = 0; j < m; j++) {
    for (k = 0; k < m; k++) {
      A[j][k] = drand48();
//fprintf (stderr, "a[j] %.2lf", oldA[j]);
    }
  }
  gettimeofday(&tv1,0);
  for (i = 0; i < niters; i++) {
    int __NPhase = (m - 1) - 1 + 2; //edited
    int __Phase[__NPhase];//edited
    memset(__Phase,0,__NPhase*sizeof(int));//edited
    int __S00 = 3;
    int __NH = (m - 1) - 1 + 1; //edited
    int __H[__NH][__S00];
    memset(__H,0,__NH * __S00*sizeof(int));
    int __flag = 1;
    int __tmpflag = 0;
    int __cp = 0;

		int __N = ((m - 1) - 1) + 2; //added
		int __gCnt[__N]; //added
		memset(__gCnt, 0, __N*sizeof(int)); //added


#pragma omp parallel  shared(A)
{
      do {
        
#pragma omp for private(j, k)
        for (j = 1; j < (m - 1); j++) {
          if (__cani_enter(j,0, __gCnt) && (__Phase[j] == __cp && !__H[j][0])) {
            __H[j][0] = 1;
            for (k = 1; k < (n - 1); k++) {
              if (((j + k) % 2) == 0) 
                A[j][k] = (0.25 * (((A[j - 1][k] + A[j + 1][k]) + A[j][k - 1]) + A[j][k + 1]));
            }
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(j, k)
        for (j = 1; j < (m - 1); j++) {
          if (__cani_enter(j,0, __gCnt) && (__Phase[j] == __cp && !__H[j][1])) {
            __H[j][1] = 1;
            if (1) 
              __Phase[j]++;
          }
          if (__Phase[j] != __cp + 1) {
            __flag = 0;
          }
        }
#pragma omp single 
{
          __tmpflag = __flag;
          if (__flag) {
            __cp++;
          }
          __flag = 1;
        }
        if (__tmpflag) {
          continue; 
        }
/* **************End of barrier************* */
        
#pragma omp for private(j, k)
        for (j = 1; j < (m - 1); j++) {
          if (__cani_enter(j,0, __gCnt) && (__Phase[j] == __cp && !__H[j][2])) {
            __H[j][2] = 1;
            for (k = 1; k < (n - 1); k++) {
              if (((j + k) % 2) == 1) 
                A[j][k] = (0.25 * (((A[j - 1][k] + A[j + 1][k]) + A[j][k - 1]) + A[j][k + 1]));
            }
          }
        }
        break; 
      }while (1);
    }
  }
  gettimeofday(&tv2,0);
  fprintf(stdout,"Run time = ");
  getruntime(tv1,tv2);

	//printArray(A, m, n);
  return 0;
}
