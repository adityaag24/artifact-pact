#ifndef WAIT_H
#include <math.h>
#define WAIT_H
#define WAIT(x, ...) {int wxyz = 0; if(x){int p[]={__VA_ARGS__}; int n_iters = sizeof(p)/sizeof(p[0]); int *q =(int *) malloc(n_iters * sizeof(int)); int i_ivp = 0; for(i_ivp=0;i_ivp<n_iters;i_ivp++) q[i_ivp] = p[i_ivp]; myWait(x,n_iters, q);}}
#define WAITALL(x) {int wxyz = 0; if(x){myWaitAll(x,0,0);}}
void myWaitAll(int x,int start,int end){
    return;
}
void myWait(int x,int N, int *p){
    return;
}
void mWaitAll(struct Clsr *closure){
    int i;
    struct WaitClsr *waitClosure = closure->waitClosure;
    int currentIteration = waitClosure->currentIteration;
    int startRange = waitClosure->startRange;
    int endRange = waitClosure->endRange;
    int check = 1; //0 - none, 1 - present 
    for(i=startRange;i<=endRange;i++){
        int waitIteration = i;
        int checkWaitItrPostBox = testAndDecPostbox(currentIteration,waitIteration);
        if(checkWaitItrPostBox == 0){
            check = 0;
            break;
        }
    }
    if(check==0){
        closure->waitClosure->startRange = i;
#pragma omp critical
{
        enqueueClosure(globalWorklist,closure);
}
    }else{
        closure->typeClosure = NORMAL;
        closure->waitClosure->startRange = startRange_ivp17;
        closure->fptr(closure);
    }
}
void mWait(struct Clsr *closure){
    int i;
    struct WaitClsr *waitClosure = closure->waitClosure;
    int check = 1; //0 - none, 1 - present
    int start = waitClosure->start;
    int nIters = waitClosure->n_iters;
    int *waitIterations = waitClosure->waitIterations;
    int currentIteration = waitClosure->currentIteration;
    for(i=start;i<nIters;i++){
        int waitIteration = waitIterations[i];
        if(waitIteration < startRange_ivp17 || waitIteration > endRange_ivp17){
            continue;
        }
        int checkWaitItrPostBox = testAndDecPostbox(currentIteration,waitIteration);
        if(checkWaitItrPostBox == 0){
            check = 0;  
            break;
        }
    }
    if(check==0){
        closure->waitClosure->start = i;
#pragma omp critical
{
        enqueueClosure(globalWorklist,closure);
}
    }else{
        closure->typeClosure = NORMAL;
        closure->waitClosure->start = 0;
        closure->fptr(closure);
    }
}
void createWaitClosureAll(int currentIteration,
                        void *(*combine)(struct Msg *,struct Msg *),
                        void (*copy)(void *,void *),
                        void (*alloc)(struct Msg *),
                        void *resultVariable,
                        void *initialValue,
                        int startRange,
                        int endRange,
                        struct Clsr **closure,
                        int expr){
    int n_iters = endRange - startRange + 1;
    struct WaitClsr *waitClosure = ( struct WaitClsr  *)malloc(sizeof( struct WaitClsr ));
    waitClosure->currentIteration = currentIteration;
    waitClosure->expr = expr;
    waitClosure->startRange = startRange;
    waitClosure->endRange = endRange;
    waitClosure->n_iters = n_iters;
    waitClosure->waitFunction = &mWaitAll;
    (*closure)->waitClosure = waitClosure;
    (*closure)->typeClosure = WAIT;
    (*closure)->waitClosure->waitFunction(*closure);
}
void createWaitClosure(int currentIteration, 
                        void *(*combine)(struct Msg *,struct Msg *),
                        void (*copy)(void *,void *),
                        void (*alloc)(struct Msg *),
                        void *resultVariable, 
                        void *initialValue,
                        int start, 
                        int n_iters,
                        int *waitIterations,
                        struct Clsr **closure,
                        int expr){
    struct WaitClsr *waitClosure = (struct WaitClsr *)malloc(sizeof(struct WaitClsr));
    waitClosure->currentIteration = currentIteration;
    waitClosure->start = start;
    waitClosure->expr = expr;
    waitClosure->n_iters = n_iters;
    waitClosure->waitIterations = waitIterations;
    waitClosure->waitFunction = &mWait;
    (*closure)->waitClosure = waitClosure;
    (*closure)->typeClosure = WAIT;
    (*closure)->waitClosure->waitFunction(*closure);
}
#endif
