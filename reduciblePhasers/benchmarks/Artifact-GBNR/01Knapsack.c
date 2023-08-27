#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "../../../src/utility/static-opt/header.h"
#define    MAX(x,y)   ((x)>(y) ? (x) : (y))
int  N, C;                   // # of objects, capacity 
int  *weights, *profits;     // weights and profits
int *newProfit, *oldProfit, *temp;
void knapSack(int,int);
int main(int argc, char **argv) {
	FILE   *fp;
	int    verbose,count;
	int    k, j, size;
	double time;
	// Read input file (# of objects, capacity, (per line) weight and profit )
	if ( argc > 1 ) {
		fp = fopen(argv[1], "r"); 
		if ( fp == NULL) {
			printf("[ERROR] : Failed to read file named '%s'.\n", argv[1]);
			exit(1);
		}
	} else {
		printf("USAGE : %s [filename].\n", argv[0]);
		exit(1);
	}
	if (argc > 2) verbose = atoi(argv[2]); else verbose = 0;
	fscanf(fp, "%d %d", &N, &C);
	printf("The number of objects is %d, and the capacity is %d.\n", N, C);
	size    = N * sizeof(int);
	weights = (int *)malloc(size);
	profits = (int *)malloc(size);
	temp = (int *)malloc(size);
	if ( weights == NULL || profits == NULL ) {
		printf("[ERROR] : Failed to allocate memory for weights/profits.\n");
		exit(1);
	}
	for ( k=0 ; k < N ; k++ ) {
		count = fscanf(fp, "%d %d", &(weights[k]), &(profits[k]));
		if ( count != 2 ) {
			printf("[ERROR] : Input file is not well formatted.\n");
			exit(1);
		}
	}
	fclose(fp);
	// Solve for the optimal profit
	size = (C+1) * sizeof(int);
	newProfit = malloc(size);
	oldProfit = malloc(size);
	for (j=0; j<=C; j++) {
		if (j<weights[0])
			oldProfit[j]= 0;
		else
			oldProfit[j] = profits[0];
	}
    double itime,ftime;
    itime = omp_get_wtime();
#pragma omp parallel
	{
		int i;
#pragma omp for
		for (i=0; i<=C; i++) {
			knapSack(0, i);
		}
	}
    ftime = omp_get_wtime();
    fprintf(stdout,"Run time = ");
    fprintf(stdout,"%lf seconds.\n",(ftime-itime));
	return 0;
}
void knapSack(int i, int k){
	if(i < N){
        if(k == 0)
            newProfit[k] = 0;
        if(k < weights[i])
            newProfit[k] = oldProfit[k];
        else
            newProfit[k] = MAX(oldProfit[k], profits[i] + oldProfit[k-weights[i]]);
        WAITALL(1)
		temp = newProfit; newProfit = oldProfit; oldProfit = temp;
        knapSack(i+1, k);
    }
}
