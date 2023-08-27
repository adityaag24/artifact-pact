#include <stdio.h>
#include <stdlib.h>
#include <math.h>
struct Msg{
    void *message;
};
struct Msg **reducer;
struct RedClsr{
    int nReductions;
    int iteration;
    struct Msg **messages;
    void (*copyFunction)(void *,void *);
    void *(*redFunction)(struct Msg *,struct Msg *);
    void *reductionVariable;
};
void COPYINT(void *fromMessage, void *toMessage){
    int messageValue = *((int *)fromMessage);
    *((int *)toMessage) = messageValue;
}
void *ADDINT(struct Msg *message1,struct Msg *message2){
    int val1 = *(int *)(message1->message);
    int val2 = *(int *)(message2->message);
    int *res = (int *)malloc(sizeof(int));
    *res = val1 + val2;
    return res;
}
void performReduction(struct RedClsr *reductionClosure){
    int currentIteration = reductionClosure->iteration;
    int stride = reductionClosure->stride;
    int temp1 =  currentIteration / stride;
    int direction = (temp1 % 2 == 0)?+s:-s;
    int startIdx = currentIteration,endIdx = currentIteration + direction;
    struct Msg *message1 = oldMessages[startIdx];
    struct Msg *message2 = oldMessages[endIdx];
    void *fromMessage1 = reductionClosure->redFunction(message1,message2);
    void *toMessage1 = newMessages[currentIteration]->message;
    reductionClosure->copyFunction(fromMessage1,toMessage1);
    void *fromMessage2 = newMessages[currentIteration]->message;
    void *toMessage2 = oldMessages[currentIteration]->message;
    reductionClosure->copyFunction(fromMessage2,toMessage2);
    
}
void deallocateMemoryForReduction(int i, struct Clsr *closure){
    struct Msg *message = newMessages[i];
    void *messagePtr = message->message;
    reductionClosure->copyFunction(messagePtr,reductionClosure->reductionVariable);
    free(oldMessages);
    free(newMessages);
    oldMessages = NULL;
    newMessages = NULL;
}
void mWaitSignalAll(struct Clsr *closure){
    struct WaitClsr *waitClosure = closure->waitClosure;
    allocateMemoryForReduction(waitClosure);
}
/*
 * 
*/
int main(){
    int N = 8;
    struct RedClsr *reductionClosure = (struct RedClsr *)malloc(sizeof(struct RedClsr));
    reductionClosure->redFunction = ADDINT;
    reductionClosure->copyFunction = COPYINT;
    reductionClosure->messages = (struct Msg **)malloc(sizeof(struct Msg *) * N);
    reductionClosure->nReductions = N;
    int i;
    int x;
    int *x_ptr = (int *)malloc(sizeof(int));
    reductionClosure->reductionVariable = x_ptr;
    for(i=0;i<N;i++){
        int *val = (int *)malloc(sizeof(int));
        *val = i;
        if(reductionClosure->messages[i] == NULL){
            reductionClosure->messages[i] = (struct Msg *)malloc(sizeof(struct Msg));
        }
        (reductionClosure->messages[i])->message = val;
    }
    mWaitSignalAll(reductionClosure);
    x = *((int *)reductionClosure->reductionVariable);
    printf("Reduced Value x = %d\n",x);
}