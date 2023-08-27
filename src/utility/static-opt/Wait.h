#ifndef WAIT_H
#define WAIT_H
#include "typeDeclare.h"
#include "Worklist.h"
#define WAITALL(x) {int wxyz = 0; myWaitAll(x);}
void myWaitAll(int x){
    return;
}
void mWaitAll(struct Clsr *closure){
    int tid = omp_get_thread_num();
    int currentIteration = closure->iteration;
    if(currentIteration == rightPointer[tid]){
#pragma omp barrier
        closure->typeClosure = NORMAL;
    }else{
        closure->typeClosure = NORMAL;
    }
}
#endif
