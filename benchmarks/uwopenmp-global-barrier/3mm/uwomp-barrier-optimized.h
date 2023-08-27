#include <stdio.h>
#include <stdlib.h>
#define UNDEF -1

//int num_mallocs = 0;

/*************** Start of work list data structures ***************************/
/* Structure to store the continuation. It stores both the required data
 * and the continuation function.
 */
struct __cont_env {
	void **arg_list;
	struct __cont_env *contn_env;
	// TODO: Add phase_num. Not sure if it is needed
	//int phase_num;

    // TODO Starts: Arglist optimization
    // Field to store the funciton specific arglist
    //void **orig_fun_arglist;
    // TODOE Ends

	/* This is the continuation function that needs to be called
	 * after a thread picks up this entry form the worklist.
	 */
	// TODO: Added a fourth argument to store old_env.
	void (*cont_fn) (void**, struct __cont_env *, int, struct __cont_env *);
    // TODO Starts: Arglist optimization
    // Addeded a fifth argument to pass the function specific arglist
	//void (*cont_fn) (void**, struct __cont_env *, int, struct __cont_env *, void **);
    // TODO Ends
	//void (*cont_fn) (void**, struct __cont_env *, int);
	//
	/*
	 * CHANGE: It is realized that the worklist management can
	 * be embedded inside cont env itself.
	 */
	//struct __cont_env *next;
	// Implemented as a doubly linked list.
	//struct __cont_env *prev;
};
typedef struct __cont_env __t_cont_env;
typedef struct __cont_env uwomp_worklist;
/* Linked list to store the worklist of each worker.
 * Each entry in the worklist is a continuation to be executed in the current
 * phase.
 */
//typedef struct __worklist {
//	// we use struct __contn_env itself?
//	// FIXME: Do we need it to be void *?
//	struct __cont_env *contn_env;
//	//FIXME: Not sure if we need phase_num
//	//int phase_num;
//	struct __worklist *next;
//	// Implemented as a doubly linked list.
//	struct __worklist *prev;
//}uwomp_worklist;

/* Array to store the work-list of each worker.
 */
uwomp_worklist ***ready_worklist;
uwomp_worklist ***pending_worklist;
/* List to store the entries which can be reused rather to
 * avoid mallocs.
 */
uwomp_worklist **free_list;

int NUM_WORKERS = 0;
int CHUNK_SIZE = 0;
int NUM_TASKS = 0;
int START_INDEX = 0;

/* Array to store chunk size of each tid
 */
int *chunk_size_array;
int max_chunk_size; //mcs
int num_of_workers_having_max_chunk_size; // nwmcs

#define get_local_index(task_id) ((task_id - START_INDEX) % max_chunk_size)

int *max_task_id_array;
int *max_local_index_array;


/* Initilize the ready and pending worklists.*/
inline void uwomp_worklist_init(int num_workers, int num_tasks, int start_index,
		int max_entries_in_ready_wl) {
	ready_worklist = calloc(num_workers, sizeof(uwomp_worklist **));
	pending_worklist = calloc(num_workers, sizeof(uwomp_worklist **));
	max_task_id_array = calloc(num_workers, sizeof(int));
	max_local_index_array = calloc(num_workers, sizeof(int));
	//free_list = (uwomp_worklist **) calloc(num_workers,
			//sizeof(uwomp_worklist *));
	chunk_size_array = calloc(num_workers, sizeof(int));
	/* mcs = ceil(ntasks/nthreads) */
	max_chunk_size = ((num_tasks - 1)/num_workers) + 1;
	/* mcs = floor(ntasks/nthreads) */
	num_of_workers_having_max_chunk_size = num_tasks/max_chunk_size;
	START_INDEX = start_index;
	/* Set chunk size and max_task_id_array for each worker
	 */
	/* Chunk_size = max_chunk_size           if tid < nwmcs
	 *            = #tasks - (nwmcs * mcs)   if tid = nwmcs
	 *            = 0                        if tid > nwmcs 
	 *
	 * max_task_id_array = (1+tid)*mcs - 1 + start if tid < nwmcs
	 *            = #tasks - 1 + start       if tid = nwmcs
	 *            = Undefined                if tid > nwmcs 
	 */
	int tid;
	for (tid = 0; tid < num_workers; tid++) {
		if (tid < num_of_workers_having_max_chunk_size) {
			chunk_size_array[tid] = max_chunk_size;	
			max_local_index_array[tid] = max_chunk_size - 1;
			max_task_id_array[tid] = (1 + tid) * max_chunk_size - 1 + START_INDEX;	
		} else if (tid == num_of_workers_having_max_chunk_size)  {
			chunk_size_array[tid] =
				num_tasks - (num_of_workers_having_max_chunk_size * max_chunk_size);
			max_local_index_array[tid] = 
				num_tasks - (num_of_workers_having_max_chunk_size * max_chunk_size) - 1;
			max_task_id_array[tid] = num_tasks - 1 + START_INDEX;	
		} else {
			chunk_size_array[tid] = 0; 
			max_local_index_array[tid] = UNDEF;
			max_task_id_array[tid] = UNDEF;
		}
	}

	/* Allocate ready and pending worklists.
	 */
	for (tid = 0; tid < num_workers; tid++) {
		ready_worklist[tid] = calloc(chunk_size_array[tid], sizeof(uwomp_worklist *));
		pending_worklist[tid] = calloc(chunk_size_array[tid], sizeof(uwomp_worklist *));
	}
	NUM_WORKERS = num_workers;
}

/* Here we just need to exchange the ready and pending worklist
 * of a particular worker because whenever this is called we are
 * sure that all the entries in the pending worklist can be executed.
 */
inline void uwomp_move_from_pending_to_ready(int tid) {
	uwomp_worklist **temp = ready_worklist[tid];
	ready_worklist[tid] = pending_worklist[tid];
  pending_worklist[tid] = temp;
}
/*
int uwomp_get_num_free_entries(int tid) {
    int num_entries = 0;
    uwomp_worklist *p = free_list[tid];
    while (p != NULL) {
        num_entries++;
        p = p -> next;
    }
    return num_entries;
}
*/

// There will be num_tasks entries to be freed.
/*
inline void uwomp_free_worklist_free() {
    int tid = omp_get_thread_num();
    //fprintf(stderr, "tid = %d num_free_entries = %d\n", tid, uwomp_get_num_free_entries(tid));
	uwomp_worklist *p = free_list[tid];
	// This check is not required since this funciton is called only if
	// p != NULL
	while (p != NULL) 
	{
		uwomp_worklist *temp = p;
        p = p -> next;
        free(temp);
	}
}
*/


/* Just update the pointer. Memory is not freed.
 */
//inline void uwomp_remove_from_free_list(int tid) {
//    //fprintf(stderr, "tid = %d num_free_entries = %d\n", tid, uwomp_get_num_free_entries(tid));
//	uwomp_worklist *p = free_list[tid];
//	// This check is not required since this funciton is called only if
//	// p != NULL
//	//if (p != NULL) 
//	{
//		uwomp_worklist *temp = p;
//		free_list[tid] = p -> next;
//		if (p -> next != NULL)
//			free_list[tid]->prev = p->prev;
//	}
//}
//
//inline void uwomp_add_to_local_free_list(uwomp_worklist *new_entry, int tid) {
//	new_entry -> next  = NULL;
//	new_entry -> prev = new_entry;
//	/* Insert the new entry at the end of the list.*/
//	uwomp_worklist *p = free_list[tid];
//	if (p == NULL) {
//		free_list[tid] = new_entry;
//		return;
//	}
//
//	// Append the new entry to the end of the list
//	p->prev->next = new_entry;
//	new_entry->prev = p->prev;
//	p->prev = new_entry;
//
//	return;
//}
/*
inline void uwomp_remove_local_ready_worklist_entry(int tid) {
	uwomp_worklist *p = ready_worklist[tid];
	// This check is not required since this funciton is called only if
	// p != NULL
	//if (p != NULL) 
	{
		uwomp_worklist *temp = p;
		ready_worklist[tid] = p -> next;
		if (p -> next != NULL)
			ready_worklist[tid]->prev = p->prev;
		// Freeing the worklist pointer. Not freeing the fields.
		// FIXME: Check if it is fine to free it without freeing the fields?
        // Instead of freeying temp we are adding this entry to the free_list.
        uwomp_add_to_local_free_list(temp, tid);
		//free(temp);
	}
}

/*************** End of work list data structures ***************************/

/*
inline void uwomp_print_pending_worklist() {
  int tid = omp_get_thread_num();
	uwomp_worklist *p = pending_worklist[tid];
	int i = 0;
	fprintf(stderr, "pending worklist entries for tid = %d:\n", tid);
	fprintf(stderr, "--------------------------------------\n", tid);
	while (p != NULL) {
		fprintf(stderr, "    tid %d: %x contn_env = %x\n",
				tid, p, p->contn_env);
		p = p -> next;
	}
	fprintf(stderr, "\n");
	return;
}
*/

/*
inline void uwomp_print_ready_worklist() {
  int tid = omp_get_thread_num();
	uwomp_worklist *p = ready_worklist[tid];
	int i = 0;
	fprintf(stderr, "ready worklist entries for tid = %d:\n", tid);
	fprintf(stderr, "------------------------------------\n", tid);
	while (p != NULL) {
		fprintf(stderr, "    %d: %x contn_env = %x\n", tid, p, p->contn_env);
		p = p -> next;
	}
	fprintf(stderr, "\n");
	return;
}
*/

/* Add the continuation to the pending work list of worker tid.
 * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using doubly linked list.
 */
inline void uwomp_add_to_local_pending_worklist(uwomp_worklist *new_entry,
		int task_id, int phase_num) {
	int tid = omp_get_thread_num();
	/* Create a new entry and initialize.*/
	//uwomp_worklist *new_entry = NULL;
	//if (free_list[tid] != NULL) {
	//	new_entry = free_list[tid];
	//	uwomp_remove_from_free_list(tid);
	//} else {
	//new_entry = (uwomp_worklist *)malloc(sizeof(uwomp_worklist));
	//}
	//new_entry -> contn_env = contn_env;
	int local_index = get_local_index(task_id);
	pending_worklist[tid][local_index] = new_entry;
	//new_entry -> phase_num = phase_num;
	//new_entry -> next  = NULL;
	//new_entry -> prev = new_entry;
	///* Insert the new entry at the end of the list.*/
	//uwomp_worklist *p = pending_worklist[tid];
	//if (p == NULL) {
	//	pending_worklist[tid] = new_entry;
	//	return;
	//}

	//// Append the new entry to the end of the list
	//p->prev->next = new_entry;
	//new_entry->prev = p->prev;
	//p->prev = new_entry;

	return;
}

/* Add the continuation to the ready work list of worker tid.
 * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using doubly linked list.
 */
//inline void uwomp_add_to_local_ready_worklist(void *contn_env, int phase_num) {
//	int tid= omp_get_thread_num();
//	/* Create a new entry and initialize.*/
//    uwomp_worklist *new_entry = NULL;
//    if (free_list[tid] != NULL) {
//        new_entry = free_list[tid];
//        uwomp_remove_from_free_list(tid);
//    } else {
//        new_entry= (uwomp_worklist *)malloc(sizeof(uwomp_worklist));
//    }
//	new_entry -> contn_env = contn_env;
//	//new_entry -> phase_num = phase_num;
//	new_entry -> next  = NULL;
//	new_entry -> prev = new_entry;
//	/* Insert the new entry at the end of the list.*/
//	uwomp_worklist *p = ready_worklist[tid];
//	if (p == NULL) {
//		ready_worklist[tid] = new_entry;
//		return;
//	}
//
//	// Append the new entry to the end of the list
//	p->prev->next = new_entry;
//	new_entry->prev = p->prev;
//	p->prev = new_entry;
//
//	return;
//}

inline void uwomp_execute_ready_worklist(int tid, int local_index) {
	// TODO: Here instead of first_entry != NULL check we must check
	// if we reached the maximum local index plus 1 of a worker.
	// That indicates that woker has no more tasks to do.
	//if (first_entry != NULL) {
	if (local_index <= max_local_index_array[tid]) {
		/* Get the continuation from the worklist, to be executed.*/
		uwomp_worklist *first_entry = ready_worklist[tid][local_index];
		/* Get the continuation env;*/
		//__t_cont_env *e = (__t_cont_env *)(first_entry -> contn_env);
		__t_cont_env *e = first_entry;
		/* Remove the entry */
		//CHANGE: In the optimized version this call is
		// not required.
		//uwomp_remove_local_ready_worklist_entry(tid);
		// Execute the continuation.
		// This check is removed 
		//if (e->contn_env != NULL) {
		uwomp_call_contn_fun(e);
		//e->cont_fn(e->arg_list, e->contn_env, 0);
		//}
		// FIXME: Is the following call here violating CPS.
		//return uwomp_execute_ready_worklist(tid);
	}
}

int barrier_hit_count = 0;

//inline void uwomp_barrier(__t_cont_env *new_env, int phase_num) {
//	//hit_count++;
//	//fprintf(stderr, "hit_count = %d\n", hit_count);
//	int tid = omp_get_thread_num();
//	uwomp_add_to_local_pending_worklist(new_env, phase_num);
//
//	if (ready_worklist[tid] != NULL) {
//		uwomp_execute_ready_worklist(tid);
//	} else {
////#pragma omp barrier
//#pragma omp critical
//        {
//            barrier_hit_count++;
//        }
//        while (barrier_hit_count < NUM_WORKERS);
//#pragma omp single 
//        {
//            barrier_hit_count = 0;
//        }
//
//		//fprintf(stderr, "After barrier\n");
//		uwomp_move_from_pending_to_ready(tid);
//		//fprintf(stderr, "After move from pending to ready\n");
//		uwomp_execute_ready_worklist(tid);
//	}
//}

//int hit_count = 0;
inline void uwomp_barrier(__t_cont_env *new_env, int task_id, int phase_num) {
	//hit_count++;
	//fprintf(stderr, "hit_count = %d\n", hit_count);
    //if (new_env == NULL)
        //fprintf(stderr, "cont_env = %x\n", new_env);
	int tid = omp_get_thread_num();
	uwomp_add_to_local_pending_worklist(new_env, task_id, phase_num);

	/* TODO: Since we are using array for ready worklist we must
	 * increment the task id which serves as index to the ready
	 * worklist.
	 */
	if ((task_id + 1) <= max_task_id_array[tid]) {
		int local_index = get_local_index(task_id + 1);
	//if (local_index <= max_local_index_array[tid]) {
		uwomp_execute_ready_worklist(tid, local_index);
	} else {
#pragma omp barrier
  //fprintf(stderr, "tid = %d num_free_entries = %d\n", omp_get_thread_num(),
          //uwomp_get_num_free_entries(omp_get_thread_num()));
		//fprintf(stderr, "After barrier\n");
		uwomp_move_from_pending_to_ready(tid);
		//fprintf(stderr, "After move from pending to ready\n");
		/* Here local index must be zero because it is the beginning of
		 * next phase.
		 */
		uwomp_execute_ready_worklist(tid, 0);
	}
}

inline void uwomp_execute_worklist() {
  int tid = omp_get_thread_num();

	// Move possible entries from pending to ready work-list.
	uwomp_move_from_pending_to_ready(tid);

	/* Get the continuation from the worklist, to be executed.*/
	//uwomp_worklist **first_entry = ready_worklist[tid];

	//if (first_entry != NULL) {
		/* FIXME: Here the local index is passed as 0. Verify this is
		 * always the case.
		 */
		uwomp_execute_ready_worklist(tid, 0);
	//}
    // The following code is commented because it is suspected that this is a dead code.
    /*else {
		//fprintf(stderr, "tid = %d, No elements in the ready worklist\n", tid);
		// Call uwomp_execute_work_list recursively if there are any pending
		// entries.
		// Here indirectly we are performing a busy wait because, it may be the case
		// that no entries can be moved to ready worklist even now.
		if (pending_worklist [tid] != NULL) {
			//fprintf(stderr, "tid = %d, Some elements in the pending worklist\n", tid);
			//printDist();
			return uwomp_execute_worklist();
		}
		// Here both the pending and ready worklists are empty, which means there is
		// nothing todo. This marks the end of work by this worker.
		else {
			//fprintf(stderr, "tid = %d: No elements in pending and ready worklists\n", tid);
		}
	}*/
}

/* This function calls the continuation environment after keeping its feilds in
 * temporories and freeing its memory.
 */
inline void uwomp_call_contn_fun(struct __cont_env *e) {
	//int (*cont_fn) (void**, struct __cont_env *, int) = e -> cont_fn;
	int (*cont_fn) (void**, struct __cont_env *, int, struct __cont_env *) = e -> cont_fn;
    // TODO Strats: Arglist optimization
    // Add the fifth argument
	//int (*cont_fn) (void**, struct __cont_env *, int, struct __cont_env *, void **) = e -> cont_fn;
    // TODO Ends
	void **argl = e -> arg_list;
	struct __cont_env *e1 = e->contn_env;
	//int phase_num = e -> phase_num;
    // TODO Strats: Arglist optimization
    // Copy the funciton speficic arglist.
    // TODO Ends
    //void **orig_fun_arglist = e -> orig_fun_arglist;
	// TODO: It is decieded to reuse the memory allocated for continuation
	// environment. So do not free it now.
	//free(e);
	//TODO: Add a 4th argument to each function as old_env;
	(cont_fn)(argl,e1,0, e);
    // TODO Strats: Arglist optimization
    // Add a 5th argument to pass the funtion specific arglist
	//(cont_fn)(argl,e1,phase_num, e, orig_fun_arglist);
	//(cont_fn)(argl,e1,phase_num);
}

void uwomp_first_fun(void** a, struct __cont_env *e , int p) {
}
