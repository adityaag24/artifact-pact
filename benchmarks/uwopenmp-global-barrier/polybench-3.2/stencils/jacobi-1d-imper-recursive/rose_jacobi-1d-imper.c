/**
 * jacobi-1d-imper.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
/* Include polybench common header. */
//#include <polybench.h>
#include "polybench.h"
/* Include benchmark-specific header. */
/* Default data type is double, default size is 100x10000. */
#include "jacobi-1d-imper.h"
#include "header.h"
#include "uwomp-barrier.h" 
void jacobi_1d_imper_cps_cont5(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void jacobi_1d_imper_cps_cont4(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void jacobi_1d_imper_cps_cont3(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void jacobi_1d_imper_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void OmpRegBody1_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void OmpRegBody1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env);
void parallel_for_body1(int i,int *tsteps);
void OmpRegBody1(int *n,int *tsteps);
double *A;
double *B;
int t = 0;
/* Array initialization. */
//static void init_array (int n, DATA_TYPE POLYBENCH_1D(A,N,n), DATA_TYPE POLYBENCH_1D(B,N,n))

static void init_array(int n)
{
  int i;
  for (i = 0; i < n; i++) {
    A[i] = (((double )i) + 2) / n;
    B[i] = (((double )i) + 3) / n;
  }
}
/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */

static void print_array(int n,double A[10000 + 0])
{
  int i;
  for (i = 0; i < n; i++) {
    fprintf(stderr,"%0.2lf ",A[i]);
    if (i % 20 == 0) 
      fprintf(stderr,"\n");
  }
  fprintf(stderr,"\n");
}
void ***arg_list_jacobi_1d_imper_0;

void jacobi_1d_imper(int i,int tsteps)
{
}
/* Main computational kernel. The whole function will be timed,
   including the call and return. */
//static void kernel_jacobi_1d_imper(int tsteps, int n, DATA_TYPE POLYBENCH_1D(A,N,n), DATA_TYPE POLYBENCH_1D(B,N,n)) {

static void kernel_jacobi_1d_imper(int tsteps,int n)
{
#pragma omp parallel 
{
    struct __cont_env *init_contn_env = malloc(sizeof(struct __cont_env ));
    init_contn_env -> cont_fn = uwomp_first_fun;
#pragma omp single 
{
      uwomp_worklist_init((omp_get_num_threads()),32764);
    }
    void **__parreg_arglist;
    __parreg_arglist = ((void **)(malloc(3 * sizeof(void *))));
    __parreg_arglist[1] = &n;
    __parreg_arglist[2] = &tsteps;
    OmpRegBody1_cps(__parreg_arglist,NULL,0,NULL);
    uwomp_free_worklist_free();
  }
}

int main(int argc,char **argv)
{
/* Retrieve problem size. */
//int n = N;
//int tsteps = TSTEPS;
  int n = 1048576;
  int tsteps = 8192;
/* Variable declaration/allocation. */
//POLYBENCH_1D_ARRAY_DECL(A, DATA_TYPE, N, n);
//POLYBENCH_1D_ARRAY_DECL(B, DATA_TYPE, N, n);
  A = (calloc(1048576,sizeof(double )));
  B = (calloc(1048576,sizeof(double )));
/* Initialize array(s). */
//init_array (n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(B));
  init_array(n);
/* Start timer. */
//polybench_start_instruments;
  polybench_timer_start();
  ;
/* Run kernel. */
//kernel_jacobi_1d_imper (tsteps, n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(B));
  kernel_jacobi_1d_imper(tsteps,n);
/* Stop and print timer. */
  polybench_timer_stop();
  ;
  fprintf(stdout,"Run time = ");
  polybench_timer_print();
  ;
//polybench_stop_instruments;
//polybench_print_instruments;
/* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
//print_array(n, POLYBENCH_ARRAY(A));
//polybench_prevent_dce(print_array(n, POLYBENCH_ARRAY(A)));
/* Be clean. */
  free(((void *)A));
  ;
  free(((void *)B));
  ;
  return 0;
}
void ***arg_list_OmpRegBody1_0;

void OmpRegBody1(int *n,int *tsteps)
{
}
void ***arg_list_parallel_for_body1_0;

void parallel_for_body1(int i,int *tsteps)
{
}

void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int i = (int )arg_list[0];
  int *tsteps = (int *)arg_list[1];
  arg_list[0] = i;
  arg_list[1] =  *tsteps;
  jacobi_1d_imper_cps(arg_list,contn_env,phase_num,old_env);
}

void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
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

void OmpRegBody1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int *n = (int *)arg_list[1];
  int *tsteps = (int *)arg_list[2];
  int i;
#pragma omp single 
{
    arg_list_parallel_for_body1_0 = calloc( *n - 1 - 1,sizeof(void **));
    arg_list_OmpRegBody1_0 = calloc( *n - 1 - 1,sizeof(void **));
    arg_list_jacobi_1d_imper_0 = calloc( *n - 1 - 1,sizeof(void **));
  }
  
#pragma omp for  private(i)
  for (i = 1; i <  *n - 1; i++) {
    if (arg_list_parallel_for_body1_0[i] == NULL) {
      arg_list_parallel_for_body1_0[i] = malloc(3 * sizeof(void *));
    }
    arg_list_parallel_for_body1_0[i][0] = i;
    arg_list_parallel_for_body1_0[i][1] = tsteps;
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

void jacobi_1d_imper_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int i = (int )arg_list[0];
  int tsteps = (int )arg_list[1];
  if (t >= tsteps) {
    if (old_env != NULL) {
      free(old_env);
    }
    if (contn_env != NULL) {
      uwomp_call_contn_fun(contn_env);
    }
    if (contn_env == NULL) {
      uwomp_execute_ready_worklist((omp_get_thread_num()));
    }
    return ;
  }
  B[i] = 0.33333 * (A[i - 1] + A[i] + A[i + 1]);
  struct __cont_env *jacobi_1d_imper_cps_cont_env3;
  if (old_env != NULL) {
    jacobi_1d_imper_cps_cont_env3 = old_env;
    old_env = NULL;
  }
   else {
    jacobi_1d_imper_cps_cont_env3 = malloc(sizeof(struct __cont_env ));
  }
  jacobi_1d_imper_cps_cont_env3 -> arg_list = arg_list;
  jacobi_1d_imper_cps_cont_env3 -> contn_env = contn_env;
  jacobi_1d_imper_cps_cont_env3 -> cont_fn = jacobi_1d_imper_cps_cont3;
  uwomp_barrier(jacobi_1d_imper_cps_cont_env3,phase_num);
}

void jacobi_1d_imper_cps_cont3(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  int i = (int )arg_list[0];
  A[i] = B[i];
  if (i == 1) 
    t++;
  struct __cont_env *jacobi_1d_imper_cps_cont_env4;
  if (old_env != NULL) {
    jacobi_1d_imper_cps_cont_env4 = old_env;
    old_env = NULL;
  }
   else {
    jacobi_1d_imper_cps_cont_env4 = malloc(sizeof(struct __cont_env ));
  }
  jacobi_1d_imper_cps_cont_env4 -> arg_list = arg_list;
  jacobi_1d_imper_cps_cont_env4 -> contn_env = contn_env;
  jacobi_1d_imper_cps_cont_env4 -> cont_fn = jacobi_1d_imper_cps_cont4;
  uwomp_barrier(jacobi_1d_imper_cps_cont_env4,phase_num);
}

void jacobi_1d_imper_cps_cont4(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
{
  arg_list[0] = i;
  arg_list[1] = tsteps;
  jacobi_1d_imper_cps(arg_list,contn_env,phase_num,old_env);
}

void jacobi_1d_imper_cps_cont5(void **arg_list,struct __cont_env *contn_env,int phase_num,struct __cont_env *old_env)
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
