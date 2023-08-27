/**
 * fdtd-2d.c: This file is part of the PolyBench/C 3.2 test suite.
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
/* Default data type is double, default size is 50x1000x1000. */
#include "fdtd-2d.h"
#include "header.h"
/* Array initialization. */

double **ex;
double **ey;
double **hz;
double *_fict_;

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

//static void init_array(int tmax,int nx,int ny,double ex[__NX__ + 0][__NY__ + 0],double ey[__NX__ + 0][__NY__ + 0],double hz[__NX__ + 0][__NY__ + 0],double _fict_[__TMAX__ + 0])
static void init_array(int tmax,int nx,int ny)
{
  int i;
  int j;
  for (i = 0; i < tmax; i++) 
    _fict_[i] = ((double )i);
  for (i = 0; i < nx; i++) 
    for (j = 0; j < ny; j++) {
      ex[i][j] = ((((double )i) * (j + 1)) / nx);
      ey[i][j] = ((((double )i) * (j + 2)) / ny);
      hz[i][j] = ((((double )i) * (j + 3)) / nx);
    }
}
/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */

//static void print_array(int nx,int ny,double ex[__NX__ + 0][__NY__ + 0],double ey[__NX__ + 0][__NY__ + 0],double hz[__NX__ + 0][__NY__ + 0])
static void print_array(int nx,int ny)
{
  int i;
  int j;
  for (i = 0; i < nx; i++) 
    for (j = 0; j < ny; j++) {
      fprintf(stderr,"%0.2lf ",ex[i][j]);
      fprintf(stderr,"%0.2lf ",ey[i][j]);
      fprintf(stderr,"%0.2lf ",hz[i][j]);
      if ((((i * nx) + j) % 20) == 0) 
        fprintf(stderr,"\n");
    }
  fprintf(stderr,"\n");
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */

//static void kernel_fdtd_2d(int tmax,int nx,int ny,double ex[__NX__ + 0][__NY__ + 0],double ey[__NX__ + 0][__NY__ + 0],double hz[__NX__ + 0][__NY__ + 0],double _fict_[__TMAX__ + 0])
static void kernel_fdtd_2d(int tmax,int nx,int ny)
{
  int t;
  int i;
  int j;
//#pragma scop
  for (t = 0; t < tmax; t++) {
    for (j = 0; j < ny; j++) 
      ey[0][j] = _fict_[t];
    for (i = 1; i < nx; i++) 
      for (j = 0; j < ny; j++) 
        ey[i][j] = (ey[i][j] - (0.5 * (hz[i][j] - hz[i - 1][j])));
    int __NPhase0 = nx - 0;
    int __Phase0[__NPhase0]; //changed
    memset(__Phase0,0,__NPhase0*sizeof(int));//changed
    int __N = nx - 0;//added
    int __gCnt[__N]; //added
    memset(__gCnt, 0, __N*sizeof(int)); //added
    int __S00 = 3;
    int __NH0 = nx - 0;
    int __H0[__NH0][__S00]; //changed
    memset(__H0,0,__NH0 * __S00*sizeof(int));
    int __flag0 = 1;
    int __tempflag0 = 0;
    int __cp0 = 0;
#pragma omp parallel 
{
      do {
        
#pragma omp for private(i, j)
        for (i = 0; i < nx; i++) {
          if (__cani_enter(i, 0, __gCnt) && (__Phase0[i] == __cp0 && !__H0[i][0])) {
            __H0[i][0] = 1;
            for (j = 1; j < ny; j++) 
              ex[i][j] = (ex[i][j] - (0.5 * (hz[i][j] - hz[i][j - 1])));
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(i, j)
        for (i = 0; i < nx; i++) {
          if (__cani_enter(i, 0, __gCnt) && (__Phase0[i] == __cp0 && !__H0[i][1])) {
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
        
#pragma omp for private(i, j)
        for (i = 0; i < nx; i++) {
          if (__cani_enter(i, 0, __gCnt) && (__Phase0[i] == __cp0 && !__H0[i][2])) {
            __H0[i][2] = 1;
            for (j = 0; j < (ny - 1); j++) 
// in the original code the second loop has one bound less.
              if (i != (nx - 1)) 
                hz[i][j] = (hz[i][j] - (0.7 * (((ex[i][j + 1] - ex[i][j]) + ey[i + 1][j]) - ey[i][j])));
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
  int tmax = __TMAX__;
  int nx = __NX__;
  int ny = __NY__;
/* Variable declaration/allocation. */
  //double (*ex)[__NX__ + 0][__NY__ + 0];
  //ex = ((double (*)[__NX__ + 0][__NY__ + 0])(polybench_alloc_data(((__NX__ + 0) * (__NY__ + 0)),(sizeof(double )))));;
  //double (*ey)[__NX__ + 0][__NY__ + 0];
  //ey = ((double (*)[__NX__ + 0][__NY__ + 0])(polybench_alloc_data(((__NX__ + 0) * (__NY__ + 0)),(sizeof(double )))));;
  //double (*hz)[__NX__ + 0][__NY__ + 0];
  //hz = ((double (*)[__NX__ + 0][__NY__ + 0])(polybench_alloc_data(((__NX__ + 0) * (__NY__ + 0)),(sizeof(double )))));;
  //double (*_fict_)[__TMAX__ + 0];
  //_fict_ = ((double (*)[__TMAX__ + 0])(polybench_alloc_data((__TMAX__ + 0),(sizeof(double )))));;
/* Initialize array(s). */

	ex = calloc(__NX__, sizeof(double *));
	ey = calloc(__NX__, sizeof(double *));
	hz = calloc(__NX__, sizeof(double *));
	int i;
	for (i = 0; i < __NX__; i++) {
		ex[i] = calloc(__NY__, sizeof(double));
		ey[i] = calloc(__NY__, sizeof(double));
		hz[i] = calloc(__NY__, sizeof(double));
	}
	_fict_ = calloc(__TMAX__, sizeof(double *));

  //init_array(tmax,nx,ny, *ex, *ey, *hz, *_fict_);
  init_array(tmax,nx,ny);

  /* Start timer. */
  polybench_start_instruments;

/* Run kernel. */
  //kernel_fdtd_2d(tmax,nx,ny, *ex, *ey, *hz, *_fict_);
  kernel_fdtd_2d(tmax,nx,ny);
/* Stop and print timer. */

  /* Stop and print timer. */
  polybench_stop_instruments;
	fprintf(stderr, "Run time = ");
  polybench_print_instruments;
/* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
//  if ((argc > 42) && !(strcmp(argv[0],"") != 0)) 
  //print_array(nx,ny, *ex, *ey, *hz);
  print_array(nx,ny);
/* Be clean. */
  free(((void *)ex));;
  free(((void *)ey));;
  free(((void *)hz));;
  free(((void *)_fict_));;
  return 0;
}
