#include<stdio.h>
#include<stdlib.h>
#include<omp.h>
#include "../../../src/utility/generic-nored/header.h"
#define N 16384 
#define T 50
double **A,**B;
void init(){
	printf("======Gauss Seidel======\n");
    printf("Input Array Size: %d\n\n",N);
    printf("Input Time Steps: %d\n\n",T);
    int i,j;
    for(i=0;i<N;i++){
        A[i] = calloc(N,sizeof(double));
        B[i] = calloc(N,sizeof(double));
        for(j=0;j<N;j++){
            A[i][j] = (((double )i) * (j + 2) + 2) / N;
            B[i][j] = (((double )i) * (j + 3) + 3) / N;
        }
    }
}
int main(int argc,char **argv){
    A = calloc(N,sizeof(double));
    B = calloc(N,sizeof(double));
    init();
    int i,j;
    double itime,ftime,time;
    itime = omp_get_wtime();
    #pragma omp parallel private(i)
    {
        int t = 0;
        #pragma omp for private(j)
        for(i=1;i<N-1;i++){
            while(t < T){
                for(j=1;j<N-1;j++)
                    A[i][j] = (A[i-1][j-1] + A[i-1][j] + A[i-1][j+1] + A[i][j-1] + A[i][j] + A[i][j+1] + A[i+1][j-1] + A[i+1][j] + A[i+1][j+1])/9.0;
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
