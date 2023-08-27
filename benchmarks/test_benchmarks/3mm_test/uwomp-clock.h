#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int gcontid = 0;

/*************** Start of clock data structures ***************************/
// Structure to store information about a task.
// FIXME 1: Later if we find that we need just the id we can change the
// declaration as follows.
// typedef int uwomp_task;
typedef struct {
	int id;
}uwomp_task;

// Structure to store information about a clock.
// FIXME 2: Later if we find that we need just the id we can change the
// declaration as follows.
// typedef int uwomp_clock;
typedef struct {
	int id;
	int num_tasks_registered;
	int phase_num;
	// To store the number of advances made on this clock. When it becomes equal
	// to num_tasks_registered increment phase_num by 1.
	int num_advances;
}uwomp_clock;

typedef struct clk_list_entry{
	uwomp_clock *c;
	// To store the phase number corresponding to clock c for this task.
	int phase_num;
	struct clk_list_entry *next;
}uwomp_clock_list_entry;

// List of clocks
uwomp_clock_list_entry *clock_list = NULL;

/*************** End of clock data structures ***************************/

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
	// Used as a doubly linkede list only in the global worklist now.
	struct __worklist *prev;
}uwomp_worklist;

/* Array to store the work-list of each worker.
 */
uwomp_worklist **ready_worklist;
uwomp_worklist **pending_worklist;
/* Global worklist */
uwomp_worklist *global_worklist;
int *done;
int NUM_WORKERS = 0;
int MAX_ENTRIES_IN_READY_LIST;

/* Number of elements in ready worklist of a worker*/
int *num_ready_entries;

/* Structure to store the continuation. It stores both the required data
 * and the continuation function.
 */
struct __cont_env {
	int contid;
	void **arg_list;
	struct __cont_env *contn_env;
	// TODO: Add phase_num. Not sure if it is needed
	int phase_num;
	// task id under which this continuation should execute
	int task_id;
	// Task to clocks map.
	// FIXME: this may be optimized later.
	uwomp_clock_list_entry **uwomp_task_to_clocks_map;
	/* This is the continuation function that needs to be called
	 * after a thread picks up this entry form the worklist.
	 */
	void (*cont_fn) (void**, struct __cont_env *, int, int,
			uwomp_clock_list_entry **);
};
typedef struct __cont_env __t_cont_env;


/*************** End of work list data structures ***************************/

/******** Start of work list functions common for both local and global *****/
/* Initilize the ready and pending worklists.*/
inline void uwomp_worklist_init(int num_workers, int max_entries_in_ready_wl) {
	ready_worklist = calloc(num_workers, sizeof(uwomp_worklist *));
	pending_worklist = calloc(num_workers, sizeof(uwomp_worklist *));
	num_ready_entries = calloc(num_workers, sizeof(int));
	done = calloc(num_workers, sizeof(int));
	NUM_WORKERS = num_workers;
	MAX_ENTRIES_IN_READY_LIST = max_entries_in_ready_wl;
	int i;
	for (i = 0; i < NUM_WORKERS; i++)
		done[i] = 1;
}

/******** End of work list functions common for both local and global *****/

/******** Start of work list functions with only local ********************/
/* Add the continuation to the ready work list of worker tid.
 * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using linked list.
 */
inline void uwomp_add_to_ready_worklist(uwomp_worklist *new_entry) {
	int tid = omp_get_thread_num();

	new_entry -> next  = NULL;
	/* Insert the new entry at the end of the list.*/
	uwomp_worklist *p = ready_worklist[tid];
	if (p == NULL) {
		ready_worklist[tid] = new_entry;
			return;
	}
	uwomp_worklist *q;
	while (p != NULL) {
		q = p;
		p = p -> next;
	}
	q->next = new_entry;
}

/* Deque one entry from the worklist. This is the first entry of the
 * worklist of the worker with id tid.
 */
inline void uwomp_remove_from_ready_worklist(int tid) {
	uwomp_worklist *p = ready_worklist[tid];
	if (p != NULL) {
		uwomp_worklist *temp = p;
		ready_worklist[tid] = p -> next;
		//free(temp);
	}
}

/* Add the continuation to the pending work list of worker tid.
 * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using linked list.
 */
inline void uwomp_add_to_pending_worklist(void *contn_env, int phase_num) {
	int tid= omp_get_thread_num();
	/* Create a new entry and initialize.*/
	uwomp_worklist *new_entry=
		(uwomp_worklist *)malloc(sizeof(uwomp_worklist));
	new_entry -> contn_env = contn_env;
	new_entry -> phase_num = phase_num;
	new_entry -> next  = NULL;
	/* Insert the new entry at the end of the list.*/
	uwomp_worklist *p = pending_worklist[tid];
	if (p == NULL) {
		pending_worklist[tid] = new_entry;
		return;
	}
	uwomp_worklist *q;
	while (p != NULL) {
		q = p;
		p = p -> next;
	}
	q->next = new_entry;
}

/* Deque one entry from the worklist. This is the first entry of the
 * worklist of the worker with id tid.
 */
inline void uwomp_remove_from_pending_worklist(int tid) {
	uwomp_worklist *p = pending_worklist[tid];
	if (p != NULL) {
		uwomp_worklist *temp = p;
		pending_worklist[tid] = p -> next;
		//free(temp);
	}
}

inline void uwomp_move_from_pending_to_ready(int tid) {
	uwomp_worklist *wl_entry = pending_worklist[tid];
	uwomp_worklist *prev_wl_entry = NULL;
	while (wl_entry != NULL) {
		uwomp_clock_list_entry **uwomp_task_to_clocks_map =
			(wl_entry->contn_env)->uwomp_task_to_clocks_map;
		int task_id = (wl_entry->contn_env)->task_id;
		uwomp_clock_list_entry *tc_entry = uwomp_task_to_clocks_map[task_id];
		int can_move = 1;
		// Examine the pending worklist to see if any tasks can be moved to ready
		// worklist.
		while (tc_entry != NULL) {
			uwomp_clock *c = tc_entry -> c;
			// TODO: Check if we can avoid this critical.
			// May be benign. Can be removed.
			// Critical is required here because some other worker may update
			// c->phase_num concurrently.
#pragma omp critical
			{
				// Check if the phase number of the task for this clock matches with
				// global phase number of the clock.
			  //fprintf (stderr, "tid = %d, tc_phase_num = %d c_phase_num = %d v = %d task_id = %d\n",
				//		tid,  tc_entry-> phase_num, c -> phase_num, wl_entry->contn_env->arg_list[1],
				//		wl_entry->contn_env->task_id);
				if (tc_entry -> phase_num == c -> phase_num) {
					//fprintf(stderr, "tid = %d Can move to ready worklist\n", tid);
					// TODO: Should we reset the following?
					// tc_entry -> phase_num = 0;
					// c -> phase_num = 0;
				}
				else {
					can_move = 0;
				}
			}
			if (can_move == 0) {
				//fprintf(stderr, "tid = %d Cannot move to ready worklist\n", tid);
				break;
			}
			tc_entry = tc_entry->next;
		}
		// We can add the entry to ready list only if all the clocks for this
		// task_id are in the next phase.
		if (can_move) {
			/* Get the continuation env;*/
			__t_cont_env *e = (__t_cont_env *)(wl_entry -> contn_env);
			// Remove this entry from pending_worklist.
			// Case 1: The entry to be removed is the first entry.
			if (wl_entry == pending_worklist[tid]) {
				pending_worklist[tid] = wl_entry->next;
				prev_wl_entry =  NULL;
				// Add the entry to ready worlist before updating wl_entry
				// Note: wl_entry -> next will be set to NULL inside
				// uwomp_add_to_ready_worklist.
				// Using the same entry in ready_worklist too. So no need to remove it
				// from pedning worlist.
				uwomp_add_to_ready_worklist(wl_entry);
				// Get the next entry. Start from the beginning.
				wl_entry = pending_worklist[tid];
			}
			// Case 2: It is an intermediate node.
			else {
				prev_wl_entry->next = wl_entry->next;
				// Add the entry to ready worlist before updating wl_entry
				// Note: wl_entry -> next will be set to NULL inside
				// uwomp_add_to_ready_worklist.
				// Using the same entry in ready_worklist too. So no need to remove it
				// from pedning worlist.
				uwomp_add_to_ready_worklist(wl_entry);
				wl_entry = prev_wl_entry -> next;
				// Note: prev_wl_entry remains the same.
			}
		} else {
			// Store the previous entry so that it can be used if we are removing an
			// intermediate entry from the pending_worklist.
			prev_wl_entry = wl_entry;
			// Get the next entry in case of can_move = 0.
			wl_entry = wl_entry -> next;
		}
	}
}

/* Deque one entry from the worklist. This is the fist entry of the
 * worklist of the worker with id tid.
 */
inline void uwomp_remove_entry(int tid) {
	uwomp_worklist *p = ready_worklist[tid];
	if (p != NULL) {
		uwomp_worklist *temp = p;
		ready_worklist[tid] = p -> next;
		// Freeing the worklist pointer. Not freeing the fields.
		// FIXME: Check if it is fine to free it without freeing the fields?
		//free(temp);
	}
}

inline void uwomp_execute_ready_worklist(int tid) {
	/* Get the continuation from the worklist, to be executed.*/
	uwomp_worklist *first_entry = ready_worklist[tid];

	if (first_entry != NULL) {
		/* Get the continuation env;*/
		__t_cont_env *e = (__t_cont_env *)(first_entry -> contn_env);
		/* Call the function.*/
		// The third argument is just a place holder for phase_num in case of clock
		// worklist.
		/* Remove the entry */
		uwomp_remove_entry(tid);
		uwomp_call_contn_fun(e);
		//e->cont_fn(e->arg_list, e->contn_env, 0);
		// FIXME: Is the following call here violating CPS.
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
	} else {
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
	}
}
/******** End of work list functions with only local ********************/

/******** Start of work list functions with global ********************/
/* Add the continuation to the global work list, which is a doubly linked list.
 * We add a list of tasks to the global worklist.
 * The function is declared as inline. Otherwise the functions which use this
 * function will not be in CPS form.
 */
inline void uwomp_add_to_global_worklist(uwomp_worklist *new_list) {
	int tid = omp_get_thread_num();

	if (new_list == NULL)
		return;

	// If there are no elements in the global list.
	if (global_worklist == NULL) {
		global_worklist = new_list;
		return;
	}

	// Append the new list
	global_worklist->prev->next = new_list;
	uwomp_worklist *new_list_last_node = new_list->prev;
	new_list->prev = global_worklist->prev;
	global_worklist->prev = new_list_last_node;

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
	//fprintf(stderr, "%u %d\n", contn_env, ((struct __cont_env *)contn_env)->contid);

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

/* Add k - num_ready_entries[tid] from the pending worklist to ready worklist.
 * Rest of the tasks to be added to global_worklist.
 * * The function is declared as inline. Otherwise
 * the functions which use this function will not be in CPS form.
 * Each individual worklist is implemented as a queue using doubly linked list.
 */
inline void uwomp_add_to_local_ready_worklist(uwomp_worklist *new_list) {
	int tid= omp_get_thread_num();
	uwomp_worklist *p = ready_worklist[tid];
	if (p == NULL) {
		ready_worklist[tid] = new_list;
		return;
	}

	// Append the new entry to the end of the list
	p->prev->next = new_list;
	uwomp_worklist *new_list_last_node = new_list->prev;
	new_list->prev = p->prev;
	p->prev = new_list_last_node;

	return;
}

/* move first k - num_ready_entries[tid] possible entries from the pending
 * worklist to ready worklist.
 * Rest of the tasks to be added to global_worklist.
 */

inline void uwomp_move_from_local_pending_to_ready_and_global(int tid, int k) {
	int num_entries_to_move = k - num_ready_entries[tid];
	uwomp_worklist *global_wl_entries_list = NULL;
	uwomp_worklist *entry_to_add = NULL;;

	uwomp_worklist *wl_entry = pending_worklist[tid];
	uwomp_worklist *prev_wl_entry = NULL;
	while (wl_entry != NULL) {
		entry_to_add = NULL;
		uwomp_clock_list_entry **uwomp_task_to_clocks_map =
			(wl_entry->contn_env)->uwomp_task_to_clocks_map;
		int task_id = (wl_entry->contn_env)->task_id;
		uwomp_clock_list_entry *tc_entry = uwomp_task_to_clocks_map[task_id];
		int can_move = 1;
		// Examine the pending worklist to see if any tasks can be moved to ready
		// worklist.
		while (tc_entry != NULL) {
			uwomp_clock *c = tc_entry -> c;
			// TODO: Check if we can avoid this critical.
			// May be benign. Can be removed.
			// Critical is required here because some other worker may update
			// c->phase_num concurrently.
#pragma omp critical
			{
				// Check if the phase number of the task for this clock matches with
				// global phase number of the clock.
			  //fprintf (stderr, "To Rdy or Global: tid = %d, tc_phase_num = %d c_phase_num = %d v = %d task_id = %d\n",
				//		tid,  tc_entry-> phase_num, c -> phase_num, wl_entry->contn_env->arg_list[1],
				//		wl_entry->contn_env->task_id);
				if (tc_entry -> phase_num == c -> phase_num) {
					//fprintf(stderr, "To Rdy or Global: tid = %d Can move to ready or global worklist\n", tid);
					// TODO: Should we reset the following?
					// tc_entry -> phase_num = 0;
					// c -> phase_num = 0;
				} else {
					can_move = 0;
				}
			}
			if (can_move == 0) {
				//fprintf(stderr, "To Rdy or Global: tid = %d Cannot move to ready worklist\n", tid);
				break;
			}
			tc_entry = tc_entry->next;
		}
		// We can add the entry to ready list only if all the clocks for this
		// task_id are in the next phase.
		if (can_move) {
			/* Get the continuation env;*/
			__t_cont_env *e = (__t_cont_env *)(wl_entry -> contn_env);
			// Remove this entry from pending_worklist.
			// Case 1: The entry to be removed is the first entry.
			if (wl_entry == pending_worklist[tid]) {
				pending_worklist[tid] = wl_entry->next;
				if (wl_entry ->next != NULL)
					wl_entry->next->prev = wl_entry->prev;
				// Entry to be added
				entry_to_add = wl_entry;
				// Get the next entry. Start from the beginning.
				wl_entry = pending_worklist[tid];
			}
			// Case 2: It is an intermediate node.
			else {
				wl_entry->prev->next = wl_entry->next;
				if (wl_entry ->next != NULL) {
					wl_entry->next->prev = wl_entry->prev;
				} // BUGFIX
				else {
					pending_worklist[tid]->prev = wl_entry->prev;
				}
				// Entry to be added
				entry_to_add = wl_entry;
				wl_entry = wl_entry -> next;
				// Note: prev_wl_entry remains the same.
			}
			// If there is only one entry in the pending worklist, fix the previous
			// entry.
			// BUGFIX
			//if (pending_worklist[tid] != NULL) {
			//	if (pending_worklist[tid] -> next == NULL) {
			//		pending_worklist[tid] -> prev = pending_worklist[tid];
			//	}
			//}
			// Add the entry to ready worlist.
			// FIXME: Here we are adding a single entry to the local_ready or global
			// work list. Earlier thought of adding it as a list. But it seems
			// populating a list
			// Using the same entry in ready_worklist too. So no need to remove it
			// from pedning worlist.
			if (entry_to_add != NULL) {
				entry_to_add->next = NULL;
				entry_to_add->prev = entry_to_add;
				if (num_entries_to_move > 0) {
					num_entries_to_move--;
					num_ready_entries[tid]++;
					// Here no need to take the lock. So it is fine to add directly to the
					// list.
					//fprintf(stderr, "To Rdy or Global: tid = %d Moving to ready worklist, task_id = %d\n", tid, entry_to_add->contn_env->task_id);
					uwomp_add_to_local_ready_worklist(entry_to_add);
				} else {
						//fprintf(stderr, "To Rdy or Global: tid = %d Moving to global worklist, task_id = %d\n", tid, entry_to_add->contn_env->task_id);
					if (global_wl_entries_list == NULL) {
						global_wl_entries_list = entry_to_add;
					} else {
						// Here we need to take a lock to add to the global list. So better
						// populate all the entries to a list and add that list at the end.
						// Append the new entry to the end of the list
						global_wl_entries_list->prev->next = entry_to_add;
						entry_to_add->prev = global_wl_entries_list->prev;
						global_wl_entries_list->prev = entry_to_add;
					}
				}
			}

		} else {
			// Get the next entry in case of can_move = 0.
			wl_entry = wl_entry -> next;
		}
	}
	// Add the global_wl_entries_list to the global worklist.
	//FIXME: Can we improve this lock.

	if (global_wl_entries_list != NULL) {
#pragma omp critical
		{
			uwomp_add_to_global_worklist(global_wl_entries_list);
		}
	}
}

/* move first k - num_ready_entries[tid] entries from global
 * worklist to ready worklist.
 */
inline void uwomp_move_from_global_to_ready_old(int tid, int k) {
	int num_entries_to_move = k - num_ready_entries[tid];
	uwomp_worklist *global_wl_entries_list = NULL;
	uwomp_worklist *entry_to_add = NULL;;

	uwomp_worklist *wl_entry = global_worklist;
	uwomp_worklist *prev_wl_entry = NULL;
	// FIXME: Since we are accessing the global list we need a lock. Where to
	// place it?
	// If there are k entries already in the ready list we should stop.
	// Lock to global worklist
	// TODO: Optimize this
#pragma omp critical
	{
		// TODO: Inside global worklist, all entries are in the same phase.
		// So checking of phases is not required.
		// We can take first k entries as a list and move the list.
		while ((num_entries_to_move > 0) && (wl_entry != NULL)) {
			entry_to_add = NULL;
			uwomp_clock_list_entry **uwomp_task_to_clocks_map =
				(wl_entry->contn_env)->uwomp_task_to_clocks_map;
			int task_id = (wl_entry->contn_env)->task_id;
			//fprintf (stderr, "task_map = %x task_id = %d\n", uwomp_task_to_clocks_map, task_id);
			uwomp_clock_list_entry *tc_entry = NULL;
			tc_entry = uwomp_task_to_clocks_map[task_id];
			int can_move = 1;
			// Examine the global worklist to see if any tasks can be moved to ready
			// worklist.
			while (tc_entry != NULL) {
				uwomp_clock *c = tc_entry -> c;
				// TODO: Check if we can avoid this critical.
				// May be benign. Can be removed.
				// Critical is required here because some other worker may update
				// c->phase_num concurrently.
				//#pragma omp critical
				{
					// Check if the phase number of the task for this clock matches with
					// global phase number of the clock.
					//fprintf (stderr, "Global To Rdy: tid = %d, tc_phase_num = %d c_phase_num = %d v = %d task_id = %d\n",
					//		tid,  tc_entry-> phase_num, c -> phase_num, wl_entry->contn_env->arg_list[1],
				  //			wl_entry->contn_env->task_id);
					if (tc_entry -> phase_num == c -> phase_num) {
						//fprintf(stderr, "Global To Rdy: tid = %d Can move to ready worklist\n", tid);
						// TODO: Should we reset the following?
						// tc_entry -> phase_num = 0;
						// c -> phase_num = 0;
					}
					else {
						can_move = 0;
					}
				}
				if (can_move == 0) {
					//fprintf(stderr, "Global To Rdy: tid = %d Cannot move to ready worklist\n", tid);
					break;
				}
				tc_entry = tc_entry->next;
			}
			// We can add the entry to ready list only if all the clocks for this
			// task_id are in the next phase.
			if (can_move) {
				/* Get the continuation env;*/
				__t_cont_env *e = (__t_cont_env *)(wl_entry -> contn_env);
				// Remove this entry from pending_worklist.
				// Case 1: The entry to be removed is the first entry.
				if (wl_entry == global_worklist) {
					global_worklist = wl_entry->next;
					if (wl_entry ->next != NULL)
						wl_entry->next->prev = wl_entry->prev;
					prev_wl_entry =  NULL;
					// Entry to be added
					entry_to_add = wl_entry;
					// Get the next entry. Start from the beginning.
					wl_entry = global_worklist;
				}
				// Case 2: It is an intermediate node.
				else {
					wl_entry->prev->next = wl_entry->next;
					if (wl_entry ->next != NULL) {
						wl_entry->next->prev = wl_entry->prev;
					} else {
						global_worklist->prev = wl_entry->prev;
					}
					// Entry to be added
					entry_to_add = wl_entry;
					wl_entry = wl_entry->next;
					// Note: prev_wl_entry remains the same.
				}
				// If there is only one entry in the global worklist, fix the previous
				// entry.
				if (global_worklist != NULL) {
					if (global_worklist -> next == NULL) {
						global_worklist -> prev = global_worklist;
					}
				}
				// Add the entry to ready worlist.
				// FIXME: Here we are adding a single entry to the local_ready or global
				// work list. Earlier thought of adding it as a list. But it seems
				// populating a list
				// Using the same entry in ready_worklist too. So no need to remove it
				// from pedning worlist.
				if (entry_to_add != NULL) {
					entry_to_add->next = NULL;
					entry_to_add->prev = entry_to_add;
					if (num_entries_to_move > 0) {
						num_entries_to_move--;
						num_ready_entries[tid]++;
						// Here no need to take the lock. So it is fine to add directly to the
						// list.
						if (global_wl_entries_list == NULL) {
							global_wl_entries_list = entry_to_add;
						} else {
							// Here we need to take a lock to add to the global list. So better
							// populate all the entries to a list and add that list at the end.
							// Append the new entry to the end of the list
							global_wl_entries_list->prev->next = entry_to_add;
							entry_to_add->prev = global_wl_entries_list->prev;
							global_wl_entries_list->prev = entry_to_add;
						}
					}
				}
			} else { // can_move == 0
				// Store the previous entry so that it can be used if we are removing an
				// intermediate entry from the pending_worklist.
				prev_wl_entry = wl_entry;
				// Get the next entry in case of can_move = 0.
				wl_entry = wl_entry -> next;
			}
		}
	}
	// Add the global_wl_entries_list to the global worklist.
	if (global_wl_entries_list != NULL)
		uwomp_add_to_local_ready_worklist(global_wl_entries_list);
}

/* move first k - num_ready_entries[tid] entries from global
 * worklist to ready worklist.
 */
inline void uwomp_move_from_global_to_ready(int tid, int k) {
	int num_entries_to_move = k - num_ready_entries[tid];
	uwomp_worklist *ready_wl_entries_list = NULL;
	uwomp_worklist *entry_to_add = NULL;;

#pragma omp critical
	{
		uwomp_worklist *wl_entry = global_worklist;
		// FIXME: Since we are accessing the global list we need a lock. Where to
		// place it?
		// If there are k entries already in the ready list we should stop.
		// Lock to global worklist

		// Inside global worklist, all entries will be in the same phase.
		// So checking of phases is not required.
		// We can take first num_entries_to_move entries as a list and move the list.
		// TODO: Optmize this by getting the list in O(1) time. We may store the
		// number of entries in the global wl and the  pointers in an array.
		if (num_entries_to_move > 0) {
			while ((num_entries_to_move > 0) && (wl_entry != NULL)) {
				num_entries_to_move--;
				num_ready_entries[tid]++;
				// Here no need to take the lock. So it is fine to add directly to the
				// list.
				if (ready_wl_entries_list == NULL) {
					ready_wl_entries_list = global_worklist;
				}
				global_worklist = global_worklist->next;
				wl_entry = wl_entry->next;
			}
			// Fix the next and previous entries of ready_wl_entries_list and global_worklist
			if(wl_entry != NULL) {
				uwomp_worklist *temp = wl_entry -> prev;
				global_worklist->prev = ready_wl_entries_list->prev;
				ready_wl_entries_list->prev = temp;
				ready_wl_entries_list->prev->next = NULL;
			}
		}
	}
	// Add the global_wl_entries_list to the global worklist.
	if (ready_wl_entries_list != NULL)
		uwomp_add_to_local_ready_worklist(ready_wl_entries_list);
}

/* move first k - num_ready_entries[tid] entries from global
 * worklist to ready worklist.
 * Here entires from global work list are retrieved one by one.
 */
inline void uwomp_move_from_global_to_ready_inefficient(int tid, int k) {
	int num_entries_to_move = k - num_ready_entries[tid];
	uwomp_worklist *global_wl_entries_list = NULL;
	uwomp_worklist *entry_to_add = NULL;;

#pragma omp critical
	{
		uwomp_worklist *wl_entry = global_worklist;
		uwomp_worklist *prev_wl_entry = NULL;
		// FIXME: Since we are accessing the global list we need a lock. Where to
		// place it?
		// If there are k entries already in the ready list we should stop.
		// Lock to global worklist
		// TODO: Optimize this
		// Inside global worklist, all entries will be in the same phase.
		// So checking of phases is not required.
		// We can take first num_entries_to_move entries as a list and move the list.
		// TODO: Optmize this by getting the list in O(1) time. We may store the
		// number of entries in the global wl and the  pointers in an array.
		while ((num_entries_to_move > 0) && (wl_entry != NULL)) {
			entry_to_add = NULL;
			// We can add the entry to ready list only if all the clocks for this
			// task_id are in the next phase.
			// Remove this entry from pending_worklist.
			// Case 1: The entry to be removed is the first entry.
			if (wl_entry == global_worklist) {
				global_worklist = wl_entry->next;
				if (wl_entry ->next != NULL)
					wl_entry->next->prev = wl_entry->prev;
				// Entry to be added
				entry_to_add = wl_entry;
				// Get the next entry. Start from the beginning.
				wl_entry = global_worklist;
			}
			// Case 2: It is an intermediate node.
			else {
				//fprintf(stderr, "Inside move_from_global_to_ready: Removing intermediate node\n");
				wl_entry->prev->next = wl_entry->next;
				if (wl_entry ->next != NULL) {
					wl_entry->next->prev = wl_entry->prev;
				} // BUGFIX
				else {
					global_worklist->prev = wl_entry->prev;
				}
				// Entry to be added
				entry_to_add = wl_entry;
				wl_entry = wl_entry->next;
				// Note: prev_wl_entry remains the same.
			}
			// If there is only one entry in the global worklist, fix the previous
			// entry.
			// BUGFIX
			//if (global_worklist != NULL) {
			//	if (global_worklist -> next == NULL) {
			//		global_worklist -> prev = global_worklist;
			//	}
			//}
			// Add the entry to ready worlist.
			// FIXME: Here we are adding a single entry to the local_ready or global
			// work list. Earlier thought of adding it as a list. But it seems
			// populating a list
			// Using the same entry in ready_worklist too. So no need to remove it
			// from pedning worlist.
			if (entry_to_add != NULL) {
				entry_to_add->next = NULL;
				entry_to_add->prev = entry_to_add;
				if (num_entries_to_move > 0) {
					num_entries_to_move--;
					num_ready_entries[tid]++;
					// Here no need to take the lock. So it is fine to add directly to the
					// list.
					if (global_wl_entries_list == NULL) {
						global_wl_entries_list = entry_to_add;
					} else {
						// Here we need to take a lock to add to the global list. So better
						// populate all the entries to a list and add that list at the end.
						// Append the new entry to the end of the list
						global_wl_entries_list->prev->next = entry_to_add;
						entry_to_add->prev = global_wl_entries_list->prev;
						global_wl_entries_list->prev = entry_to_add;
					}
				}
			}
		}
	}
	// Add the global_wl_entries_list to the global worklist.
	if (global_wl_entries_list != NULL)
		uwomp_add_to_local_ready_worklist(global_wl_entries_list);
}


/* Deque one entry from the worklist. This is the fist entry of the
 * worklist of the worker with id tid.
 */
inline void uwomp_remove_local_ready_worklist_entry(int tid) {
	uwomp_worklist *p = ready_worklist[tid];
	if (p != NULL) {
		uwomp_worklist *temp = p;
		ready_worklist[tid] = p -> next;
		if (p -> next != NULL)
			ready_worklist[tid]->prev = p->prev;
		num_ready_entries[tid]--;
		// Freeing the worklist pointer. Not freeing the fields.
		// FIXME: Check if it is fine to free it without freeing the fields?
		//free(temp);
	}
}

inline void uwomp_execute_local_ready_worklist(int tid, int k) {
	/* Get the continuation from the worklist, to be executed.*/
	uwomp_worklist *first_entry = ready_worklist[tid];

	/* Get the continuation env;*/
	__t_cont_env *e = (__t_cont_env *)(first_entry -> contn_env);

	/* Remove the entry */
	uwomp_remove_local_ready_worklist_entry(tid);

	// FIXME: This is just a work around. Move it to the initial continuation.
	//if (e->contn_env != NULL) { // no continuation for e in the current phase
		/* Call the function.*/
		// The third argument is just a place holder for phase_num in case of clock
		uwomp_call_contn_fun(e);
		//e->cont_fn(e->arg_list, e->contn_env, 0);
	//} else {
		//uwomp_clock_drop_all(e->task_id, e->uwomp_task_to_clocks_map);
	//}
	//TODO: Add this as the last continuation called. ie; Add this as the first
	//continuation.
 	// return uwomp_execute_global_worklist(k); -- instead called from uwomp_execute_global_worklist, the caller of  uwomp_execute_local_ready_worklist
}
inline void uwomp_print_pending_worklist() {
  int tid = omp_get_thread_num();
	uwomp_worklist *p = pending_worklist[tid];
	int i = 0;
	fprintf(stderr, "pending worklist entries for tid = %d:\n", tid);
	fprintf(stderr, "--------------------------------------\n", tid);
	while (p != NULL) {
		fprintf(stderr, "    %d: %x contn_env = %x task_id = %d clock_map = %x\n",
				i, p, p->contn_env, p->contn_env->task_id,
				p->contn_env->uwomp_task_to_clocks_map);
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
		fprintf(stderr, "    %d: %x contn_env = %x task_id = %d clock_map = %x\n",
				i, p, p->contn_env, p->contn_env->task_id,
				p->contn_env->uwomp_task_to_clocks_map);
		p = p -> next;
	}
	fprintf(stderr, "\n");
	return;
}


inline void uwomp_print_global_worklist() {
  int tid = omp_get_thread_num();
	uwomp_worklist *p = global_worklist;
	int i = 0;
	fprintf(stderr, "global worklist entries\n");
	fprintf(stderr, "-----------------------\n", tid);
	while (p != NULL) {
		fprintf(stderr, "    %d: %x contn_env = %x task_id = %d clock_map = %x\n",
				i, p, p->contn_env, p->contn_env->task_id,
				p->contn_env->uwomp_task_to_clocks_map);
		p = p -> next;
	}
	fprintf(stderr, "\n");
	return;
}

inline void uwomp_execute_global_worklist(int k) {
  int tid = omp_get_thread_num();

	//done[tid] = 0;
	if (global_worklist == NULL && pending_worklist[tid] == NULL &&
			ready_worklist[tid] == NULL)  {
		done[tid] = 1;

		int i = 0;
		for (i = 0; i < NUM_WORKERS; i++) {
			if (done[i] == 0) {
				//fprintf(stderr, "More work to do by tid = %d my tid = %d\n", i, tid);
				break;
			}
		}

		if (i == NUM_WORKERS)  {
			//fprintf(stderr, "All workers finished their work. tid %d Exiting\n", tid);
			return;
		}
		else {
			//fprintf(stderr, "More work to do\n");
			return uwomp_execute_global_worklist(k);
		}
	}
	// I may have to do more work
	done[tid] = 0;

	// Move possible entries from local pending to ready work-list and global
	// worklist.
	if (pending_worklist[tid] != NULL)  {
		//fprintf(stderr, "More work in pending worklist of tid = %d\n", tid);
		uwomp_move_from_local_pending_to_ready_and_global(tid, k);
		/*
		fprintf(stderr, "After moving from local to ready and global tid = %d\n", tid);
		uwomp_print_pending_worklist();
		uwomp_print_ready_worklist();
		uwomp_print_global_worklist();
		*/
	}

	/* Get the continuation from the worklist, to be executed.*/
	uwomp_worklist *first_entry = ready_worklist[tid];

	if (first_entry != NULL) {
		return uwomp_execute_local_ready_worklist(tid, k);
	} else {
		//fprintf(stderr, "tid = %d, No elements in the ready worklist\n", tid);
		// Call uwomp_execute_global_worklist recursively if there are any pending
		// entries.
		// Here indirectly we are performing a busy wait because, it may be the case
		// that no entries can be moved to ready worklist even now.
		if(global_worklist != NULL)  {
			//fprintf(stderr, "tid = %d, Some elements in the global worklist\n", tid);
			uwomp_move_from_global_to_ready(tid, k);
			/*
			fprintf(stderr, "After moving from global to ready tid = %d\n", tid);
			uwomp_print_pending_worklist();
			uwomp_print_ready_worklist();
			uwomp_print_global_worklist();
			*/
		}
	}
	return uwomp_execute_global_worklist(k);
}

/******** End of work list functions with global ********************/
/*************** End of work list functions ***************************/

/*************** Start of clock functions ***************************/


// Unique id for a clock.
int uwomp_clock_id = 0;
inline int uwomp_get_clock_id() {
	return uwomp_clock_id++;
}

// Add a clock to the clock list.
inline void uwomp_clock_add(uwomp_clock *c) {
	uwomp_clock_list_entry *new_clock_entry =
		malloc(sizeof(uwomp_clock_list_entry));
	new_clock_entry -> c = c;
	new_clock_entry -> next = NULL;

	if (clock_list != NULL) {
		// Insert at the head of the list.
		new_clock_entry -> next = clock_list;
	}
	clock_list = new_clock_entry;
}

// Create a new clock.
// Add it to the clocks list. Return it.
inline uwomp_clock *uwomp_get_clock() {
	uwomp_clock *c;
	c = malloc(sizeof(uwomp_clock));
	c->num_tasks_registered = 0;
	c->phase_num = 0;
	c->num_advances = 0;
	return c;
}

// Allocate memory for the tasks to clocks map.
// The size of the map is the maximum number of tasks. It may be the case that
// a task may not have any clocks registered. In that case the entry would be
// empty.
inline void uwomp_task_to_clocks_map_init(int num_tasks,
		uwomp_clock_list_entry ***p_uwomp_task_to_clocks_map) {
	// calloc is used to  initialize all entries to NULL.
	*p_uwomp_task_to_clocks_map = calloc(num_tasks,
				sizeof(uwomp_clock_list_entry *));
	return;
}

// Register a task on a clock. In UW-OpenMP task is the iteration index.
// TODO: Think about implementing it as a linear scan data structure and see if
// there is any benefit..
inline void uwomp_clock_register(int task_id, uwomp_clock *c,
		uwomp_clock_list_entry **uwomp_task_to_clocks_map) {
	uwomp_task t;
	t.id = task_id;
	// Increment the number of tasks registered on this clock atomically.
	// TODO: Make it atomic once everything else is fixed.
	#pragma omp critical
	{
		c -> num_tasks_registered++;
	}

	// Create a new entry to be added to the map.
	uwomp_clock_list_entry *new_clock_entry =
		malloc(sizeof(uwomp_clock_list_entry));
	new_clock_entry -> c = c;
	new_clock_entry -> phase_num = 0;
	new_clock_entry -> next  = NULL;

	// If this is not the first entry
	if (uwomp_task_to_clocks_map[t.id] != NULL) {
		new_clock_entry -> next  = uwomp_task_to_clocks_map[t.id];
	}
	// Add the entry to the head of the list.
	uwomp_task_to_clocks_map[t.id] = new_clock_entry;
}

inline void uwomp_clock_drop(int task_id, uwomp_clock *c,
		uwomp_clock_list_entry **uwomp_task_to_clocks_map) {
	uwomp_clock_list_entry *clk_entry = uwomp_task_to_clocks_map[task_id];
	uwomp_clock_list_entry *first_entry = uwomp_task_to_clocks_map[task_id];
	uwomp_clock_list_entry *prev_entry;;
	while (clk_entry != NULL) {
		uwomp_clock *clk = clk_entry -> c;
		if (clk == c) {
			if (first_entry == clk_entry) {
				uwomp_task_to_clocks_map[task_id] = clk_entry -> next;
			} else {
				prev_entry -> next = clk_entry -> next;
			}
#pragma omp critical
			{
				c->num_advances++;
				if (c -> num_advances == c -> num_tasks_registered) {
					c->num_advances = 0;
					c->phase_num++;
				}
				c->num_tasks_registered--;
				if(c->num_tasks_registered == 0)  {
					//free(c);
				}
			}
			//free(clk_entry);
			break;
		}
		prev_entry = clk_entry;
		clk_entry = clk_entry -> next;
	}
}

inline void uwomp_clock_drop_all(int task_id,
		uwomp_clock_list_entry **uwomp_task_to_clocks_map) {
	//fprintf(stderr, "Task id = %d tid = %d is calling drop all\n", task_id, omp_get_thread_num());
	uwomp_clock_list_entry *clk_entry = uwomp_task_to_clocks_map[task_id];
	uwomp_clock_list_entry *prev_entry;;
	while (clk_entry != NULL) {
		uwomp_clock *clk = clk_entry -> c;
#pragma omp critical
		{
			clk->num_advances++;
			if (clk -> num_advances == clk -> num_tasks_registered) {
				clk->num_advances = 0;
				clk->phase_num++;
			}
			clk->num_tasks_registered--;
			if(clk->num_tasks_registered == 0) {
				//free(clk);
			}
		}
		prev_entry = clk_entry;
		clk_entry = clk_entry -> next;
		//free(prev_entry);
	}
	uwomp_task_to_clocks_map[task_id] = NULL;
}

// Advance all the clocks registered by the task with task_id by one phase.
// Here it is assumed that no more tasks will be registered on the clocks.
// Note: Ignore phase_num, not used in clock implementation, useful only in
// global barrier (#pragma omp barrier)
inline void uwomp_clock_advance_all(__t_cont_env *new_env, int phase_num) {
	//fprintf(stderr, "Inside uwomp_clock_advance_all\n");
	uwomp_clock_list_entry **uwomp_task_to_clocks_map =
		new_env->uwomp_task_to_clocks_map;
	int task_id = new_env->task_id;
	int tid = omp_get_thread_num();
	// Add the new environment entry to pending work list.
	uwomp_add_to_pending_worklist(new_env, phase_num);
	// Get the clock list head for the task
	uwomp_clock_list_entry *tc_entry = uwomp_task_to_clocks_map[task_id];
	// Iterate over each clock
	while (tc_entry != NULL) {
		uwomp_clock *c = tc_entry -> c;
		// Atomically increment the number of advances.
		// TODO: Make it atomic once everything else is fixed.
		//#pragma omp atomic
		#pragma omp critical
		{
			c->num_advances++;
			// Increment the phase number of this clock for task task_id
			// TODO: FIXME: This may not be in critical. Study about it.
			tc_entry->phase_num++;
		}

		// If c -> num_advances matches with c->num_tasks_registered increment
		// c -> phase_num.
		// FIXME 5: Study about the data races here. Should we do the following inside a
		// critical section or under a lock?
		#pragma omp critical
		{
			if (c -> num_advances == c -> num_tasks_registered) {
				c->num_advances = 0;
				c->phase_num++;
			}
		}

		tc_entry = tc_entry -> next;
	}

	// Execute an entry from the ready worklist.
	uwomp_execute_worklist();
	return;
}

// Advance all the clocks registered by the task with task_id by one phase.
// Here it is assumed that no more tasks will be registered on the clocks.
// Note: Ignore phase_num, not used in clock implementation, useful only in
// global barrier (#pragma omp barrier)
inline void uwomp_clock_advance_all_global_worklist(__t_cont_env *new_env, int phase_num, int task_id, uwomp_clock_list_entry **uwomp_task_to_clocks_map) {
	int k = MAX_ENTRIES_IN_READY_LIST;
	//printf("task_id : %d, map : %u, rec_count = %d, adv_count = %d\n", task_id, uwomp_task_to_clocks_map, local_rec_count, adv_count);
	//fprintf(stderr, "Inside uwomp_clock_advance_all_global_worklist\n");
	//uwomp_clock_list_entry **uwomp_task_to_clocks_map =
		//new_env->uwomp_task_to_clocks_map;
	//if (uwomp_task_to_clocks_map == NULL)
		//return uwomp_execute_global_worklist(k);
	//int task_id = new_env->task_id;
	int tid = omp_get_thread_num();
	// Add the new environment entry to pending work list.
	uwomp_add_to_local_pending_worklist(new_env, phase_num);
	// Get the clock list head for the task
	uwomp_clock_list_entry *tc_entry = uwomp_task_to_clocks_map[task_id];
	// Iterate over each clock
	while (tc_entry != NULL) {
		uwomp_clock *c = tc_entry -> c;
		// Atomically increment the number of advances.
		// TODO: Make it atomic once everything else is fixed.
		//#pragma omp atomic
		#pragma omp critical
		{
			c->num_advances++;
			// Increment the phase number of this clock for task task_id
			// TODO: FIXME: This may not be in critical. Study about it.
			tc_entry->phase_num++;
			//fprintf(stderr, "In advance all incrementing phase_num to %d. task id = %d, tid = %d\n",tc_entry->phase_num,task_id, tid);
		}

		// If c -> num_advances matches with c->num_tasks_registered increment
		// c -> phase_num.
		// FIXME 5: Study about the data races here. Should we do the following inside a
		// critical section or under a lock?

		//fprintf(stderr, "tid = %d Num advances = %d tasks registered = %d task_id = %d v = %d\n",
				//tid, c -> num_advances, c -> num_tasks_registered, task_id, new_env->arg_list[1]);
		#pragma omp critical
		{
			if (c -> num_advances == c -> num_tasks_registered) {
				c->num_advances = 0;
				c->phase_num++;
			}
		}

		tc_entry = tc_entry -> next;
	}

	// Execute an entry from the ready worklist.
	return uwomp_execute_global_worklist(k);
}
/*************** End of clock functions ***************************/

/* This function calls the continuation environment after keeping its feilds in
 * temporories and freeing its memory.
 */
inline void uwomp_call_contn_fun(struct __cont_env *e) {
	//fprintf(stderr, "Calling cont fun\n");
	void (*cont_fn) (void**, struct __cont_env *, int, int,
			uwomp_clock_list_entry **) = e -> cont_fn;
	void **argl = e -> arg_list;
	struct __cont_env *e1 = e->contn_env;
	int phase_num = e -> phase_num;
	int task_id = e -> task_id;
	uwomp_clock_list_entry **task_to_clks = e-> uwomp_task_to_clocks_map;
	free(e); //issue
	(cont_fn)(argl,e1,phase_num, task_id, task_to_clks);
}

void uwomp_first_fun(void** a, struct __cont_env *e , int p) {
}
