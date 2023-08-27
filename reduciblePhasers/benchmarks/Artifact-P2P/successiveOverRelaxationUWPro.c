#include<stdio.h>
#include<stdlib.h>
#include<omp.h>
#include "../../../src/utility/generic-nored/header.h"
#define M 16384 
#define N 16384
#define T 50
double **A;
int main(int argc,char **argv){
printf("======Successive Over Relaxation======\n");
    printf("Input Array Size: %d\n\n",N);
    printf("Input Time Steps: %d\n\n",T);
    int i, j, k;
    srand48(101); 
    A = (double **)malloc(sizeof(double*) * M);
    for(i = 0; i < M; i++) {
        A[i] = (double *) malloc (sizeof(double) * N);
    }

    for (j = 0; j < M; j++) {
        for (k = 0; k < N; k++) {
            A[j][k] = drand48();
        }
    }
    double itime,ftime,time;
    itime = omp_get_wtime();
    #pragma omp parallel private(i)
    {
        int t = 0;
        #pragma omp for private(j)
        for(i=1;i<M-1;i++){ 
            while(t < T){
                for(j = 1; j < N-1; j++) {
                    if((i + j) % 2 == 0){
                        A[i][j] = 0.25*(A[i-1][j] + A[i+1][j] + A[i][j-1] + A[i][j+1]);
                    }
                }
                SIGNAL(1,i-1,i+1)
                WAIT(1,i-1,i+1)
                for(j = 1; j < N-1; j++) {
                    if((i + j) % 2 == 1){
                        A[i][j] = 0.25*(A[i-1][j] + A[i+1][j] + A[i][j-1] + A[i][j+1]);
                    }
                }
                SIGNAL(1,i-1,i+1)
                WAIT(1,i-1,i+1)
                t++;
            }
        }
    }
    ftime = omp_get_wtime();
    time = ftime - itime;
    fprintf(stdout,"Runtime = %lf\n",time);
}
