#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include "header.h"
#include <math.h>
//#include "uwomp-barrier.h" 
#include "uwomp-barrier-new-worklist-design-with-global-free-list.h"


void parallel_for_body1__while__0_cps_cont6(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1__while__0_cps_cont5(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1__while__0_cps_cont4(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1__while__0_cps_cont3(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1__while__0_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void sum_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void ompRegBody_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void ompRegBody_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env);
void parallel_for_body1__while__0(int *p_i,int **p_iters);
void parallel_for_body1(int i,int *iters);
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

double sum(double *d,double *delta)
{
}

void ompRegBody(int *iters)
{
}

int main()
{
  int j;
  struct timeval tv1;
  struct timeval tv2;
// initialize the prng with a fixed seed.
  srand48(101);
  oldA = ((double *)(malloc(sizeof(double ) * (126 + 2))));
  newA = ((double *)(malloc(sizeof(double ) * (126 + 2))));
  diff = ((double *)(malloc(sizeof(double ) * (126 + 2))));
//fprintf(stderr, "VAL = %f\n", VAL);
  oldA[0] = 20e-4 / (126 + 1);
  for (j = 1; j <= 126; j++) {
    oldA[j] = drand48();
//fprintf (stderr, "a[j] %.2lf", oldA[j]);
  }
  oldA[126 + 1] = 20e-4 / (126 + 1);
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
          uwomp_worklist_init((omp_get_num_threads()),0);
      }
      void **__parreg_arglist;
      __parreg_arglist = ((void **)(malloc(1 * sizeof(void *))));
      __parreg_arglist[0] = &iters;
      //ompRegBody_cps(__parreg_arglist,init_contn_env,0);
      //ompRegBody_cps(__parreg_arglist,NULL,0);
      //TODO: Add the fourth argument
      ompRegBody_cps(__parreg_arglist,NULL,0, NULL);

      //uwomp_print_pending_worklist();
      //uwomp_print_ready_worklist();
      //fprintf(stderr, "tid = %d num_free_entries = %d\n", omp_get_thread_num(),
      //uwomp_get_num_free_entries(omp_get_thread_num()));
      // TODO: Free free list
      uwomp_free_worklist_free();
  }
  fprintf(stderr,"#iterations = %d\n",iters);
  gettimeofday(&tv2,((void *)0));
  fprintf(stderr,"Run time = ");
  getruntime(tv1,tv2);
  return 0;
}

void parallel_for_body1(int i,int *iters)
{
}

void parallel_for_body1__while__0(int *p_i,int **p_iters)
{
}

//TODO: Add the fourth argument.
void parallel_for_body1_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  //int i = (int )arg_list[0];
  //int *iters = (int *)arg_list[1];
  //free(arg_list);
	// TODO: Setting this continuation is not required since parallel_for_body1__while__0_cps
	//TODO: Reuse the memory allocated for previous environment
	//struct __cont_env *parallel_for_body1_cps_cont_env1;
	//if (old_env != NULL) {
	//	parallel_for_body1_cps_cont_env1 = old_env;
	//} else {
	//	parallel_for_body1_cps_cont_env1 = malloc(sizeof(struct __cont_env ));
	//}
	// is already a tail call. We can pass the incoming continuation evironment to this.
  //parallel_for_body1_cps_cont_env1 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
  //parallel_for_body1_cps_cont_env1 -> contn_env = contn_env;
  //parallel_for_body1_cps_cont_env1 -> cont_fn = parallel_for_body1_cps_cont1;
  //void **arg_list_1;
  //arg_list_1 = ((void **)(malloc(2 * sizeof(void *))));
  //arg_list_1[0] = &i;
  //arg_list_1[1] = &iters;
  //parallel_for_body1__while__0_cps(arg_list_1,parallel_for_body1_cps_cont_env1,phase_num);
	//TODO: 1. Pass the final argumetn as old_env.
	//      2. Change the second argument to contn_env
  parallel_for_body1__while__0_cps(arg_list,contn_env,phase_num, old_env);
}

//TODO: Generating this funciton is not required.
//void parallel_for_body1_cps_cont1(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
//{
//  free(arg_list);
//  if (contn_env != NULL) {
//    uwomp_call_contn_fun(contn_env);
//  }
//}

//TODO: Add the fourth argument.
void ompRegBody_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  int *iters = (int *)arg_list[0];
  free(arg_list);
  int i;
  
//#pragma omp for  private(i) schedule (dynamic)
#pragma omp for  private(i)
  for (i = 1; i <= 126; i++) {
		// TODO: If continuation of the pfloop is empty we need not create this continuation
    //struct __cont_env *ompRegBody_cps_cont_env2 = malloc(sizeof(struct __cont_env ));
    //ompRegBody_cps_cont_env2 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
    //ompRegBody_cps_cont_env2 -> contn_env = contn_env;
    //ompRegBody_cps_cont_env2 -> cont_fn = ompRegBody_cps_cont2;
    void **arg_list_2;
    arg_list_2 = ((void **)(malloc(2 * sizeof(void *))));
    arg_list_2[0] = i;
    arg_list_2[1] = iters;
    struct __cont_env *ompRegBody_cps_cps_cont_env_1_1 = malloc(sizeof(struct __cont_env ));
    ompRegBody_cps_cps_cont_env_1_1 -> arg_list = arg_list_2;
		// TODO: If continuation of the pfloop is empty we need not create this continuation.
		// we can copy the incoming continuation.
    //ompRegBody_cps_cps_cont_env_1_1 -> contn_env = ompRegBody_cps_cont_env2;
    ompRegBody_cps_cps_cont_env_1_1 -> contn_env = contn_env;
    ompRegBody_cps_cps_cont_env_1_1 -> cont_fn = parallel_for_body1_cps;
    uwomp_add_to_local_pending_worklist(ompRegBody_cps_cps_cont_env_1_1,0);
    //uwomp_add_to_local_ready_worklist(ompRegBody_cps_cps_cont_env_1_1,0);
  }

  //uwomp_print_pending_worklist();

  //uwomp_print_ready_worklist();
  uwomp_execute_worklist();
}

//TODO: Add the fourth argument.
void ompRegBody_cps_cont2(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  free(arg_list);

	// TODO: Here ware not going reuse old_env.
	if (old_env != NULL) {
		free (old_env);
	}

  if (contn_env != NULL) {
    uwomp_call_contn_fun(contn_env);
  }
}

//TODO: Add the fourth argument.
void sum_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  double *d = (double *)arg_list[0];
  double *delta = (double *)arg_list[1];
  free(arg_list);
  double res = 0.0;
  int i;
  for (i = 1; i <= 126; i++) 
    res += d[i];
   *delta = res;
	 // TODO: Here ware not going reuse old_env.
	 if (old_env != NULL) {
		 free (old_env);
	 }
	 if (contn_env != NULL) {
		 // TODO:
		 uwomp_call_contn_fun(contn_env);
	 }
}

//TODO: Add the fourth argument.
void parallel_for_body1__while__0_cps(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  int *p_i = (int *)arg_list[0];
  int **p_iters = (int **)arg_list[1];
  //free(arg_list);
  int __if_v0;
  int *iters =  *p_iters;
  int i =  *p_i;
	if (!(delta > epsilon)) {
		// TODO: Here ware not going reuse old_env.
		if (old_env != NULL) {
			free (old_env);
		}
		if (contn_env != NULL) {
      uwomp_call_contn_fun(contn_env);
    }
    // TODO: This is required to execute the the pending entries in the
    // ready worklist.
    // This should be addded everywhere where there is a return statatement.
     else {
          uwomp_execute_ready_worklist(omp_get_thread_num());
      }

  } else { //TODO:
  newA[i] = (oldA[i - 1] + oldA[i + 1]) / 2.0;
  diff[i] = fabs(newA[i] - oldA[i]);
	//TODO: Reuse the memory allocated for previous environment
	struct __cont_env *parallel_for_body1__while__0_cps_cont_env3; 
	if (old_env != NULL) {
		parallel_for_body1__while__0_cps_cont_env3 = old_env;
		old_env = NULL;
	}	else {
		parallel_for_body1__while__0_cps_cont_env3 = malloc(sizeof(struct __cont_env ));
	}
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list = ((void **)(realloc(arg_list, 5 * sizeof(void *))));
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[0] = __if_v0;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[1] = i;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[2] = iters;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[3] = p_i;
  parallel_for_body1__while__0_cps_cont_env3 -> arg_list[4] = p_iters;
  parallel_for_body1__while__0_cps_cont_env3 -> contn_env = contn_env;
  parallel_for_body1__while__0_cps_cont_env3 -> cont_fn = parallel_for_body1__while__0_cps_cont3;
  uwomp_barrier(parallel_for_body1__while__0_cps_cont_env3,phase_num);
  }
}

//TODO: Add the fourth argument.
void parallel_for_body1__while__0_cps_cont3(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
	/*
  int __if_v0 = (int )arg_list[0];
  int *iters = (int *)arg_list[2];
  int *p_i = (int *)arg_list[3];
  int **p_iters = (int **)arg_list[4];
  free(arg_list);
	*/
  int i = (int )arg_list[1];
  __if_v0 = i == 1;
  if (__if_v0) {
		//TODO: Reuse the memory allocated for previous environment
		struct __cont_env *parallel_for_body1__while__0_cps_cont_env4;
		if (old_env != NULL) {
			parallel_for_body1__while__0_cps_cont_env4 = old_env;
			old_env = NULL;
		}	else {
			parallel_for_body1__while__0_cps_cont_env4 = malloc(sizeof(struct __cont_env ));
		}
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list = arg_list;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[0] = __if_v0;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[1] = i;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[2] = iters;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[3] = p_i;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[4] = p_iters;
    parallel_for_body1__while__0_cps_cont_env4 -> contn_env = contn_env;
    parallel_for_body1__while__0_cps_cont_env4 -> cont_fn = parallel_for_body1__while__0_cps_cont4;
    void **arg_list_3;
    arg_list_3 = ((void **)(malloc(2 * sizeof(void *))));
    arg_list_3[0] = diff;
    arg_list_3[1] = &delta;
		// TODO:Add the final argument.
    //sum_cps(arg_list_3,parallel_for_body1__while__0_cps_cont_env4,phase_num);
    sum_cps(arg_list_3,parallel_for_body1__while__0_cps_cont_env4,phase_num, old_env);
  }
   else {
		 //TODO: Reuse the memory allocated for previous environment
		struct __cont_env *parallel_for_body1__while__0_cps_cont_env4;
		if (old_env != NULL) {
			parallel_for_body1__while__0_cps_cont_env4 = old_env;
			old_env = NULL;
		} else {
			parallel_for_body1__while__0_cps_cont_env4 = malloc(sizeof(struct __cont_env ));
		}
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list = arg_list;
    parallel_for_body1__while__0_cps_cont_env4 -> arg_list[0] = __if_v0;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[1] = i;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[2] = iters;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[3] = p_i;
    //parallel_for_body1__while__0_cps_cont_env4 -> arg_list[4] = p_iters;
    parallel_for_body1__while__0_cps_cont_env4 -> contn_env = contn_env;
    parallel_for_body1__while__0_cps_cont_env4 -> cont_fn = parallel_for_body1__while__0_cps_cont4;

		// TODO: Here ware not going reuse old_env.
		// TOTHINK: Right now it is not sure that we should free it here because
		// parallel_for_body1__while__0_cps_cont_env4  = old_env in this case.
		if (old_env != NULL) {
			free (old_env);
		}
    uwomp_call_contn_fun(parallel_for_body1__while__0_cps_cont_env4);
  }
}

//TODO: Add the fourth argument.
void parallel_for_body1__while__0_cps_cont4(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  int __if_v0 = (int )arg_list[0];
  int i = (int )arg_list[1];
  int *iters = (int *)arg_list[2];
  int *p_i = (int *)arg_list[3];
  int **p_iters = (int **)arg_list[4];
  //free(arg_list);
  if (__if_v0) {
    ( *iters)++;
    temp = newA;
    newA = oldA;
    oldA = temp;
  }
	//TODO: Reuse the memory allocated for previous environment
	struct __cont_env *parallel_for_body1__while__0_cps_cont_env5;
	if (old_env != NULL ) {
		parallel_for_body1__while__0_cps_cont_env5 = old_env;
		old_env = NULL;
	} else {
		parallel_for_body1__while__0_cps_cont_env5 = malloc(sizeof(struct __cont_env ));
	}
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list = arg_list;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[0] = i;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[1] = iters;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[2] = p_i;
  parallel_for_body1__while__0_cps_cont_env5 -> arg_list[3] = p_iters;
  parallel_for_body1__while__0_cps_cont_env5 -> contn_env = contn_env;
  parallel_for_body1__while__0_cps_cont_env5 -> cont_fn = parallel_for_body1__while__0_cps_cont5;
  uwomp_barrier(parallel_for_body1__while__0_cps_cont_env5,phase_num);
}

//TODO: Add the fourth argument.
void parallel_for_body1__while__0_cps_cont5(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
{
  int i = (int )arg_list[0];
  int *iters = (int *)arg_list[1];
  int *p_i = (int *)arg_list[2];
  int **p_iters = (int **)arg_list[3];
  //free(arg_list);
   *p_i = i;
   *p_iters = iters;
	//TODO: Reuse the memory allocated for previous environment
	//TODO: There is no need of creating this cotinuation.
  //struct __cont_env *parallel_for_body1__while__0_cps_cont_env6 = malloc(sizeof(struct __cont_env ));
  //struct __cont_env *parallel_for_body1__while__0_cps_cont_env6 = old_env;
  //parallel_for_body1__while__0_cps_cont_env6 -> arg_list = ((void **)(malloc(0 * sizeof(void *))));
  //parallel_for_body1__while__0_cps_cont_env6 -> contn_env = contn_env;
  //parallel_for_body1__while__0_cps_cont_env6 -> cont_fn = parallel_for_body1__while__0_cps_cont6;
  void **arg_list_4;
  arg_list_4 = arg_list;
  arg_list_4[0] = p_i;
  arg_list_4[1] = p_iters;

  //parallel_for_body1__while__0_cps(arg_list_4,parallel_for_body1__while__0_cps_cont_env6,phase_num);
	//TODO:
  parallel_for_body1__while__0_cps(arg_list_4,contn_env,phase_num, old_env);
}

// TODO: we can remove this funciton
//void parallel_for_body1__while__0_cps_cont6(void **arg_list,struct __cont_env *contn_env,int phase_num, struct __cont_env *old_env)
//{
//  free(arg_list);
//  if (contn_env != NULL) {
//    uwomp_call_contn_fun(contn_env);
//  }
//}
