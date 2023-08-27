#ifndef POSTBOX_H
#define POSTBOX_H
#include <omp.h>
#include "typeDeclare.h"
struct PostBoxStruct *postbox_ivp17;
struct CommStruct *comm_ivp17;
void ALLOCINT(struct Msg *message){
    message->message = (int *)calloc(1,sizeof(int));
}
void ALLOCFLOAT(struct Msg *message){
    message->message = (float *)calloc(1,sizeof(float));
}
void ALLOCDOUBLE(struct Msg *message){
    message->message = (double *)calloc(1,sizeof(double));
}
void ALLOCCHAR(struct Msg *message){
    message->message = (char *)calloc(1,sizeof(char));
}
void COPYINT(void *fromMessage, void *toMessage){
    int messageValue = *((int *)fromMessage);
    if(toMessage == (void *)0){
        toMessage = (int *)calloc(1,sizeof(int));
    }
    *((int *)toMessage) = messageValue;
}
void COPYFLOAT(void *fromMessage, void *toMessage){
    float messageValue = *((float *)fromMessage);
    if(toMessage == (void *)0){
        toMessage = (float *)calloc(1,sizeof(float));
    }
    *((float *)toMessage) = messageValue;
}
void COPYDOUBLE(void *fromMessage, void *toMessage){
    double messageValue = *((double *)fromMessage);
    if(toMessage == (void *)0){
        toMessage = (double *)calloc(1,sizeof(double));
    }
    *((double *)toMessage) = messageValue;
}
void COPYCHAR(void *fromMessage, void *toMessage){
    char messageValue = *((char *)fromMessage);
    if(toMessage == (void *)0){
        toMessage = (char *)calloc(1,sizeof(char));
    }
    *((char *)toMessage) = messageValue;
}
void *ADDINT(struct Msg *message1,struct Msg *message2){
    int val1,val2;
    if(message1 == (void *)0){
        val1 = 0;
    }else{
        val1 = *(int *)(message1->message);
    }
    if(message2 == (void *)0){
        val2 = 0;
    }else{
        val2 = *(int *)(message2->message);
    }
    int *res = (int *)malloc(sizeof(int));
    *res = val1 + val2;
    return res;
}
void *ADDFLOAT(struct Msg *message1,struct Msg *message2){
    float val1,val2;
    if(message1 == (void *)0){
        val1 = 0.0f;
    }else{
        val1 = *(float *)(message1->message);
    }
    if(message2 == (void *)0){
        val2 = 0.0f;
    }else{
        val2 = *(float *)(message2->message);
    }
    float *res = (float *)malloc(sizeof(float));
    *res = val1 + val2;
    return res;
}
void *ADDDOUBLE(struct Msg *message1,struct Msg *message2){
    double val1,val2;
    if(message1 == (void *)0){
        val1 = 0.0;
    }else{
        val1 = *(double *)(message1->message);
    }
    if(message2 == (void *)0){
        val2 = 0.0;
    }else{
        val2 = *(double *)(message2->message);
    }
    double *res = (double *)malloc(sizeof(double));
    *res = val1 + val2;
    return res;
}
void *SUBINT(struct Msg *message1,struct Msg *message2){
    return ADDINT(message1,message2);
}
void *SUBFLOAT(struct Msg *message1,struct Msg *message2){
    return ADDFLOAT(message1,message2);
}
void *SUBDOUBLE(struct Msg *message1,struct Msg *message2){
    return ADDDOUBLE(message1,message2);
}
void *MULINT(struct Msg *message1,struct Msg *message2){
    int val1,val2;
    if(message1 == (void *)0){
        val1 = 0;
    }else{
        val1 = *(double *)(message1->message);
    }
    if(message2 == (void *)0){
        val2 = 0;
    }else{
        val2 = *(double *)(message2->message);
    }
    int *res = (int *)malloc(sizeof(int));
    *res = val1 * val2;
    return res;
}
void *MULFLOAT(struct Msg *message1,struct Msg *message2){
    float val1,val2;
    if(message1 == (void *)0){
        val1 = 0.0f;
    }else{
        val1 = *(float *)(message1->message);
    }
    if(message2 == (void *)0){
        val2 = 0.0f;
    }else{
        val2 = *(float *)(message2->message);
    }
    float *res = (float *)malloc(sizeof(float));
    *res = val1 * val2;
    return res;
}
void *MULDOUBLE(struct Msg *message1,struct Msg *message2){
    double val1,val2;
    if(message1 == (void *)0){
        val1 = 0.0f;
    }else{
        val1 = *(double *)(message1->message);
    }
    if(message2 == (void *)0){
        val2 = 0.0f;
    }else{
        val2 = *(double *)(message2->message);
    }
    double *res = (double *)malloc(sizeof(double));
    *res = val1 * val2;
    return res;
}
struct QueueNode *createNode(void *message){
    /*
        Creates a Queue Node with the required message and type arguements.
        Parameters
            message (void *): Void Pointer
        Returns
            Queue Node Pointer
    */
    void *msg = message;
    struct QueueNode *tempNode = (struct QueueNode *)malloc(sizeof(struct QueueNode));
    if(tempNode==0){
        printf("Couldn't create Queue Node.\n");
        return 0;
    }else{
        tempNode->message = msg;
        tempNode->next = 0;
        return tempNode;
    }
}
struct QueueStruct *createQueue(){
    /*
        This method creates a Queue Object.
        Parameters
            None
        Returns
            Queue object
    */
    struct QueueStruct *queue = (struct QueueStruct *)malloc(sizeof(struct QueueStruct));
    if(queue==0){
        printf("Couldn't create Queue.\n");
        return 0;
    }else{
        queue->front = 0;
        queue->rear = 0;
        return queue;
    }
}
int isEmpty(struct QueueStruct *queue){
    if(queue==0){
        return 1;
    }
    if(queue->front==0){
        return 1;
    }
    return 0;
}
void *deQueueMessage(struct QueueStruct *queue){
     if(isEmpty(queue)){
        return 0;
    }
    struct QueueNode *qNode = queue->front;
    queue->front = queue->front->next;
    if(queue->front == (void *)0){
        queue->rear = (void *)0;
    }
    void *msg = qNode->message;
    free(qNode);
    return msg;
}
void enQueueMessage(struct QueueStruct *queue, void *message){
    struct QueueNode *newNode = createNode(message);
    if(isEmpty(queue)){
        queue->front=newNode;
        queue->rear=newNode;
        return;
    }
    queue->rear->next = newNode;
    queue->rear = newNode;
}
int testAndDecPostbox(int currentIteration, int waitIteration){
    void *message = receiveMessage(currentIteration,waitIteration);
    return 0;
}
void *receiveMessage(int receiver,int sender){
    struct CommStruct communicator = postbox_ivp17[receiver].communicators[sender];
    struct QueueStruct *messages = communicator.messages;
    while(!omp_test_lock(&(postbox_ivp17[receiver].communicators[sender].lock)));
    void *message = deQueueMessage(messages);
    omp_unset_lock(&(postbox_ivp17[receiver].communicators[sender].lock));
    return message;
}
void postMessage(int from, int to, void *message){
    /*
        This method is used to post a message from an iteration to 
        another iteration.
        Parameters
            postbox_ivp17 (PostBox **) : The PostBox Object
            from (int) : Integer
            to (int) : Integer
            type (TYPE) : Type of Primitive
            message (void *) : Message
        Returns
            void 
    */
    while(!omp_test_lock(&(postbox_ivp17[to].communicators[from].lock)));
    incrementCounter(from,to);
    if(message!=(void *)0){
        enQueueMessage(postbox_ivp17[to].communicators[from].messages,message);
    }
    omp_unset_lock(&(postbox_ivp17[to].communicators[from].lock));
}
void initialisePostBox(int i,int n_c){
    /*
        Parameters
            n_p (int) : The number of iterations as part of the postbox
            n_c (int) : The number of communicators within a postbox
        Returns
            postbox_ivp17 (PostBox **) : The PostBox Variable initialized
    */
    int j;
    postbox_ivp17[i].communicators = (struct CommStruct *)calloc(n_c,sizeof(struct CommStruct));
    for(j = 0;j < n_c;j++){
        postbox_ivp17[i].communicators[j].messages = createQueue();
        omp_init_lock(&(postbox_ivp17[i].communicators[j].lock)); 
    }
}
#endif