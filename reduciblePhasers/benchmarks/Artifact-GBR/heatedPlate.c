#include <stdlib.h>
#include <stdio.h>
#include <omp.h>
#include "../../../src/utility/static-opt/header.h"
#define M 2048
#define N 2048
double mean,diff;
float epsilon;
int iterations,iterations_print;
double **u,**w,**temp;
double *delta;
void init(){
  int i,j;
  u = (double **)calloc(M,sizeof(double *));
  w = (double **)calloc(N,sizeof(double *));
  delta = (double *)calloc(M,sizeof(double));
  for(i=0;i<M;i++){
    u[i] = (double *)calloc(N,sizeof(double));
    w[i] = (double *)calloc(N,sizeof(double));
  }
  for ( i = 1; i < M - 1; i++ ){
    w[i][0] = 100.0;
    w[i][N-1] = 100.0;
    u[i][j] = 100.0;
    u[i][N-1] = 100.0;
  }
  for ( j = 0; j < N; j++ ){
    w[M-1][j] = 100.0;
    w[0][j] = 0.0;
    u[M-1][j] = 100.0;
    u[0][N-1] = 100.0;
  }
  mean = 0.0;
  for ( i = 1; i < M - 1; i++ ){
    mean = mean + w[i][0] + w[i][N-1];
  }
  for ( j = 0; j < N; j++ ){
    mean = mean + w[M-1][j] + w[0][j];
  }
  mean = mean / ( double ) ( 2 * M + 2 * N - 4 );
  for ( i = 1; i < M - 1; i++ ){
    for ( j = 1; j < N - 1; j++ ){
      w[i][j] = mean;
      u[i][j] = mean;
    }
  }
  iterations = 0;
  iterations_print = 1;
}
int main ( int argc, char *argv[] ){
  FILE *fp;
  int i;
  int j,k;
  char output_file[80];
  int success;
  double diff;
  if ( argc < 2 ) {
    printf ( "\n" );
    printf ( "  Enter EPSILON, the error tolerance:\n" );
    success = scanf ( "%f", &epsilon );
  }else{
    success = sscanf ( argv[1], "%f", &epsilon );
  }
  if ( success != 1 ){
    printf ( "\n" );
    printf ( "HEATED_PLATE\n" );
    printf ( "  Error reading in the value of EPSILON.\n");
    return 1;
  }
  diff = epsilon;
  init();
  printf("%lf %lf\n",epsilon,diff);
  double itime,ftime,rtime;
  itime = omp_get_wtime ( );
# pragma omp parallel private ( i, j ) shared ( u, w )
  {
    #pragma omp for
    for (i=1;i<M-1; i++)
    {
        while ( epsilon <= diff  ){
          delta[i] = 0.0;
          for(j=1;j<N-1;j++){
            w[i][j] = (u[i-1][j] + u[i+1][j] + u[i][j-1] + u[i][j+1]) / 4.0;
            if(w[i][j] > u[i][j]){
              delta[i] = delta[i] + (w[i][j] - u[i][j]);
            }else{
              delta[i] = delta[i] + (u[i][j] - w[i][j]);
            }
          }
          WAITALL(1)
          if(i == 1){
            for(k=1;k<M-1;k++){
              diff+=delta[k];
            }
            diff = diff / (double) (M-1) / (double) (N-1);
            // printf("Diff=%f\n",diff);
            iterations++;
            temp = u;
            u = w;
            w = temp;
          }
          WAITALL(1)
      }
  }
}
ftime = omp_get_wtime ( );
rtime = ftime - itime;
fprintf(stdout,"Benchmark Completed Successfully.\n");
fprintf(stdout,"Runtime = ");
fprintf(stdout,"%lf seconds\n",rtime);
fprintf(stdout,"%d iterations\n",iterations);
return 0;
}
