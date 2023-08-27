#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <math.h>
#include "../../../src/utility/static-opt/header.h"
#define N 4096
#define EPSILON 0.006

double *newA, *oldA, *diff, *temp;
double epsilon,delta;
int iters;

int main(){
    int j,k;
    double itime,ftime;
    srand48(101);
    oldA = (double *)calloc(sizeof(double) , (N + 2));
    newA = (double *)calloc(sizeof(double) , (N + 2));
    diff = (double *)calloc(sizeof(double) , (N + 2));
    fprintf(stdout,"======Iterated Averaging======\n");
    oldA[0] = 0;
    for(j=1;j<=N;j++){
        oldA[j] = drand48();
    }
    oldA[N+1] = 0;
    epsilon = EPSILON;
    delta = epsilon;
    itime = omp_get_wtime();
    #pragma omp parallel
    {
        int i;
        #pragma omp for private(i)
        for(i=1;i<=N;i++)
        {
            while(epsilon <= delta){
                newA[i] = (oldA[i-1] + oldA[i+1]) / 2.0;
                if(newA[i] > oldA[i]){
                    diff[i] = newA[i] - oldA[i];
                }else{
                    diff[i] = oldA[i] - newA[i];
                }
                WAITALL(1)
                if(i==1){
                    for(k=1;k<=N;k++){
                        delta+=diff[k];
                    }
                    delta = delta/N;
                    iters++;
                    temp = newA;newA=oldA;oldA = temp;
                }
                WAITALL(1)
            }
        }
    }
    ftime = omp_get_wtime();
    fprintf(stdout,"Benchmark Completed Successfully.\n");
    fprintf(stdout,"Runtime = ");
    fprintf(stdout,"%lf seconds\n",(ftime - itime));
    fprintf(stdout,"%d iterations\n",iters);
    return 0;
}
