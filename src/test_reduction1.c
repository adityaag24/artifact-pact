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
void performReduction(struct RedClsr *reductionClosure){
    int i,j;
    int N = reductionClosure->nReductions;
    int limit = ceil(log2(N));
    int itr = 0;
    int s = 1;
    int powerSize = 1 << limit;
    struct Msg **oldMessages = (struct Msg **)malloc(powerSize * sizeof(struct Msg *));
    struct Msg **newMessages = (struct Msg **)malloc(powerSize * sizeof(struct Msg *));
    unsigned messageVoidSize = sizeof((reductionClosure->messages[0])->message);
    unsigned messageStructSize = sizeof(struct Msg);
    #pragma omp parallel for
    for(i = 0;i<powerSize;i++){
        if(oldMessages[i] == NULL){
            oldMessages[i] = (struct Msg *)malloc(messageStructSize);
            newMessages[i] = (struct Msg *)malloc(messageStructSize);
            oldMessages[i]->message = malloc(messageVoidSize);
            newMessages[i]->message = malloc(messageVoidSize);
        }
        if(i < N){
            void *toMessage = oldMessages[i]->message;
            void *fromMessage = reducer[i]->message;
            reductionClosure->copyFunction(fromMessage,toMessage);
        }else{
            *((int *)oldMessages[i]->message) = 0;
            *((int *)newMessages[i]->message) = 0;
        }
    }
    struct Msg message1,message2;
    while(itr < limit){
        #pragma omp parallel for
        for(i = 0;i<powerSize;i++){
            int temp1 =  i / s;
            int direction = (temp1 % 2 == 0)?+s:-s;
            int startIdx = i,endIdx = i + direction;
            struct Msg *message1 = oldMessages[startIdx];
            struct Msg *message2 = oldMessages[endIdx];
            void *fromMessage = reductionClosure->redFunction(message1,message2);
            void *toMessage = newMessages[i]->message;
            reductionClosure->copyFunction(fromMessage,toMessage);
        }
        #pragma omp parallel for
        for(i = 0;i<powerSize;i++){
            void *fromMessage = newMessages[i]->message;
            void *toMessage = oldMessages[i]->message;
            reductionClosure->copyFunction(fromMessage,toMessage);
        }
        s = s * 2;
        itr++;
    }
    #pragma omp parallel for
    for(i = 0;i<N;i++){
        void *fromMessage = newMessages[i]->message;
        void *toMessage = (reducer[i])->message;
        reductionClosure->copyFunction(fromMessage,toMessage);
    }
}
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
void mWaitSignalAll(struct RedClsr *reductionClosure){
    int nReductions = reductionClosure->nReductions + 1;
    int limit = ceil(log2(nReductions));
    int N = 1 << limit;
    int i;
    if(reducer == NULL){
        reducer = (struct Msg **)malloc(N * sizeof(struct Msg *));
    }
    #pragma omp for
    for(i = 0;i<nReductions;i++){
        if(reducer[i] == NULL){
            reducer[i] = (struct Msg *)malloc(sizeof(struct Msg));
        }
        reducer[i] = reductionClosure->messages[i];
    }
    performReduction(reductionClosure);
    struct Msg *message = reducer[0];
    void *messagePtr = message->message;
    printf("Result = %d\n",*((int *)messagePtr));
    reductionClosure->copyFunction(messagePtr,reductionClosure->reductionVariable);
    free(reducer);
    reducer = NULL;
}
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