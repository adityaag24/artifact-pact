#include<stdio.h>
#include<stdlib.h>
#include<omp.h>
#include "../../../src/utility/generic-nored/header.h"
#define N 16384 
#define T 50
double *A,*B;
void init(){
    printf("======1D Jacobian======\n");
    printf("Input Array Size: %d\n\n",N);
    printf("Input Time Steps: %d\n\n",T);
    int i;
    for(i=0;i<N;i++){
        A[i] = ((double)(i+2)) / N;
        B[i] = ((double)(i+3)) / N;
    }
}
int main(int argc,char **argv){
    A = calloc(N,sizeof(double));
    B = calloc(N,sizeof(double));
    init();
    int i,j;
    double itime,ftime,time;
    itime = omp_get_wtime();
    #pragma omp parallel private(i,j)
    {
        int t = 0;
        #pragma omp for private(i)
        for(i=1;i<N-1;i++){
            while(t < T){
                B[i] = 0.3333 * (A[i-1] + A[i] + A[i+1]);
                SIGNAL(1,i-1,i+1)
                WAIT(1,i-1,i+1)
                A[i] = B[i];
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
