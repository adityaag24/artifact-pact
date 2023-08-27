#ifndef HEADER_H
#define HEADER_H
#include "typeDeclare.h"
struct Clsr *createClosure(enum typeClsr,void (*fptr)(struct Clsr *),void *);
void mySignalAll(int);
void mSignalAll(struct Clsr *);
void myWaitAll(int);
void mWaitAll(struct Clsr *);
void executeWaitClosureAll(struct Clsr *);
struct WaitClsr * createWaitClosureAll(int,struct Clsr *);
void executeReadyWorkList();
void lastFunction(struct Clsr *closure){
    closure->typeClosure = DONE;
}
#include "Closure.h"
#include "Worklist.h"
#include "Wait.h"
#include "Signal.h"
#endif