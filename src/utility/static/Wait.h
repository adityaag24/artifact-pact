#ifndef WAIT_H
#define WAIT_H
#include "typeDeclare.h"
#define WAITALL(x) {int wxyz = 0; myWaitAll(x);}
void myWaitAll(int x){
    return;
}
void mWaitAll(struct Clsr *closure){
    int tid = omp_get_thread_num();
    int currentIteration = closure->waitClosure->currentIteration;
    if(currentIteration == rightPointer[tid]){
#pragma omp barrier
        closure->typeClosure = NORMAL;
    }else{
        closure->typeClosure = NORMAL;
    }
}
void executeWaitClosureAll(struct Clsr *closure){
    mWaitAll(closure);
}
struct WaitClsr *createWaitClosureAll(int currentIteration,
                                                                struct Clsr *closure){
    struct WaitClsr *waitClosure = ( struct WaitClsr  *)malloc(sizeof( struct WaitClsr ));
    waitClosure->currentIteration = currentIteration;
    waitClosure->waitFunction = &executeWaitClosureAll;
    return waitClosure;
}
#endif
