#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "header.h"

float **A;

void getruntime(struct timeval tv1, struct timeval tv2) {
  time_t sec1, sec2;
  suseconds_t usec1, usec2;

  sec1 = tv1.tv_sec;
  sec2 = tv2.tv_sec;
  usec1 = tv1.tv_usec;
  usec2 = tv2.tv_usec;

  double start_time = (double)sec1 + (usec1/1000000.0);
  double end_time = (double)sec2 + (usec2/1000000.0);
  fprintf(stdout, "%f\n", end_time - start_time);
}


void init() {
  A = malloc(sizeof(float *) * M);

	int i, j;
  for (i = 0; i < M; i++) 
    A[i] = malloc (sizeof(float) * N);
  for (i = 0; i < M; i++)
    for (j = 0; j < N; j++) {
      A[i][j] = (float)(random())/RAND_MAX;
		}

	return;
}

void printMatrix(float **B) {
  int i, j;

  for (i = 0; i < M; i++)
    for(j = 0; j < N; j++)
      fprintf(stderr, "%f ", B[i][j]);
  fprintf(stderr, "\n");
  return;
}

void compute() {
	int i, j;
	for (i = 1;i < M;i++)
		for(j = 1;j < N;j++)
			A[i][j] = A[i-1][j] + A[i][j-1];
}

int main() {
  struct timeval tv1, tv2;

	init();

  gettimeofday(&tv1, NULL);
	compute();
  gettimeofday(&tv2, NULL);
  fprintf(stdout, "Run time = ");
  getruntime(tv1, tv2);

	printMatrix(A);
}
