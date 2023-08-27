#ifndef WAIT_H
#include <math.h>
#define WAIT_H
#define WAIT(x, ...) {int wxyz = 0; if(x){int p[]={__VA_ARGS__}; int n_iters = sizeof(p)/sizeof(p[0]); int *q =(int *) malloc(n_iters * sizeof(int)); int i_ivp = 0; for(i_ivp=0;i_ivp<n_iters;i_ivp++) q[i_ivp] = p[i_ivp]; myWait(x,n_iters, q);}}
#define WAITRED(x,y,f,...) { void *redVar = &y; void *initialValue = 0;if(x){int wxyz = 0; int p[] = {__VA_ARGS__}; int n_iters = sizeof(p)/sizeof(p[0]); int *q = (int *)malloc(n_iters * sizeof(int));  int i_ivp = 0;for(i_ivp=0;i_ivp<n_iters;i_ivp++) q[i_ivp] = p[i_ivp]; myWaitRed(x,redVar,initialValue, n_iters,q,f);}}
#define WAITALLRED(x,y,f) {void *redVar = &y; void *initialValue = 0;if(x){int wxyz = 0; myWaitAllRed(x,redVar,initialValue,0,0,f);}}
#define WAITALL(x) {int wxyz = 0; if(x){myWaitAll(x,0,0);}}
void *COPY(void *a,void *redClsr){
    return 0;
}
void *ADD(void *a,void *b){
    return 0;
}
void *SUB(void *a,void *b){
    return 0;
}
void *MUL(void *a,void *b){
    return 0;
}
void myWaitAll(int x,int start,int end){
    return;
}
void myWait(int x,int N, int *p){
    return;
}
void myWaitRed(int x,void *reductionVariable,void *initialValue, int N,int *p,void *(*fptr)(void *m1, void *m2)){
    return;
}
void myWaitAllRed(int x,void *reductionVariable,void *initialValue, int start,int end, void *(*fptr)(void *m1, void *m2)){
    return;
}
void cleanup(struct Clsr *closure){
    closure->fptr(closure);
}
void copyValue(struct Clsr *closure){
    struct WaitClsr *waitClosure = closure->waitClosure;
    struct RedClsr *reductionClosure = waitClosure->reductionClosure;
    int currentIteration = reductionClosure->iteration;
    void *fromMessage = newMessages[currentIteration]->message;
    void *toMessage = oldMessages[currentIteration]->message;
    reductionClosure->copyFunction(fromMessage,toMessage);
    reductionClosure->stride = (reductionClosure->stride) * 2;
    (reductionClosure->reductionIter)++;
    closure->fptr = &handleReduction;
    signalWrapper(closure);
}
void handleReduction(struct Clsr *closure){
    struct WaitClsr *waitClosure = closure->waitClosure;
    int iteration = waitClosure->currentIteration;
    struct RedClsr *reductionClosure = waitClosure->reductionClosure;
    int limit = reductionClosure->limit;
    int reductionIter = reductionClosure->reductionIter;
    int s = reductionClosure->stride;
    int powerSize = reductionClosure->powerSize;
    if(reductionIter < limit){
        int idx = iteration - startRange_ivp17;
        int temp1 = idx / s;
        int direction = (temp1 % 2 == 0)?s:-s;
        int startIdx = iteration,endIdx = iteration + direction;
        struct Msg *message1 = oldMessages[startIdx];
        struct Msg *message2 = oldMessages[endIdx];
        void *fromMessage = reductionClosure->reductionFunction(message1,message2);
        void *toMessage = newMessages[startIdx]->message;
        reductionClosure->copyFunction(fromMessage,toMessage);
        closure->fptr = &copyValue;
        signalWrapper(closure);
    }else{
        struct Msg *fromMessage = newMessages[iteration];
        struct Msg *toMessage = reductionClosure->resultVariable;
        void *resultMessage = reductionClosure->reductionFunction(fromMessage,toMessage);
        void *toFinalMessage = reductionClosure->resultVariable->message;
        reductionClosure->copyFunction(resultMessage,toFinalMessage);
        closure->fptr = closure->tfptr;
        closure->fptr(closure);
    }
}
void setupReduction(struct Clsr *closure){
    struct WaitClsr *waitClosure = closure->waitClosure;
    struct RedClsr *reductionClosure = waitClosure->reductionClosure;
    int currentIteration = reductionClosure->iteration;
    oldMessages[currentIteration] = receiveMessage(currentIteration,currentIteration);
    newMessages[currentIteration] = (struct Msg *)calloc(1,sizeof(struct Msg));
    reductionClosure->allocFunction(newMessages[currentIteration]);
    closure->tfptr = closure->fptr;
    closure->fptr = &handleReduction;
    signalWrapper(closure);
}
void waitWrapper(struct Clsr *closure){
    int i;
    struct WaitClsr *waitClosure = closure->waitClosure;
    struct RedClsr *reductionClosure = waitClosure->reductionClosure;
    int currentIteration = reductionClosure->iteration;
    int nIters = waitClosure->n_iters;
    int startRange = waitClosure->startRange;
    int endRange = waitClosure->endRange;
    int check = 0; //0 - none, 1 - present 
    for(i=startRange;i<=endRange;i++){
        int waitIteration = i;
        int checkWaitItrPostBox = checkPostbox(currentIteration,waitIteration);
        if(checkWaitItrPostBox > 0){
            check = 1;
        }else{
            check = 0;
            break;
        }
    }
    if(check == 0){
        closure->typeClosure = WAIT;
        closure->waitClosure->startRange = i;
        closure->waitClosure->waitFunction = &waitWrapper;
        enqueueClosure(globalWorklist,closure);
    }else{
        closure->waitClosure->startRange = startRange_ivp17;
        closure->typeClosure = NORMAL;
        closure->fptr(closure);
    }
}
void mWaitAll(struct Clsr *closure){
    int i;
    struct WaitClsr *waitClosure = closure->waitClosure;
    struct RedClsr *reductionClosure = 0;
    if(waitClosure->reductionClosure!=0){
        reductionClosure = waitClosure->reductionClosure;
    }
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
        if(reductionClosure!=0){
            void *messageOperand1 = receiveMessage(currentIteration,waitIteration);
            void *messageOperand2 = reductionClosure->resultVariable;
            void *result = reductionClosure->reductionFunction(messageOperand1,messageOperand2);
            void *fromMessage = result;
            void *toMessage = messageOperand2;
            reductionClosure->copyFunction(fromMessage,toMessage);
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
    struct RedClsr *reductionClosure = 0;
    struct WaitClsr *waitClosure = closure->waitClosure;
    if(waitClosure->reductionClosure!=0){
        reductionClosure = waitClosure->reductionClosure;
    }
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
        if(reductionClosure!=0){
            void *messageOperand1 = receiveMessage(currentIteration,waitIteration);
            void *messageOperand2 = reductionClosure->resultVariable;
            void *result = reductionClosure->reductionFunction(messageOperand1,messageOperand2);
            void *fromMessage = result;
            void *toMessage = messageOperand2;
            reductionClosure->copyFunction(fromMessage,toMessage);
        }
    }
    if(check==0){
        closure->waitClosure->start = i;
#pragma omp critical
        enqueueClosure(globalWorklist,closure);
    }else{
        closure->typeClosure = NORMAL;
        closure->waitClosure->start = 0;
        closure->fptr(closure);
    }
}
void buildReductionClosure(struct WaitClsr **waitClosure, int currentIteration, int nIters, void *resultVariable, void *initialValue, void *( *combine )(void *, void *) , void ( *copy )(void *, void *) , void ( *alloc )(void *)){
    struct RedClsr *reductionClosure = (struct RedClsr *)malloc(sizeof(struct RedClsr));
    int limit = ceil(log2(nIters));
    int powerSize = 1 << limit;
    reductionClosure->iteration = currentIteration;
    reductionClosure->nReductions = nIters;
    reductionClosure->limit = limit;
    reductionClosure->powerSize = powerSize;
    reductionClosure->stride = 1;
    reductionClosure->reductionIter = 0;
    reductionClosure->resultVariable = resultVariable;
    reductionClosure->copyFunction = copy;
    reductionClosure->reductionFunction = combine;
    reductionClosure->allocFunction = alloc;
    void *fromMessage = initialValue;
    void *toMessage = reductionClosure->resultVariable;
    reductionClosure->copyFunction(fromMessage,toMessage);
    (*waitClosure)->reductionClosure = reductionClosure;
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
    if(combine!=0){
        int limit = ceil(log2(n_iters));
        int powerSize = 1 << limit;
        buildReductionClosure(&waitClosure,currentIteration,n_iters,resultVariable,initialValue,combine,copy,alloc);
    }else{
        waitClosure->reductionClosure = (void *)0;
    }
    (*closure)->waitClosure = waitClosure;
    (*closure)->typeClosure = WAIT;
    (*closure)->waitClosure->waitFunction(*closure);
}
void createWaitClosure(int currentIteration, 
                        void *(*combine)(struct Msg *,struct Msg *),
                        void (*copy)(void *,void *),
                        void (*alloc)(void *),
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
    waitClosure->reductionClosure = (void *)0;
    if(combine!=0){
        buildReductionClosure(&waitClosure,currentIteration,n_iters,resultVariable,initialValue,combine,copy,alloc);
    }else{
        waitClosure->reductionClosure = (void *)0;
    }
    (*closure)->waitClosure = waitClosure;
    (*closure)->typeClosure = WAIT;
    (*closure)->waitClosure->waitFunction(*closure);
}
#endif
