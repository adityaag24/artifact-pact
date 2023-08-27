#ifndef POSTBOX_H
#define POSTBOX_H
#include <omp.h>
#include "typeDeclare.h"
struct HashTable **postbox_ivp17;
void incrementCounter(struct HashTable *table,int key){
    struct HashNode *ptr=search(table,key);
    if(ptr==(void *)0){
        insert(table,key,1);
    }else{
        omp_set_lock(&(ptr->lock));
        (ptr->value)++;
        omp_unset_lock(&(ptr->lock));
    }
}
int decrementCounter(struct HashTable *table,int key){
    struct HashNode *ptr=search(table,key);
    if(ptr==(void *)0){
        return 0;
    }else{
        omp_set_lock(&(ptr->lock));
        if(ptr->value==0){
            omp_unset_lock(&(ptr->lock));
            return 0;
        }else{
            (ptr->value)--;
            omp_unset_lock(&(ptr->lock));
            return 1;
        }
    }
}
int testAndDecPostbox(int currentIteration, int waitIteration){
    struct HashTable *hashTable=postbox_ivp17[currentIteration];
    return decrementCounter(hashTable,waitIteration);
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
    struct HashTable *hashTable=postbox_ivp17[to];
    int tSize=hashTable->tSize;
    incrementCounter(hashTable,from);
}
void initialisePostBox(int i){
    /*
        Parameters
            n_p (int) : The number of iterations as part of the postbox
            n_c (int) : The number of communicators within a postbox
        Returns
            postbox_ivp17 (PostBox **) : The PostBox Variable initialized
    */
    postbox_ivp17[i]=createHashTable();
}
#endif