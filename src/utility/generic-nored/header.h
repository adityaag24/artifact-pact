#ifndef HEADER_H
#define HEADER_H
#include "typeDeclare.h"
struct Clsr *createClosure(enum typeClsr,void (*fptr)(struct Clsr *));
void incrementCounter(struct HashTable *,int);
int decrementCounter(struct HashTable *,int);
int testAndDecPostbox(int,int);
void postMessage(int, int, void *);
void initialisePostBox(int);
void mySignalAll(int,int,int);
void mySignal(int,int,int *);
void mSignalAll(int,int,void *,int,int,struct Clsr *);
void mSignal(int,int,void *,int,int *,struct Clsr *);
void myWaitAll(int,int,int);
void myWait(int,int, int *);
void mWaitAll(struct Clsr *);
void mWait(struct Clsr *);
void createWaitClosureAll(int,void *(*combine)(struct Msg *,struct Msg *),void (*copy)(void *,void *),void (*alloc)(struct Msg *),void *,void *, int,int,struct Clsr **,int);
void createWaitClosure(int ,void *(*combine)(struct Msg *,struct Msg *),void (*copy)(void *,void *),void (*alloc)(struct Msg *),void *, void *,int, int,int *,struct Clsr **,int);
struct WLQueue *createWorklistQueue();
struct ClsrNode *createClosureNode(struct Clsr *);
int isEmptyWorklist(struct WLQueue *);
void enqueueClosure(struct WLQueue *,struct Clsr *);
struct Clsr *dequeueClosure(struct WLQueue *);
int checkThreadStatus(int *);
void executeReadyWorkList(struct WLQueue *);
void scheduler(struct WLQueue *,int);
void lastFunction(struct Clsr *closure){
    if(closure != (void *)0){
        free(closure);
        closure = (void *)0;
    }
}
#include "Closure.h"
#include "Worklist.h"
#include "Postbox.h"
#include "Wait.h"
#include "Signal.h"
#endif