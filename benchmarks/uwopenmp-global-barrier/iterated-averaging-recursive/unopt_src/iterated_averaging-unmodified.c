

//#define _GNU_SOURCE
//#include <syscall.h>
//#include <sched.h>

#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "header.h"
#include <math.h>
double *newA;
double *oldA;
double *diff;
double *temp;

int __cani_enter(int i, int j) {
  return 1;
}

void __i_exit(int i){
}

void __reset(int i, int l, int h) {
}
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

double sum(double *d)
{
  double res = 0.0;
  int i;
  for (i = 1; i <= N; i++) 
    res += d[i];
  return res;
}

int main()
{
  int j;
  struct timeval tv1;
  struct timeval tv2;
  // initialize the prng with a fixed seed.
  srand48(101);
  oldA = ((double *)(malloc((sizeof(double ) * (N + 2)))));
  newA = ((double *)(malloc((sizeof(double ) * (N + 2)))));
  diff = ((double *)(malloc((sizeof(double ) * (N + 2)))));
  oldA[0] = EPSILON / (N + 1);
  for (j = 1; j <= N; j++) {
    oldA[j] = drand48();
  }
  oldA[N + 1] = EPSILON / (N + 1);
  double epsilon = EPSILON;
  double delta = (epsilon + 1);
  int iters = 0;
  gettimeofday(&tv1,0);
  int __NPhase = N + 1;
  int __Phase[__NPhase];
  memset(__Phase,0,__NPhase*sizeof(int));
  int __S00 = 8;
  int __NH = N + 1;
  int __H[__NH][__S00];
  memset(__H,0,(__NH * __S00*sizeof(int)));
  int __flag = 1;
  int __tmpflag = 0;
  int __cp = 0;
  int __NWhile00 = N + 1;
  char __vWhile00[__NWhile00];
  int __count0 = 0;
  int __N01 = N + 1;
  char __v01[__N01];
  int __N0111 = N + 1;
  char __v0111[__N0111];

#pragma omp parallel  shared(newA,oldA) private(j)
  {

		//int tid = omp_get_thread_num();

		//cpu_set_t set;
		//CPU_ZERO(&set);
		//CPU_SET(tid*2 + 1, &set);
		//int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);
		//if (t != 0) fprintf (stderr, "Setting affiinty failed for %d\n", tid);


    {
      do {

#pragma omp for
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][0])) {
            __H[j][0] = 1;
            __vWhile00[j] = (delta > epsilon);
            __v01[j] = ((int )__vWhile00[j]) != 0;
          }
        }

#pragma omp for
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][1])) {
            __H[j][1] = 1;
            if (__v01[j]) {
              newA[j] = ((oldA[j - 1] + oldA[j + 1]) / 2.0);
              diff[j] = fabs((newA[j] - oldA[j]));
            }
          }
        }
        /* *************Start of barrier************** */

#pragma omp for 
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][2])) {
            __H[j][2] = 1;
            if (__v01[j]) 
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

#pragma omp for
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][3])) {
            __H[j][3] = 1;
            __v0111[j] = __v01[j];
          }
        }

#pragma omp for
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][4])) {
            __H[j][4] = 1;
            if (__v0111[j]) {
              if (j == 1) {
                delta = sum(diff);
                iters++;
                temp = newA;
                newA = oldA;
                oldA = temp;
              }
            }
          }
        }
        /* *************Start of barrier************** */

#pragma omp for 
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][5])) {
            __H[j][5] = 1;
            if (__v0111[j]) 
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

#pragma omp for
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][6])) {
            __H[j][6] = 1;
            if (__v0111[j]) {
              __reset(j,0,0);
            }
          }
        }

#pragma omp for 
        for (j = 1; j <= N; j++) {
          if (__cani_enter(j,0) && (__Phase[j] == __cp && !__H[j][7])) {
            __H[j][7] = 1;
            if (!(__vWhile00[j] != 0)) {
#pragma omp critical 
              __count0++;
              __i_exit(j);
            }
          }
        }
#pragma omp for 
        for(j=1;j< __NH;++j){
          memset(__H[j], 0, __S00*sizeof(int));
          __Phase[j] = __cp ;
        }

        if (__count0 == __NWhile00 - 1) 
          break; 
        /* Code generated to While loop ends */
      }while (1);
      /* Code generated for while loop starts */
    }
  }
  fprintf(stderr,"#iterations = %d\n",iters);
  gettimeofday(&tv2,0);
  fprintf(stdout,"Run time = ");
  getruntime(tv1,tv2);
  return 0;
}
