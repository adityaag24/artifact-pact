#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "../../../src/utility/static-opt/header.h"
#define MAX(x,y) ((x) > (y) ? (x) : (y))
int size_x,size_y;
int **table;
char *x,*y;

void printInput(){
    fprintf(stdout,"size_x = %d,size_y = %d\n",size_x,size_y);
    fprintf(stdout,"x = %s\n",x);
    fprintf(stdout,"y = %s\n",y);
}
void printTable(){
    int i,j;
    for(i=0;i<=size_x;i++){
        for(j=0;j<=size_y;j++){
            fprintf(stdout,"%d ",table[i][j]);
        }
        fprintf(stdout,"\n");
    }
}
void longestSubSeq(int,int);
int main(int argc, char **argv){
    double itime,ftime;
    FILE *fp;
    if(argc > 1){
        fp = fopen(argv[1],"r");
        if(fp == NULL){
            printf("[ERROR] : Failed to read file named %s\n",argv[1]);
            exit(1);
        }
    }else{
        printf("USAGE : %s [filename].\n",argv[0]);
        exit(1);
    }
    fscanf(fp, "%d %d ", &size_x,&size_y);
    x = malloc(size_x * sizeof(char));
    if(x==NULL){
        printf("[ERROR]: Failed to allocate memory for the first sequence.\n");
        exit(1);
    }
    y = malloc(size_x * sizeof(char));
    if(y==NULL){
        printf("[ERROR]: Failed to allocate memory for the second sequence.\n");
        exit(1);
    }
    fscanf(fp,"%s",x);
    fscanf(fp,"%s",y);
    // printInput();
    int i;
    table = (int **)calloc(size_x+1,sizeof(int *));
    for(i=0;i<size_x + 1;i++){
        table[i] = (int *)calloc(size_y + 1,sizeof(int));
    }
    itime = omp_get_wtime();
    #pragma omp parallel
    {
        int i,j = 0;
        #pragma omp for
        for(i=0;i<=size_x;i++){
            longestSubSeq(i,0);
        }
    }
    ftime = omp_get_wtime();
    fprintf(stderr,"Runtime = %lf seconds.\n",(ftime - itime));
    fprintf(stderr,"Answer = %d \n",table[size_x][size_y]);
    return 0;
}
void longestSubSeq(int i,int c){
    if(c <= size_x + size_y){
        int j;
        if(c >= i && c <= i + size_y){
            j = c - i;
            if(i==0 || j==0){
                table[i][j] = 0;
            }else if(x[i-1] == y[j-1]){
                table[i][j] = 1 + table[i-1][j-1];
            }else{
                table[i][j] = MAX(table[i-1][j],table[i][j-1]);
            }
        }
        WAITALL(1)
        longestSubSeq(i,c+1);
    }
}
