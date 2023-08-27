#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <omp.h>
#include "header.h"
#include "uwomp-barrier.h" 
void OmpRegBody1_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void OmpRegBody1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void parallel_for_body1(int i,int j,int k);
void OmpRegBody1();
float **A;
float **B;
float **C;
float **D;
float **E;
float **F;
float **G;

void getruntime(struct timeval tv1,struct timeval tv2)
{
  time_t sec1;
  time_t sec2;
  suseconds_t usec1;
  suseconds_t usec2;
  sec1 = tv1 . tv_sec;
  sec2 = tv2 . tv_sec;
  usec1 = tv1 . tv_usec;
  usec2 = tv2 . tv_usec;
  double start_time = ((double )sec1) + usec1 / 1000000.0;
  double end_time = ((double )sec2) + usec2 / 1000000.0;
  fprintf(stdout,"%f\n",end_time - start_time);
}

void init()
{
  int i;
  int j;
  srandom(1000);
  A = ((float **)(malloc(sizeof(float *) * 512)));
  B = ((float **)(malloc(sizeof(float *) * 512)));
  C = ((float **)(malloc(sizeof(float *) * 512)));
  D = ((float **)(malloc(sizeof(float *) * 512)));
  E = ((float **)(malloc(sizeof(float *) * 512)));
  F = ((float **)(malloc(sizeof(float *) * 512)));
  G = ((float **)(malloc(sizeof(float *) * 512)));
  for (i = 0; i < 512; i++) {
    A[i] = ((float *)(malloc(sizeof(float ) * 512)));
    B[i] = ((float *)(malloc(sizeof(float ) * 512)));
    C[i] = ((float *)(malloc(sizeof(float ) * 512)));
    D[i] = ((float *)(malloc(sizeof(float ) * 512)));
    E[i] = ((float *)(malloc(sizeof(float ) * 512)));
    F[i] = ((float *)(malloc(sizeof(float ) * 512)));
    G[i] = ((float *)(malloc(sizeof(float ) * 512)));
  }
  for (i = 0; i < 512; i++) 
    for (j = 0; j < 512; j++) {
      A[i][j] = ((float )(random())) / 2147483647;
      B[i][j] = ((float )(random())) / 2147483647;
      C[i][j] = 0.0;
      D[i][j] = ((float )(random())) / 2147483647;
      E[i][j] = ((float )(random())) / 2147483647;
      F[i][j] = 0.0;
      G[i][j] = 0.0;
    }
}

void printMatrix(float **M)
{
  int i;
  int j;
  for (i = 0; i < 512; i++) 
    for (j = 0; j < 512; j++) 
      fprintf(stderr,"%f ",M[i][j]);
  fprintf(stderr,"\n");
  return ;
}

int main(int argc,char **argv)
{
  struct timeval tv1;
  struct timeval tv2;
  init();
  gettimeofday(&tv1,((void *)0));
#pragma omp parallel  shared(A,B,C,D,E,F,G)
{
    struct __cont_env *init_contn_env = malloc(sizeof(struct __cont_env ));
    init_contn_env -> cont_fn = uwomp_first_fun;
#pragma omp single 
{
      uwomp_worklist_init((omp_get_num_threads()),32557);
    }
    void **__parreg_arglist;
    __parreg_arglist = ((void **)(malloc(3 * sizeof(void *))));
    OmpRegBody1_cps(__parreg_arglist,NULL,0,NULL);
    uwomp_free_worklist_free();
  }
  gettimeofday(&tv2,((void *)0));
  fprintf(stdout,"Run time = ");
  getruntime(tv1,tv2);
//  fprintf(stderr, "Parallel Outuput:\n");
//  printMatrix(G);
  return 0;
}
void ***arg_list_OmpRegBody1_0;

void OmpRegBody1()
{
}
void ***arg_list_parallel_for_body1_0;

void parallel_for_body1(int i,int j,int k)
{
}

void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int i = (int )arg_list[0];
  int j = (int )arg_list[1];
  int k = (int )arg_list[2];
  for (j = 0; j < 512; j++) {
    for (k = 0; k < 512; k++) {
      C[i][j] += A[i][k] * B[k][j];
      F[i][j] += D[i][k] * E[k][j];
    }
  }
  struct __cont_env *parallel_for_body1_cps_cont_env1;
  if (old_env != NULL) {
    parallel_for_body1_cps_cont_env1 = old_env;
    old_env = NULL;
    parallel_for_body1_cps_cont_env1 -> cont_fn = parallel_for_body1_cps_cont1;
  }
   else {
    parallel_for_body1_cps_cont_env1 = malloc(sizeof(struct __cont_env ));
    parallel_for_body1_cps_cont_env1 -> arg_list = arg_list;
    parallel_for_body1_cps_cont_env1 -> contn_env = contn_env;
    parallel_for_body1_cps_cont_env1 -> cont_fn = parallel_for_body1_cps_cont1;
  }
  arg_list[1] = j;
  arg_list[2] = k;
  uwomp_barrier(parallel_for_body1_cps_cont_env1,phase_num);
}

void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int i = (int )arg_list[0];
  int j = (int )arg_list[1];
  int k = (int )arg_list[2];
  for (j = 0; j < 512; j++) {
    for (k = 0; k < 512; k++) {
      G[i][j] += C[i][k] * F[k][j];
    }
  }
  if (old_env != NULL) {
    free(old_env);
  }
  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
  if (contn_env == NULL) {
    uwomp_execute_ready_worklist((omp_get_thread_num()));
  }
}

void OmpRegBody1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int i;
  int j;
  int k;
#pragma omp single 
{
    arg_list_parallel_for_body1_0 = calloc(512 - 0,sizeof(void **));
    arg_list_OmpRegBody1_0 = calloc(512 - 0,sizeof(void **));
  }
  
#pragma omp for  private(i,j,k)
  for (i = 0; i < 512; i++) {
    if (arg_list_parallel_for_body1_0[i] == NULL) {
      arg_list_parallel_for_body1_0[i] = malloc(3 * sizeof(void *));
    }
    arg_list_parallel_for_body1_0[i][0] = i;
    arg_list_parallel_for_body1_0[i][1] = j;
    arg_list_parallel_for_body1_0[i][2] = k;
    struct __cont_env *OmpRegBody1_cps_cps_cont_env_1_1 = malloc(sizeof(struct __cont_env ));
    OmpRegBody1_cps_cps_cont_env_1_1 -> arg_list = arg_list_parallel_for_body1_0[i];
    OmpRegBody1_cps_cps_cont_env_1_1 -> contn_env = contn_env;
    OmpRegBody1_cps_cps_cont_env_1_1 -> cont_fn = parallel_for_body1_cps;
    uwomp_add_to_local_pending_worklist(OmpRegBody1_cps_cps_cont_env_1_1,0);
  }
  uwomp_execute_worklist();
}

void OmpRegBody1_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  if (old_env != NULL) {
    free(old_env);
  }
  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
  if (contn_env == NULL) {
    uwomp_execute_ready_worklist((omp_get_thread_num()));
  }
}
