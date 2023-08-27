#include <bits/stdc++.h>
using namespace std;
template<typename T>
class HashNode{
    public:
    string key;
    T value;
    HashNode *next;
    HashNode(string _key,T _value){
        key=_key;
        value=_value;
        next=NULL;
    }
};
template<typename T>
class HashTable{
    public:
    int tSize;
    int cSize;
    HashNode<T> **table;
    HashTable(int _tSize=7){
        table=new HashNode<T>*[_tSize];
        tSize=_tSize;
        for(int i=0;i<tSize;i++){
            table[i]=NULL;
        }
        cSize=0;
    }
    int hashFunction(string key){
        int p=1;
        int idx=0;
        for(int i=0;i<key.length();i++){
            idx=idx+(key[i] * p)%tSize;
            idx=idx%tSize;
            p=(p*27)%tSize;
        }
        return idx;
    }
    void insert(string key,T value){
        int idx=hashFunction(key);
        HashNode<T> *newNode=new HashNode<T>(key,value);
        newNode->next=table[idx];
        table[idx]=newNode;
        cSize++;
    }
    void print(){
        for(int i=0;i<tSize;i++){
            HashNode<T> *ptr=table[i];
            cout<<i<<" | ";
            while(ptr!=NULL){
                cout<<"("<<ptr->key<<":"<<ptr->value<<") ";
                ptr=ptr->next;
            }
            cout<<endl;
        }
    }
    HashNode<T> *search(string key){
        int idx=hashFunction(key);
        HashNode<T> *ptr=table[idx];
        while(ptr!=NULL){
            if(ptr->key==key){
                return ptr;
            }
            ptr=ptr->next;
        }
        return NULL;
    }
};
int main(){
    HashTable<int> *hashTable=new HashTable<int>();
    hashTable->insert("aditya",20);
    hashTable->insert("krishna",30);
    hashTable->insert("divya",40);
    hashTable->insert("amit",50);
    hashTable->insert("omkar",60);
    hashTable->insert("abdun",90);
    hashTable->insert("shashin",70);
    hashTable->insert("aman",80);
    hashTable->print();
    cout<<hashTable->search("aditya")->value<<endl;
}