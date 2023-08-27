#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "header.h"
#include <math.h>
#include "uwomp-barrier.h" 
void parallel_for_body1__while__0(int *p_i,int **p_iters);
void parallel_for_body1(int i,int *iters);
double *newA;
double *oldA;
double *diff;
double *temp;
double epsilon;
double delta;

void getruntime(struct timeval tv1,struct timeval tv2)
{
  time_t sec1;
  time_t sec2;
  suseconds_t usec1;
  suseconds_t usec2;
  sec1 = tv1 . tv_sec;
  sec2 = tv2 . tv_sec;
  usec1 = tv1 . tv_usec;
  usec2 = tv2 . tv_usec;
  double start_time = ((double )sec1) + usec1 / 1000000.0;
  double end_time = ((double )sec2) + usec2 / 1000000.0;
  fprintf(stderr,"%f\n",end_time - start_time);
}

double sum(double *d,double *delta)
{
  double res = 0.0;
  int i;
  for (i = 1; i <= 126; i++) 
    res += d[i];
   *delta = res;
}

void ompRegBody(int *iters)
{
  int i;
  
#pragma omp for  private(i)
  for (i = 1; i <= 126; i++) {
    parallel_for_body1(i,iters);
  }
}

int main()
{
  int j;
  struct timeval tv1;
  struct timeval tv2;
// initialize the prng with a fixed seed.
  srand48(101);
  oldA = ((double *)(malloc(sizeof(double ) * (126 + 2))));
  newA = ((double *)(malloc(sizeof(double ) * (126 + 2))));
  diff = ((double *)(malloc(sizeof(double ) * (126 + 2))));
//fprintf(stderr, "VAL = %f\n", VAL);
  oldA[0] = 20e-4 / (126 + 1);
  for (j = 1; j <= 126; j++) {
    oldA[j] = drand48();
//fprintf (stderr, "a[j] %.2lf", oldA[j]);
  }
  oldA[126 + 1] = 20e-4 / (126 + 1);
  epsilon = 20e-4;
  delta = epsilon + 1;
  int iters = 0;
  gettimeofday(&tv1,((void *)0));
#pragma omp parallel 
{
    ompRegBody(&iters);
  }
  fprintf(stderr,"#iterations = %d\n",iters);
  gettimeofday(&tv2,((void *)0));
  fprintf(stderr,"Run time = ");
  getruntime(tv1,tv2);
  return 0;
}

void parallel_for_body1(int i,int *iters)
{
  //parallel_for_body1__while__0(&i,&iters);
  parallel_for_body1__while__0(i,iters);
}

void parallel_for_body1__while__0(int *p_i,int **p_iters)
{
  int __if_v0;
  int *iters =  *p_iters;
  int i =  *p_i;
  if (!(delta > epsilon)) {
    return ;
  }
  newA[i] = (oldA[i - 1] + oldA[i + 1]) / 2.0;
  diff[i] = fabs(newA[i] - oldA[i]);
#pragma omp barrier 
  __if_v0 = i == 1;
  if (__if_v0) {
    sum(diff,&delta);
  }
  if (__if_v0) {
    ( *iters)++;
    temp = newA;
    newA = oldA;
    oldA = temp;
  }
#pragma omp barrier 
   *p_i = i;
   *p_iters = iters;
  parallel_for_body1__while__0(p_i,p_iters);
}


void parallel_for_body1__while__0(int p_i,int *p_iters)
{
  int __if_v0;
  int iters =  *p_iters;
  int i =  p_i;
  if (!(delta > epsilon)) {
    return ;
  }
  newA[i] = (oldA[i - 1] + oldA[i + 1]) / 2.0;
  diff[i] = fabs(newA[i] - oldA[i]);
#pragma omp barrier 
  __if_v0 = i == 1;
  if (__if_v0) {
    sum(diff,&delta);
  }
  if (__if_v0) {
    ( *iters)++;
    temp = newA;
    newA = oldA;
    oldA = temp;
  }
#pragma omp barrier 
   p_i = i;
   *p_iters = iters;
  parallel_for_body1__while__0(p_i,p_iters);
}
