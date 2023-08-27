#ifndef TYPEDECLARE_H
#define TYPEDECLARE_H
#include <omp.h>
enum typeClsr{
    NORMAL,
    REDUCTION,
    WAIT
};
struct Clsr;
struct WaitClsr{
    int currentIteration;
    int expr;
    int n_iters;
    int start;      
    int startRange;
    int endRange;
    int *waitIterations;
    struct RedClsr *reductionClosure;
    void (*waitFunction)(struct Clsr *);
};
struct RedClsr{
    int nReductions;
    int iteration;
    int reductionIter;
    int stride;
    int limit;
    long powerSize;
    void (*copyFunction)(void *,void *);
    void (*allocFunction)(void *);
    void *(*reductionFunction)(void *,void *);
    void *resultVariable;
};
struct master_env;
struct Clsr{
    void (*fptr)(struct Clsr *);
    void (*tfptr)(struct Clsr *);
    enum typeClsr typeClosure;
    struct master_env *environment;
    struct WaitClsr *waitClosure;
    struct Clsr *continuation;
};
struct QueueNode{
    void *message;
    struct QueueNode *next;
};
struct QueueStruct{
    struct QueueNode *front,*rear;
};
struct ClsrNode{
    struct Clsr *closure;
    struct ClsrNode *next;
};
struct WLQueue{
    struct ClsrNode *front,*rear;
};
struct CommStruct{
    omp_lock_t lock;
    struct QueueStruct *messages;
};
struct PostBoxStruct{
    struct CommStruct *communicators;
};
struct WLQueue *globalWorklist;
void **oldMessages,**newMessages;
int K;
int threadStatus[2048];
int startRange_ivp17;
int endRange_ivp17;
void (*continuationFunctionPointer)(struct Clsr *);
#endif