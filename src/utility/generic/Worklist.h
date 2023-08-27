#ifndef WORKLIST_H
#define WORKLIST_H
#include <stdlib.h>
#include <omp.h>
#include <stdio.h>
struct WLQueue *createWorklistQueue(){
    struct WLQueue *workListQueue = (struct WLQueue *)malloc(sizeof(struct WLQueue));
    workListQueue->front = NULL;
    workListQueue->rear = NULL;
    return workListQueue;
}
struct ClsrNode *createClosureNode(struct Clsr *closure){
    struct ClsrNode *closureNode = (struct ClsrNode *)malloc(sizeof(struct ClsrNode));
    closureNode->closure = closure;
    closureNode->next = NULL;
    return closureNode;
}
int isEmptyWorklist(struct WLQueue *workListQueue){
    if(workListQueue->front==(void *)0){
        return 1;
    }
    return 0;
}
void enqueueClosure(struct WLQueue *queue,struct Clsr *closure){
    struct ClsrNode *closureNode = createClosureNode(closure);
    if(isEmptyWorklist(queue)){
        queue->front = closureNode;
        queue->rear = closureNode;
        return;
    }
    queue->rear->next = closureNode;
    queue->rear = closureNode;
}
struct Clsr *dequeueClosure(struct WLQueue *queue){
    if(isEmptyWorklist(queue)){
        return NULL;
    }
    struct ClsrNode *closureNode = queue->front;
    struct Clsr *closure = closureNode->closure;
    if(queue->front == queue->rear){
        queue->front = queue->rear = (void *)0;
    }else{
        queue->front = queue->front->next;
    }
    return closure;
}


void executeReadyWorkList(struct WLQueue *readyWorkList){
    while(!isEmptyWorklist(readyWorkList)){
        struct Clsr *closure = dequeueClosure(readyWorkList);
        if(closure == NULL){
            return;
        }
        if(closure->typeClosure == NORMAL){
            closure->fptr(closure);
        }else if (closure->typeClosure==WAIT){
             struct WaitClsr  *waitClsr = closure->waitClosure;
            waitClsr->waitFunction(closure);
        }
    }
}

void scheduler(struct WLQueue *readyWorklist,int K){
    while(1){
        int isEmptyGlobalWorklist = isEmptyWorklist(globalWorklist);
        if(isEmptyGlobalWorklist){
            break;
        }else{
            int count = K;
            int clsrPushed = 0;
            while(count--){
                struct Clsr *closure;
#pragma omp critical
{
                closure = dequeueClosure(globalWorklist);
}
                if(closure==NULL){
                    break;
                }
                clsrPushed = 1;
                enqueueClosure(readyWorklist,closure);
            }
            if(clsrPushed){
                executeReadyWorkList(readyWorklist);
            }else{
                break;
            }
        }
    }
}
#endif