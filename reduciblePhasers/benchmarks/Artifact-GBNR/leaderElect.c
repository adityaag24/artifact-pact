#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#include <limits.h>
#include "../../../src/utility/static-opt/header.h"
#define TRUE 1
#define FALSE 0
#define Infinity INT_MAX
#define FILE_NAME_SIZE 100
char input_file[FILE_NAME_SIZE];
char output_file[FILE_NAME_SIZE];
struct Process{
    int id;
    int send;
    int leaderId;
    int receivedId;
    int status;
};
int processes;
int *IdStore;
struct Process *processSet;
int step;
void init(){
    int i;
    for(i=0;i<processes;i++){
        int pt = i;
        processSet[i].id = IdStore[pt];
        processSet[i].leaderId = processSet[i].id;
        processSet[i].send = processSet[i].id;
        processSet[i].status = FALSE;
    }
}
void transmitLeader(){
    int lead = 0;
    int tmp = 0;
    int i;
    for(i=0;i<processes;i++){
        int check = 0;
        if(processSet[i].status){
            check = 1;
        }
        tmp = check;
        if(tmp == 1)
            lead = i;
    }
    int pt = lead;
    int j;
    for(j=0;j<processes;j++){
        int pt_loc = lead;
        if(pt == processes-1){
            pt = 0;
        }else{
            pt = pt + 1;
        }
        processSet[pt].leaderId = pt_loc;
    }
    int lindex = lead;
    int pt_loc = lindex;
    processSet[lindex].leaderId = pt_loc;
}

void outputVerifier(){
    int max = INT_MIN;
    int i;
    for(i=0;i<processes;i++){
        if (max < IdStore[i]){
            max = IdStore[i];
        }
    }
    int p = 0;
    int lead = processSet[p].leaderId;
    int q = lead;
    lead = processSet[q].id;
    if(max==lead){
        fprintf(stderr,"Output verified\n");
    }else{
        fprintf(stderr,"Output not verified\n");
    }
}
int main(int argc, char *argv[]){
    strcpy(input_file,"inputlcr.txt");
    strcpy(output_file,"outputlcr.txt");
    int verify = FALSE;
    double itime,ftime;
    int i;
    FILE *input = fopen(argv[1],"r");
    if(input == NULL){
        fprintf(stderr,"Error opening input file\n");
        exit(0);
    }
    fscanf(input,"%d",&processes);
    IdStore = calloc(processes,sizeof(int));
    for(i=0;i<processes;i++){
        fscanf(input,"%d",&IdStore[i]);
    }
    processSet = calloc(processes,sizeof(struct Process));
    init();
    itime = omp_get_wtime();
    //Leader Election
    #pragma omp parallel
    {
        int i,pt,p,sval;
        #pragma omp for private(i)
        for(i=0;i<processes;i++){
            while(step < processes){
                pt = i;
                pt = (pt + 1) % processes;
                p = pt;
                sval = processSet[i].send;
                processSet[p].receivedId = sval;
                WAITALL(1)
                if(processSet[i].receivedId > processSet[i].leaderId){
                    processSet[i].send = processSet[i].receivedId;
                    processSet[i].leaderId = processSet[i].receivedId;
                }else if(processSet[i].receivedId == processSet[i].id){
                    processSet[i].status = TRUE;
                    processSet[i].leaderId = processSet[i].id;
                }
                if(i==1){step++;}
                WAITALL(1)
            }
        }
    }
    transmitLeader();
    ftime = omp_get_wtime();
    fprintf(stderr,"Estimated time = ");
    fprintf(stderr,"%lf\n",(ftime - itime));
    if(verify)
        outputVerifier();
    return 0;
}
