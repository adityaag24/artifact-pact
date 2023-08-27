#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "../../../src/utility/static-opt/header.h"
#define N 16384 
#define M 16384
float **A;
void init(){
    A = malloc(sizeof(float *) * M);
    int i,j;
    for(i=0;i<M;i++){
        A[i] = malloc(sizeof(float) * N);
    }
    for(i=0;i<M;i++){
        for(j=0;j<N;j++){
            A[i][j] = (float)(random())/RAND_MAX;
        }
    }
    return;
}
void recTask(int,int);
int main(){
    double itime,ftime;
    init();
    itime = omp_get_wtime();
    #pragma omp parallel
    {
        int i,j;
        #pragma omp for
        for(i=0;i<N;i++){
            recTask(i,1);
        }
    }
    ftime = omp_get_wtime();
    fprintf(stdout,"Run time = ");
    fprintf(stdout,"%lf seconds\n",(ftime - itime));
}
void recTask(int i,int t){
    if(t <= (N+M-3)){
        int a,b;
        if(t>=i && t<M+i-1){
            b = i; a = t - i + 1;
            A[a][b] = A[a-1][b] + A[a][b-1];
        }
        WAITALL(1)
        recTask(i, t + 1);
    }
}
