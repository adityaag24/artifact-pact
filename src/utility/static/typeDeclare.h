#ifndef TYPEDECLARE_H
#define TYPEDECLARE_H
#include <omp.h>
enum typeClsr{
    NORMAL,
    DONE,
    WAIT
};
struct Clsr;
struct WaitClsr{
    int currentIteration; 
    void (*waitFunction)(struct Clsr *);
};
struct Clsr{
    void (*fptr)(struct Clsr *);
    enum typeClsr typeClosure;
    void *environment;
    struct WaitClsr *waitClosure;
};
struct PostBoxStruct{
    int counter;
};
struct Clsr **readyWorkList;
int startRange_ivp17;
int endRange_ivp17;
int nThreads_ivp17;
int *leftPointer;
int *rightPointer;
#endif