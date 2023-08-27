#ifndef HEADER_H
#define HEADER_H
#include "typeDeclare.h"
struct Clsr *createClosure(enum typeClsr,void (*fptr)(struct Clsr *));
void ALLOCINT(struct Msg *);
void ALLOCDOUBLE(struct Msg *);
void ALLOCFLOAT(struct Msg *);
void ALLOCCHAR(struct Msg *);
void COPYINT(void *,void *);
void COPYFLOAT(void *,void *);
void COPYDOUBLE(void *,void *);
void COPYCHAR(void *,void *);
void *ADDINT(struct Msg *, struct Msg *);
void *ADDFLOAT(struct Msg *, struct Msg *);
void *ADDCHAR(struct Msg *, struct Msg *);
void *ADDDOUBLE(struct Msg *, struct Msg *);
void *SUBINT(struct Msg *, struct Msg *);
void *SUBFLOAT(struct Msg *, struct Msg *);
void *SUBCHAR(struct Msg *, struct Msg *);
void *SUBDOUBLE(struct Msg *, struct Msg *);
void *MULINT(struct Msg *, struct Msg *);
void *MULFLOAT(struct Msg *, struct Msg *);
void *MULCHAR(struct Msg *, struct Msg *);
void *MULDOUBLE(struct Msg *, struct Msg *);
struct Msg *createMessage(void *);
struct QueueNode *createNode(void *);
struct QueueStruct *createQueue();
int isEmpty(struct QueueStruct *);
struct Msg *deQueueMessage(struct QueueStruct *);
struct Msg *peekQueue(struct QueueStruct *);
void enQueueMessage(struct QueueStruct *,void *);
void incrementCounter(int,int);
void decrementCounter(int,int);
int testAndDecPostbox(int,int);
void deQueueFromQueue(int);
struct Msg *receiveMessageAll(int);
struct Msg *receiveMessage(int,int);
void postMessage(int,int,void *);
void initialisePostBox(int,int);
void mySignalAllSend(int,void *,int,int);
void mySignalAll(int,int,int);
void mySignalSend(int,void *,int, int *);
void mySignal(int,int,int *);
void mSignalAllReduce(int,int,void *,int,int,struct Clsr *);
void signalWrapper(struct Clsr *);
void setupReduction(struct Clsr *);
void mSignalAll(int,int,void *,int,int,struct Clsr *);
void mSignal(int,int,void *,int,int *,struct Clsr *);
void *COPY(void *,void*);
void *ADD(void *,void*);
void *SUB(void *,void*);
void *MUL(void *,void*);
void myWaitAll(int,int,int);
void myWait(int,int, int *);
void myWaitRed(int,void *,void *,int,int *,void *(*fptr)(void *,void *));
void myWaitAllRed(int,void *,void *,int,int,void *(*fptr)(void *,void *));
void cleanup(struct Clsr *);
void handleReduction(struct Clsr *);
void waitWrapper(struct Clsr *);
void mWaitAll(struct Clsr *);
void mWait(struct Clsr *);
void buildReductionClosure(struct WaitClsr **,int,int,void *,void *,void *(*combine)(struct Msg *,struct Msg *),void (*copy)(void *,void *), void (*alloc)(struct Msg *));
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