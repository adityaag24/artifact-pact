#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include "../../../src/utility/static-opt/header.h"
#define N 1024
float **A,**B,**C,**D,**E,**F,**G;

void init(){
    int i,j;
    srandom(1000);
    A = (float **)malloc(sizeof(float *)*N);
    B = (float **)malloc(sizeof(float *)*N);
    C = (float **)malloc(sizeof(float *)*N);
    D = (float **)malloc(sizeof(float *)*N);
    E = (float **)malloc(sizeof(float *)*N);
    F = (float **)malloc(sizeof(float *)*N);
    G = (float **)malloc(sizeof(float *)*N);
    for(i=0;i<N;i++){
        A[i] = (float *)malloc(sizeof(float) * N);
        B[i] = (float *)malloc(sizeof(float) * N);
        C[i] = (float *)malloc(sizeof(float) * N);
        D[i] = (float *)malloc(sizeof(float) * N);
        E[i] = (float *)malloc(sizeof(float) * N);
        F[i] = (float *)malloc(sizeof(float) * N);
        G[i] = (float *)malloc(sizeof(float) * N);
    }
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            A[i][j] = (float)(random())/RAND_MAX;
            B[i][j] = (float)(random())/RAND_MAX;
            C[i][j] = 0.0;
            D[i][j] = (float)(random())/RAND_MAX;
            E[i][j] = (float)(random())/RAND_MAX;
            F[i][j] = 0.0;
            G[i][j] = 0.0;
        }
    }
}

int main(int argc,char **argv){
    double itime,ftime;
    init();
    itime = omp_get_wtime();
    #pragma omp parallel shared(A,B,C,D,E,F,G)
    {
        int i,j,k;
        #pragma omp for private(i,j,k)
        for(i=0;i<N;i++){
            for(j=0;j<N;j++){
                for(k=0;k<N;k++){
                    C[i][j] += A[i][k] * B[k][j];
                    F[i][j] += D[i][k] * E[k][j];
                }
            }
            WAITALL(1)
            for(j=0;j<N;j++){
                for(k=0;k<N;k++){
                    G[i][j] += C[i][k] * F[k][j];
                }
            }
        }
    }
    ftime = omp_get_wtime();
    fprintf(stdout,"Run time = %lf seconds\n",(ftime - itime));
    return 0;
}
