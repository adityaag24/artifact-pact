#ifndef HEADER_H
#define HEADER_H
#include "typeDeclare.h"
struct Clsr *createClosure(enum typeClsr,void (*fptr)(struct Clsr *),int);
void myWaitAll(int);
void mWaitAll(struct Clsr *);
void lastFunction(struct Clsr *closure){
    closure->typeClosure = DONE;
}
#include "Closure.h"
#include "Worklist.h"
#include "Wait.h"
#endif