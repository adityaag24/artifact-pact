#ifndef WORKLIST_H
#define WORKLIST_H
#include <stdlib.h>
#include <omp.h>
#include <stdio.h>
#include "typeDeclare.h"
void executeReadyWorkList(){
    int tid = omp_get_thread_num();
    int leftPtr = leftPointer[tid];
    int rightPtr = rightPointer[tid];
    int i;
    int chunkSize = rightPtr - leftPtr + 1;
    while(1){
        int done = 0;
        for(i = leftPtr; i <= rightPtr; i++){
            struct Clsr *closure = readyWorkList[i];
            if(closure->typeClosure == NORMAL){
                closure->fptr(closure);
            }else if(closure->typeClosure == WAIT){
                struct WaitClsr *waitClosure = closure->waitClosure;
                waitClosure->waitFunction(closure);
            }
            if(closure->typeClosure==DONE){
                done++;
            }
        }
        if(done == chunkSize){
            break;
        }
    }
}
#endif