#include <stdio.h>
#include <stdlib.h>

/*************** Start of work list data structures ***************************/
/* Linked list to store the worklist of each worker.
 * Each entry in the worklist is a continuation to be executed in the current
 * phase.
 */
typedef struct __worklist {
	// we use struct __contn_env itself?
	// FIXME: Do we need it to be void *?
	struct __cont_env *contn_env;
	//FIXME: Not sure if we need phase_num
	int phase_num;
	struct __worklist *next;
	// Implemented as a doubly linked list.
	struct __worklist *prev;
}uwomp_worklist;

/* Array to store the work-list of each worker.
 */
uwomp_worklist **ready_worklist;
uwomp_worklist **pending_worklist;

int NUM_WORKERS = 0;

/* Structure to store the continuation. It stores both the required data
 * and the continuation function.
 */
struct __cont_env {
	void **arg_list;
	struct __cont_env *contn_env;
	// TODO: Add phase_num. Not sure if it is needed
	int phase_num;
	/* This is the continuation function that needs to be called
	 * after a thread picks up this entry form the worklist.
	 */
	// TODO: Added a fourth argument to store old_env.
	void (*cont_fn) (void**, struct __cont_env *, int, struct __cont_env *);
	//void (*cont_fn) (void**, struct __cont_env *, int);
};
typedef struct __cont_env __t_cont_env;

/* Initilize the ready and pending worklists.*/
inline void uwomp_worklist_init(int num_workers, int max_entries_in_ready_wl) {
	ready_worklist = (uwomp_worklist **) calloc(num_workers,
			sizeof(uwomp_worklist *));
	pending_worklist = (uwomp_worklist **) calloc(num_workers,
			sizeof(uwomp_worklist *));
	NUM_WORKERS = num_workers;
}

/* Here we just need to exchange the ready and pending worklist
 * of a particular worker because whenever this is called we are
 * sure that all the entries in the pending worklist can be executed.
 */
inline void uwomp_move_from_pending_to_ready(int tid) {
	uwomp_worklist *temp = ready_worklist[tid];
	ready_worklist[tid] = pending_worklist[tid];
  pending_worklist[tid] = temp;
}

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
		free(temp);
	}
}
/*************** End of work list data structures ***************************/

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

/* Add the continuation to the pending work list of worker tid.
 * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using doubly linked list.
 */
inline void uwomp_add_to_local_pending_worklist(void *contn_env, int phase_num) {
	int tid= omp_get_thread_num();
	/* Create a new entry and initialize.*/
	uwomp_worklist *new_entry=
		(uwomp_worklist *)malloc(sizeof(uwomp_worklist));
	new_entry -> contn_env = contn_env;
	new_entry -> phase_num = phase_num;
	new_entry -> next  = NULL;
	new_entry -> prev = new_entry;
	/* Insert the new entry at the end of the list.*/
	uwomp_worklist *p = pending_worklist[tid];
	if (p == NULL) {
		pending_worklist[tid] = new_entry;
		return;
	}

	// Append the new entry to the end of the list
	p->prev->next = new_entry;
	new_entry->prev = p->prev;
	p->prev = new_entry;

	return;
}

/* Add the continuation to the ready work list of worker tid.
 * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using doubly linked list.
 */
inline void uwomp_add_to_local_ready_worklist(void *contn_env, int phase_num) {
	int tid= omp_get_thread_num();
	/* Create a new entry and initialize.*/
	uwomp_worklist *new_entry=
		(uwomp_worklist *)malloc(sizeof(uwomp_worklist));
	new_entry -> contn_env = contn_env;
	new_entry -> phase_num = phase_num;
	new_entry -> next  = NULL;
	new_entry -> prev = new_entry;
	/* Insert the new entry at the end of the list.*/
	uwomp_worklist *p = ready_worklist[tid];
	if (p == NULL) {
		ready_worklist[tid] = new_entry;
		return;
	}

	// Append the new entry to the end of the list
	p->prev->next = new_entry;
	new_entry->prev = p->prev;
	p->prev = new_entry;

	return;
}

inline void uwomp_execute_ready_worklist(int tid) {
	/* Get the continuation from the worklist, to be executed.*/
	uwomp_worklist *first_entry = ready_worklist[tid];

	if (first_entry != NULL) {
		/* Get the continuation env;*/
		__t_cont_env *e = (__t_cont_env *)(first_entry -> contn_env);
		/* Remove the entry */
		uwomp_remove_local_ready_worklist_entry(tid);
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
inline void uwomp_barrier(__t_cont_env *new_env, int phase_num) {
	//hit_count++;
	//fprintf(stderr, "hit_count = %d\n", hit_count);
	int tid = omp_get_thread_num();
	uwomp_add_to_local_pending_worklist(new_env, phase_num);

	if (ready_worklist[tid] != NULL) {
		uwomp_execute_ready_worklist(tid);
	} else {
#pragma omp barrier
		//fprintf(stderr, "After barrier\n");
		uwomp_move_from_pending_to_ready(tid);
		//fprintf(stderr, "After move from pending to ready\n");
		uwomp_execute_ready_worklist(tid);
	}
}

inline void uwomp_execute_worklist() {
  int tid = omp_get_thread_num();

	// Move possible entries from pending to ready work-list.
	uwomp_move_from_pending_to_ready(tid);

	/* Get the continuation from the worklist, to be executed.*/
	uwomp_worklist *first_entry = ready_worklist[tid];

	if (first_entry != NULL) {
		uwomp_execute_ready_worklist(tid);
	}
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
	void **argl = e -> arg_list;
	struct __cont_env *e1 = e->contn_env;
	int phase_num = e -> phase_num;
	// TODO: It is decieded to reuse the memory allocated for continuation
	// environment. So do not free it now.
	//free(e);
	//TODO: Add a 4th argument to each function as old_env;
	(cont_fn)(argl,e1,phase_num, e);
	//(cont_fn)(argl,e1,phase_num);
}

void uwomp_first_fun(void** a, struct __cont_env *e , int p) {
}
