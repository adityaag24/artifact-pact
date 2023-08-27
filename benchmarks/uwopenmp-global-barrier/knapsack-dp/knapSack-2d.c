
//
// File name   : knap.c
// Author      : DaeGon
// Modified by : Sanjay and Wim 
// Date        : Sep 20
// Description : Dynamic Programming for the 0/1 knapsack
//               problem.  The entire table is saved.
//

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "timer.h"


#define    MAX(x,y)   ((x)>(y) ? (x) : (y))
#define    table(i,j)    table[(i)*(C+1)+(j)]

int *table;
int    N, C;                   // # of objects, capacity 
int    *weights, *profits;     // weights and profits


void knapSack(int i, int k){
	if(i >= N)//0 to N-1 row index
		return;
	if( k==0 )
		table(i,k) = 0;
	if(k<weights[i])
		table(i,k) = table(i-1,k);  
	else
		table(i,k)=MAX(table(i-1,k),profits[i]+table(i-1,k-weights[i]));
#pragma omp barrier
	knapSack(i+1, k);

}


int main(int argc, char **argv) {

	FILE   *fp;
	int    verbose,count;

	// Temp variables
	int    i, j, size;

	// Time
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

	if ( weights == NULL || profits == NULL ) {
		printf("[ERROR] : Failed to allocate memory for weights/profits.\n");
		exit(1);
	}

	for ( i=0 ; i < N ; i++ ) {
		count = fscanf(fp, "%d %d", &(weights[i]), &(profits[i]));
		if ( count != 2 ) {
			printf("[ERROR] : Input file is not well formatted.\n");
			exit(1);
		}
	}

	fclose(fp);

	// Solve for the optimal profit
	size = (C+1) * sizeof(int);

	size  = (C+1) * N * sizeof(int);
	table = malloc(size);
	if ( table == NULL ) {
		printf("[ERROR] : Failed to allocate memory for the whole table.\n");
		exit(1);
	}


	for (j=0; j<=C; j++) {
		if (j<weights[0])
			table(0, j)= 0;
		else
			table(0, j)= profits[0];
	}

	initialize_timer ();
	start_timer();

#pragma omp parallel
	{
		int k;
#pragma omp for
		for (k=0; k<=C; k++) {
			knapSack(0, k);
		}
	}

	stop_timer();
	time = elapsed_time ();



	// End of "Solve for the optimal profit"

	// Backtracking
	int c=C;
	int solution[N];
	for ( i=N-1 ; i > 0 ; i-- ) {
		if ( c-weights[i] < 0 ) {
			//printf("i=%d: 0 \n",i);
			solution[i] = 0;
		} else {
			if ( table(i-1,c) > table(i-1,c-weights[i]) + profits[i] ) {

				//printf("i=%d: 0 \n",i);
				solution[i] = 0;
			} else {
				//printf("i=%d: 1 \n",i);
				solution[i] = 1;
				c = c - weights[i];
			}
		}
	} 
	//wim: first row does not look back
	if(c<weights[0]){
		//printf("i=0: 1 \n");
		solution[0]=0;
	} else {
		//printf("i=0: 0 \n");
		solution[0]=1;
	}

	printf("The optimal profit is %d \nTime taken : %lf.\n", table(N-1,C), time);


	if (verbose==1) {

		printf("Solution vector is: ");
		for (i=0 ; i<N ; i++ ) {
			printf("%d ", solution[i]);
		}
		printf("\n");
	}

	if (verbose==2) {
		for (j=1; j<=C; j++){
			printf ("%d\t", j);
			for (i=0; i<N; i++)
				printf ("%d ", table(i, j));
			printf("\n");
		}
	}

	return 0;
}
