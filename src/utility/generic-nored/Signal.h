#ifndef SIGNAL_H
#define SIGNAL_H
#define SIGNAL(x,...) {int wxyz = 0; if(x){int p[]={__VA_ARGS__};int n_iters = sizeof(p)/sizeof(p[0]); int *q_ivp =(int *) malloc(n_iters * sizeof(int)); int i_ivp = 0; for(i_ivp=0;i_ivp<n_iters;i_ivp++) q_ivp[i_ivp] = p[i_ivp]; mySignal(x, n_iters, q_ivp);}}
#define SIGNALALL(x) {int wxyz = 0; if(x){mySignalAll(x,0,0);}}
void mySignalAll(int expr,int start,int end){
    return;
}
void mySignal(int e,int N,int *p){
    return;
}
void mSignalAll(int expr,int from, void *message, int start,int end,struct Clsr *closure){
    int i;
    for(i=start;i<=end;i++){
        postMessage(from,i,message);
    }
    closure->fptr(closure);
}
void mSignal(int expr, int from,void *message,int n_iters,int *signalIterations,struct Clsr *closure){
    if(!expr){
        closure->fptr(closure);
    }else{
        int i;
        for(i = 0;i < n_iters;i++){
            int signalIteration = signalIterations[i];
            if(signalIteration < startRange_ivp17 || signalIteration > endRange_ivp17){
                continue;
            }
            postMessage(from,signalIteration,message);
        }
        closure->fptr(closure);
    }
}
#endif