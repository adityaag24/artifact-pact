#ifndef TYPEDECLARE_H
#define TYPEDECLARE_H
#include <omp.h>
enum typeClsr{
    NORMAL,
    WAIT,
    DONE
};
struct Clsr;
struct master_env;
struct WaitClsr{
    void (*waitFunction)(struct Clsr *);
};
struct Clsr{
    void (*fptr)(struct Clsr *);
    enum typeClsr typeClosure;
    int iteration;
    struct master_env *environment;
    struct WaitClsr *waitClosure;
};
struct Clsr **readyWorkList;
int startRange_ivp17;
int endRange_ivp17;
int nThreads_ivp17;
int *leftPointer;
int *rightPointer;
#endif