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
    void (*waitFunction)(struct Clsr *);
};
struct Msg {
    void *message;
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
struct ClsrNode{
    struct Clsr *closure;
    struct ClsrNode *next;
};
struct WLQueue{
    struct ClsrNode *front,*rear;
};
struct HashNode{
    int key;
    int value;
    omp_lock_t lock;
    struct HashNode *next;
};
struct HashTable{
    struct HashNode **table;
    int tSize;
    int cSize;
};
struct HashNode *createHashNode(int key,int value){
    struct HashNode *tempNode=(struct HashNode *)malloc(sizeof(struct HashNode));
    tempNode->key=key;
    tempNode->value=value;
    tempNode->next=(void *)0;
    omp_init_lock(&(tempNode->lock));
    return tempNode;
}
struct HashTable *createHashTable(){
    struct HashTable *table=(struct HashTable *)malloc(sizeof(struct HashTable));
    table->table=(struct HashNode **)malloc(4*sizeof(struct HashNode *));
    table->tSize=4;
    table->cSize=0;
    int i;
    for(i=0;i<4;i++){
        table->table[i]=(void *)0;
    }
    return table;
}
int hashFunction(int key,int tSize){
    return (key % tSize);
}
void insert(struct HashTable *table,int key,int value){
    int tSize=table->tSize;
    int hashIndex=hashFunction(key,tSize);
    struct HashNode *newNode=createHashNode(key,value);
    newNode->next=table->table[hashIndex];
    table->table[hashIndex]=newNode;
    table->cSize++;
}
struct HashNode *search(struct HashTable *table,int key){
    int tSize=table->tSize;
    int hashIndex=hashFunction(key,tSize);
    struct HashNode *ptr=table->table[hashIndex];
    if(ptr==(void *)0){
        return (void *)0;
    }else{
        omp_set_lock(&(ptr->lock));
        while(ptr!=(void *)0){
            if(ptr->key==key){
                omp_unset_lock(&(ptr->lock));
                return ptr;
            }
            ptr=ptr->next;
        }
        omp_unset_lock(&(ptr->lock));
        return (void *)0;
    }
}
struct WLQueue *globalWorklist;
int K;
int threadStatus[2048];
int startRange_ivp17;
int endRange_ivp17;
void (*continuationFunctionPointer)(struct Clsr *);
#endif