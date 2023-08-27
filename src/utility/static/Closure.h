#ifndef CLOSURE_H
#define CLOSURE_H
struct Clsr *createClosure(enum typeClsr type,void (*fptr)(struct Clsr *),void *env){
    struct Clsr *closure = (struct Clsr *)malloc(sizeof(struct Clsr));
    closure->typeClosure = type;
    closure->fptr = fptr;
    closure->environment = env;
    return closure;
}
#endif