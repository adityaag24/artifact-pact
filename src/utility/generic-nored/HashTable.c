#include<omp.h>
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
struct HashNode *createHashNode(int key){
    struct HashNode *tempNode=(struct HashNode *)malloc(sizeof(struct HashNode));
    tempNode->key=key;
    tempNode->value=0;
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
void insert(struct HashTable *table,int key){
    int tSize=table->tSize;
    int hashIndex=hashFunction(key,tSize);
    struct HashNode *newNode=createhashNode(key);
    newNode->next=table->table[hashIndex];
    table->table[hashIndex]=newNode;
    table->cSize++;
}
struct HashNode *search(struct HashTable *table,int key){
    int tSize=table->tSize;
    int hashIndex=hashFunction(key,tSize);
    struct HashNode *ptr=table->table[hashIndex];
    while(ptr!=(void *)0){
        if(ptr->key==key){
            return ptr;
        }
        ptr=ptr->next;
    }
    return (void *)0;
}
void print(struct HashTable *table){
    int tSize=table->tSize;
    for(int i=0;i<tSize;i++){
        struct HashNode *ptr=table->table[i];
        while(ptr!=(void *)0){
            printf("%d -> (%d,%d)\n",i,ptr->key,ptr->value);
            ptr=ptr->next;
        }
        printf("\n");
    }
}
int main(){
    struct HashTable **postbox=(struct HashTable **)malloc(4*sizeof(struct HashTable *));
    int i;
    for(i=0;i<4;i++){
        postbox[i]=createHashtable();
    }

}

