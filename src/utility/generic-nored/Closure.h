#ifndef CLOSURE_H
#define CLOSURE_H
#include "typeDeclare.h"
struct Clsr *createClosure(enum typeClsr type,void (*fptr)(struct Clsr *)){
    struct Clsr *closure = (struct Clsr *)malloc(sizeof(struct Clsr));
    closure->typeClosure = type;
    closure->fptr = fptr;
    return closure;
}
#endif