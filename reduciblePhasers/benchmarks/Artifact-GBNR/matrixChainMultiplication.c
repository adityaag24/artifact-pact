#include<stdio.h>
#include<stdlib.h>
#include<omp.h>
#include<limits.h>
#include "../../../src/utility/static-opt/header.h"
int N;
int *P;
int **M;
void matrix_paranth_for_len(int i, int l)
{
	if(l <= N){
		int j,k,v;
		if(i <= N-l+1)
		{
			j = i+l-1;
			M[i][j] = INT_MAX;
			for(k=i; k<j; k++)
			{
					v = M[i][k] +M[k+1][j] + P[i-1]*P[k]*P[j];
					if(v<M[i][j])
						M[i][j] = v;
			}
		}
		WAITALL(1)
		matrix_paranth_for_len(i, l+1);
	}
}

print_val()
{
	int i,j;
	for(i=0; i<=N; i++)
	{
		for(j=0; j<=N; j++)
		{
			printf("%d\t", M[i][j]);
		}
		printf("\n");
	}
}

int main(int argc, char **argv)
{
  	double itime,ftime,time;
	FILE   *fp;
	// Read input file (sequences in two lines)
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

	// Read number of matrices
	fscanf(fp, "%d", &N);

	int i;

	P = calloc(N+1, sizeof(int));
	for(i=0; i<=N; i++) {
		fscanf(fp, "%d", &P[i]);
	}

	M = (int **)calloc(N+1, sizeof(int *));
	for(i=0;i<=N; i++)
		M[i] = (int *)calloc(N+1, sizeof(int));
	for(i=0; i<=N; i++)
		M[i][i] = 0;

  itime = omp_get_wtime();
#pragma omp parallel
	{
		int i;
#pragma omp for
		for(i=1; i <= N; i++) {
			matrix_paranth_for_len(i,2);
		}
	}
	ftime = omp_get_wtime();
	time = ftime - itime;
	fprintf(stderr,"Run time = ");
	fprintf(stderr,"%lf seconds\n",time);

	return 0;
}
