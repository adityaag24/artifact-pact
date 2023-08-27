#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "header.h"
#include <math.h>
#include "uwomp-clock.h" 
void parallel_for_body1__while__0_cps_cont6(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1__while__0_cps_cont5(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1__while__0_cps_cont4(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1__while__0_cps_cont3(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1__while__0_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void sum_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void ompRegBody_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void ompRegBody_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks);
void parallel_for_body1__while__0(int *p_i,int **p_iters);
void parallel_for_body1(int i,int *iters,int __from_par_reg);
double *newA;
double *oldA;
double *diff;
double *temp;
double epsilon;
double delta;

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
  fprintf(stderr,"%f\n",end_time - start_time);
}

double sum(double *d,double *delta,int __from_par_reg)
{
}

void ompRegBody(int *iters,int __from_par_reg)
{
}

int main()
{
  int j;
  struct timeval tv1;
  struct timeval tv2;
// initialize the prng with a fixed seed.
  srand48(101);
  oldA = ((double *)(malloc(sizeof(double ) * (500 + 2))));
  newA = ((double *)(malloc(sizeof(double ) * (500 + 2))));
  diff = ((double *)(malloc(sizeof(double ) * (500 + 2))));
//fprintf(stderr, "VAL = %f\n", VAL);
  oldA[0] = 20e-4 / (500 + 1);
  for (j = 1; j <= 500; j++) {
    oldA[j] = drand48();
//fprintf (stderr, "a[j] %.2lf", oldA[j]);
  }
  oldA[500 + 1] = 20e-4 / (500 + 1);
  epsilon = 20e-4;
  delta = epsilon + 1;
  int iters = 0;
  gettimeofday(&tv1,((void *)0));
#pragma omp parallel 
{
    struct __cont_env *init_contn_env = malloc(sizeof(struct __cont_env ));
    init_contn_env -> cont_fn = uwomp_first_fun;
#pragma omp single 
{
      uwomp_worklist_init((omp_get_num_threads()),4);
    }
    void **__parreg_arglist;
    __parreg_arglist = ((void **)(malloc(2 * sizeof(void *))));
    __parreg_arglist[0] = &iters;
    __parreg_arglist[1] = 1;
    //ompRegBody_cps(__parreg_arglist,init_contn_env,0,0,NULL);
    ompRegBody_cps(__parreg_arglist,NULL,0,0,NULL);
  }
  fprintf(stderr,"#iterations = %d\n",iters);
  gettimeofday(&tv2,((void *)0));
  fprintf(stderr,"Run time = ");
  getruntime(tv1,tv2);
  return 0;
}

void parallel_for_body1(int i,int *iters,int __from_par_reg)
{
}

void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  int i = (int )arg_list[0];
  int *iters = (int *)arg_list[1];
  int __from_par_reg = (int )arg_list[2];
  free(arg_list);
  struct __cont_env *parallel_for_body1_cps_cont_env1 = malloc(sizeof(struct __cont_env ));
  parallel_for_body1_cps_cont_env1 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
  parallel_for_body1_cps_cont_env1 -> contn_env = contn_env;
  parallel_for_body1_cps_cont_env1 -> cont_fn = parallel_for_body1_cps_cont1;
  parallel_for_body1_cps_cont_env1 -> task_id = task_id;
  parallel_for_body1_cps_cont_env1 -> uwomp_task_to_clocks_map = task_to_clks;
  void **arg_list_1;
  arg_list_1 = ((void **)(malloc(3 * sizeof(void *))));
  arg_list_1[0] = &i;
  arg_list_1[1] = &iters;
  arg_list_1[2] = __from_par_reg;
  parallel_for_body1__while__0_cps(arg_list_1,parallel_for_body1_cps_cont_env1,phase_num,task_id,task_to_clks);
}

void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  free(arg_list);
  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
   else {
    uwomp_execute_global_worklist(MAX_ENTRIES_IN_READY_LIST);
  }
}

void ompRegBody_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  int *iters = (int *)arg_list[0];
  int __from_par_reg = (int )arg_list[1];
  free(arg_list);
  int i;
  uwomp_clock *__c;
  uwomp_clock_list_entry **uwomp_task_to_clocks_map;
  if (__from_par_reg) {
#pragma omp single  copyprivate(__c,uwomp_task_to_clocks_map)
{
      int __num_tasks = 500;
      uwomp_task_to_clocks_map_init(__num_tasks,&uwomp_task_to_clocks_map);
      __c = uwomp_get_clock();
    }
  }
  if (!__from_par_reg) {
    int __num_tasks = 500;
    uwomp_task_to_clocks_map_init(__num_tasks,&uwomp_task_to_clocks_map);
    __c = uwomp_get_clock();
  }
  if (__from_par_reg) {
    
#pragma omp for  private(i)
    for (i = 1; i <= 500; i++) {
      uwomp_clock_register(i,__c,uwomp_task_to_clocks_map);
    }
  }
  if (!__from_par_reg) {
    for (i = 1; i <= 500; i++) {
      uwomp_clock_register(i,__c,uwomp_task_to_clocks_map);
    }
  }
  if (__from_par_reg) {
    
#pragma omp for  private(i)
    for (i = 1; i <= 500; i++) {
      struct __cont_env *ompRegBody_cps_cont_env2 = malloc(sizeof(struct __cont_env ));
      ompRegBody_cps_cont_env2 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
      ompRegBody_cps_cont_env2 -> contn_env = contn_env;
      ompRegBody_cps_cont_env2 -> cont_fn = ompRegBody_cps_cont2;
      ompRegBody_cps_cont_env2 -> task_id = task_id;
      ompRegBody_cps_cont_env2 -> uwomp_task_to_clocks_map = task_to_clks;
      void **arg_list_2;
      arg_list_2 = ((void **)(malloc(3 * sizeof(void *))));
      arg_list_2[0] = i;
      arg_list_2[1] = iters;
      arg_list_2[2] = 0;
      struct __cont_env *ompRegBody_cps_cps_cont_env_1_1 = malloc(sizeof(struct __cont_env ));
      ompRegBody_cps_cps_cont_env_1_1 -> arg_list = arg_list_2;
      ompRegBody_cps_cps_cont_env_1_1 -> contn_env = ompRegBody_cps_cont_env2;
      ompRegBody_cps_cps_cont_env_1_1 -> cont_fn = parallel_for_body1_cps;
      ompRegBody_cps_cps_cont_env_1_1 -> task_id = i;
      ompRegBody_cps_cps_cont_env_1_1 -> uwomp_task_to_clocks_map = uwomp_task_to_clocks_map;
      if (i != 0) {
        ompRegBody_cps_cont_env2 -> contn_env = NULL;
      }
      uwomp_add_to_local_pending_worklist(ompRegBody_cps_cps_cont_env_1_1,0);
    }
  }
  if (!__from_par_reg) {
    for (i = 1; i <= 500; i++) {
      struct __cont_env *ompRegBody_cps_cont_env2 = malloc(sizeof(struct __cont_env ));
      ompRegBody_cps_cont_env2 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
      ompRegBody_cps_cont_env2 -> contn_env = contn_env;
      ompRegBody_cps_cont_env2 -> cont_fn = ompRegBody_cps_cont2;
      ompRegBody_cps_cont_env2 -> task_id = task_id;
      ompRegBody_cps_cont_env2 -> uwomp_task_to_clocks_map = task_to_clks;
      void **arg_list_2;
      arg_list_2 = ((void **)(malloc(3 * sizeof(void *))));
      arg_list_2[0] = i;
      arg_list_2[1] = iters;
      arg_list_2[2] = 0;
      struct __cont_env *ompRegBody_cps_cps_cont_env_1_1 = malloc(sizeof(struct __cont_env ));
      ompRegBody_cps_cps_cont_env_1_1 -> arg_list = arg_list_2;
      ompRegBody_cps_cps_cont_env_1_1 -> contn_env = ompRegBody_cps_cont_env2;
      ompRegBody_cps_cps_cont_env_1_1 -> cont_fn = parallel_for_body1_cps;
      ompRegBody_cps_cps_cont_env_1_1 -> task_id = i;
      ompRegBody_cps_cps_cont_env_1_1 -> uwomp_task_to_clocks_map = uwomp_task_to_clocks_map;
      if (i != 0) {
        ompRegBody_cps_cont_env2 -> contn_env = NULL;
      }
      uwomp_add_to_local_pending_worklist(ompRegBody_cps_cps_cont_env_1_1,0);
    }
  }
  uwomp_execute_global_worklist(MAX_ENTRIES_IN_READY_LIST);
}

void ompRegBody_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  free(arg_list);
  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
   else {
    uwomp_execute_global_worklist(MAX_ENTRIES_IN_READY_LIST);
  }
}

void sum_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  double *d = (double *)arg_list[0];
  double *delta = (double *)arg_list[1];
  int __from_par_reg = (int )arg_list[2];
  free(arg_list);
  double res = 0.0;
  int i;
  for (i = 1; i <= 500; i++) 
    res += d[i];
   *delta = res;
  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
   else {
    uwomp_execute_global_worklist(MAX_ENTRIES_IN_READY_LIST);
  }
}

void parallel_for_body1__while__0_cps(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  int *p_i = (int *)arg_list[0];
  int **p_iters = (int **)arg_list[1];
  int __from_par_reg = (int )arg_list[2];
  free(arg_list);
  int __if_v0;
  int *iters =  *p_iters;
  int i =  *p_i;
  if (!(delta > epsilon)) {
    if (contn_env != NULL) {
      uwomp_call_contn_fun(contn_env);
    }
     else {
      uwomp_execute_global_worklist(MAX_ENTRIES_IN_READY_LIST);
    }
    return ;
  }
  newA[i] = (oldA[i - 1] + oldA[i + 1]) / 2.0;
  diff[i] = fabs(newA[i] - oldA[i]);
  struct __cont_env *parallel_for_body1__while__0_cps_cont_env3 = malloc(sizeof(struct __cont_env ));
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list = ((void **)(malloc(6 * sizeof(void *))));
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[0] = __from_par_reg;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[1] = __if_v0;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[2] = i;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[3] = iters;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[4] = p_i;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[5] = p_iters;
  parallel_for_body1__while__0_cps_cont_env3 -> contn_env = contn_env;
  parallel_for_body1__while__0_cps_cont_env3 -> cont_fn = parallel_for_body1__while__0_cps_cont3;
  parallel_for_body1__while__0_cps_cont_env3 -> task_id = task_id;
  parallel_for_body1__while__0_cps_cont_env3 -> uwomp_task_to_clocks_map = task_to_clks;
  uwomp_clock_advance_all_global_worklist(parallel_for_body1__while__0_cps_cont_env3,phase_num,task_id,task_to_clks);
}

void parallel_for_body1__while__0_cps_cont3(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  int __from_par_reg = (int )arg_list[0];
  int __if_v0 = (int )arg_list[1];
  int i = (int )arg_list[2];
  int *iters = (int *)arg_list[3];
  int *p_i = (int *)arg_list[4];
  int **p_iters = (int **)arg_list[5];
  free(arg_list);
  __if_v0 = i == 1;
  if (__if_v0) {
    struct __cont_env *parallel_for_body1__while__0_cps_cont_env4 = malloc(sizeof(struct __cont_env ));
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list = ((void **)(malloc(6 * sizeof(void *))));
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[0] = __from_par_reg;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[1] = __if_v0;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[2] = i;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[3] = iters;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[4] = p_i;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[5] = p_iters;
    parallel_for_body1__while__0_cps_cont_env4 -> contn_env = contn_env;
    parallel_for_body1__while__0_cps_cont_env4 -> cont_fn = parallel_for_body1__while__0_cps_cont4;
    parallel_for_body1__while__0_cps_cont_env4 -> task_id = task_id;
    parallel_for_body1__while__0_cps_cont_env4 -> uwomp_task_to_clocks_map = task_to_clks;
    void **arg_list_3;
    arg_list_3 = ((void **)(malloc(3 * sizeof(void *))));
    arg_list_3[0] = diff;
    arg_list_3[1] = &delta;
    arg_list_3[2] = __from_par_reg;
    sum_cps(arg_list_3,parallel_for_body1__while__0_cps_cont_env4,phase_num,task_id,task_to_clks);
  }
   else {
    struct __cont_env *parallel_for_body1__while__0_cps_cont_env4 = malloc(sizeof(struct __cont_env ));
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list = ((void **)(malloc(6 * sizeof(void *))));
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[0] = __from_par_reg;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[1] = __if_v0;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[2] = i;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[3] = iters;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[4] = p_i;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[5] = p_iters;
    parallel_for_body1__while__0_cps_cont_env4 -> contn_env = contn_env;
    parallel_for_body1__while__0_cps_cont_env4 -> cont_fn = parallel_for_body1__while__0_cps_cont4;
    parallel_for_body1__while__0_cps_cont_env4 -> task_id = task_id;
    parallel_for_body1__while__0_cps_cont_env4 -> uwomp_task_to_clocks_map = task_to_clks;
    uwomp_call_contn_fun(parallel_for_body1__while__0_cps_cont_env4);
  }
}

void parallel_for_body1__while__0_cps_cont4(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  int __from_par_reg = (int )arg_list[0];
  int __if_v0 = (int )arg_list[1];
  int i = (int )arg_list[2];
  int *iters = (int *)arg_list[3];
  int *p_i = (int *)arg_list[4];
  int **p_iters = (int **)arg_list[5];
  free(arg_list);
  if (__if_v0) {
    ( *iters)++;
    temp = newA;
    newA = oldA;
    oldA = temp;
  }
  struct __cont_env *parallel_for_body1__while__0_cps_cont_env5 = malloc(sizeof(struct __cont_env ));
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list = ((void **)(malloc(5 * sizeof(void *))));
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[0] = __from_par_reg;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[1] = i;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[2] = iters;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[3] = p_i;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[4] = p_iters;
  parallel_for_body1__while__0_cps_cont_env5 -> contn_env = contn_env;
  parallel_for_body1__while__0_cps_cont_env5 -> cont_fn = parallel_for_body1__while__0_cps_cont5;
  parallel_for_body1__while__0_cps_cont_env5 -> task_id = task_id;
  parallel_for_body1__while__0_cps_cont_env5 -> uwomp_task_to_clocks_map = task_to_clks;
  uwomp_clock_advance_all_global_worklist(parallel_for_body1__while__0_cps_cont_env5,phase_num,task_id,task_to_clks);
}

void parallel_for_body1__while__0_cps_cont5(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  int __from_par_reg = (int )arg_list[0];
  int i = (int )arg_list[1];
  int *iters = (int *)arg_list[2];
  int *p_i = (int *)arg_list[3];
  int **p_iters = (int **)arg_list[4];
  free(arg_list);
   *p_i = i;
   *p_iters = iters;
  struct __cont_env *parallel_for_body1__while__0_cps_cont_env6 = malloc(sizeof(struct __cont_env ));
  parallel_for_body1__while__0_cps_cont_env6 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
  parallel_for_body1__while__0_cps_cont_env6 -> contn_env = contn_env;
  parallel_for_body1__while__0_cps_cont_env6 -> cont_fn = parallel_for_body1__while__0_cps_cont6;
  parallel_for_body1__while__0_cps_cont_env6 -> task_id = task_id;
  parallel_for_body1__while__0_cps_cont_env6 -> uwomp_task_to_clocks_map = task_to_clks;
  void **arg_list_4;
  arg_list_4 = ((void **)(malloc(3 * sizeof(void *))));
  arg_list_4[0] = p_i;
  arg_list_4[1] = p_iters;
  arg_list_4[2] = __from_par_reg;
  parallel_for_body1__while__0_cps(arg_list_4,parallel_for_body1__while__0_cps_cont_env6,phase_num,task_id,task_to_clks);
}

void parallel_for_body1__while__0_cps_cont6(void **arg_list,struct __cont_env *contn_env,int phase_num,int task_id,uwomp_clock_list_entry **task_to_clks)
{
  free(arg_list);
  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
   else {
    uwomp_execute_global_worklist(MAX_ENTRIES_IN_READY_LIST);
  }
}
