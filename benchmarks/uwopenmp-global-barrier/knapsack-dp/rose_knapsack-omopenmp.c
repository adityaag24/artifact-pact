//
// File name   : knap.c
// Author      : DaeGon
// Modified by : Sanjay and Wim 
// Date        : Sep 20
// Description : Dynamic Programming for the 0/1 knapsack
//               problem.  The entire table is saved.
//
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int __cani_enter(int i, int g, int *__gCnt) {
  //return 1;
  if(__gCnt[i] == 2*g) {
    __gCnt[i]++;
    return 1;
  }
  if(__gCnt[i] == 2*g + 1) {
    return 1;
  }
  return 0;
}

void __i_exit(int i, int *__gCnt) {
    __gCnt[i]++;
}

void __reset(int i, int j, int k) {
  return;
}


void getruntime(struct timeval tv1,struct timeval tv2)
{
  time_t sec1;
  time_t sec2;
  suseconds_t usec1;
  suseconds_t usec2;
  sec1 = tv1.tv_sec;
  sec2 = tv2.tv_sec;
  usec1 = tv1.tv_usec;
  usec2 = tv2.tv_usec;
  double start_time = (((double )sec1) + (usec1 / 1000000.0));
  double end_time = (((double )sec2) + (usec2 / 1000000.0));
  fprintf(stderr,"%f\n",(end_time - start_time));
}
#define    MAX(x,y)   ((x)>(y) ? (x) : (y))
#define    table(i,j)    table[(i)*(C+1)+(j)]
int *table;
// # of objects, capacity 
int N;
int C;
// weights and profits
int *weights;
int *profits;
int *newProfit;
int *oldProfit;
int iters = 0;
int *temp;
//void knapSack(int *oldP, int *newP, int i, int k){
//	if(i >= N)//0 to N-1 row index
//		return;
//	if(k == 0)
//		newP[k] = 0;
//	if(k < weights[i])
//		newP[k] = oldP[k];
//	else
//		newP[k] = MAX(oldP[k], profits[i] + oldP[k-weights[i]]);
//	#pragma omp barrier
//	knapSack(newP, oldP, i+1, k);
//}

int main(int argc,char **argv)
{
  FILE *fp;
  int verbose;
  int count;
  struct timeval tv1;
  struct timeval tv2;
  int ii;
  int j;
  int size;
  double time;
  if (argc > 1) {
    fp = fopen(argv[1],"r");
    if (fp == ((FILE *)((FILE *)((void *)0)))) {
      printf("[ERROR] : Failed to read file named \'%s\'.\n",argv[1]);
      exit(1);
    }
  }
  else {
    printf("USAGE : %s [filename].\n",argv[0]);
    exit(1);
  }
  if (argc > 2) 
    verbose = atoi(argv[2]);
  else 
    verbose = 0;
  fscanf(fp,"%d %d",&N,&C);
  printf("The number of objects is %d, and the capacity is %d.\n",N,C);
  size = (N * sizeof(int ));
  weights = ((int *)(malloc(size)));
  profits = ((int *)(malloc(size)));
  if ((weights == ((int *)((int *)((void *)0)))) || (profits == ((int *)((int *)((void *)0))))) {
    printf("[ERROR] : Failed to allocate memory for weights/profits.\n");
    exit(1);
  }
  for (ii = 0; ii < N; ii++) {
    count = fscanf(fp,"%d %d",(weights + ii),(profits + ii));
    if (count != 2) {
      printf("[ERROR] : Input file is not well formatted.\n");
      exit(1);
    }
  }
  fclose(fp);
  size = ((C + 1) * sizeof(int ));
  newProfit = (malloc(size));
  oldProfit = (malloc(size));
  for (j = 0; j <= C; j++) {
    if (j < weights[0]) 
      oldProfit[j] = 0;
    else 
      oldProfit[j] = profits[0];
  }
  gettimeofday(&tv1,0);
  int __NPhase = (C - 0 + 2); //edited
  int __Phase[__NPhase];
  memset(__Phase,0,__NPhase);
  int __S00 = 8; //edited
  int __NH = (C - 0 + 2);
  int __H[__NH][__S00];
  memset(__H,0,(__NH * __S00));
  int __flag = 1;
  int __tmpflag = 0;
  int __cp = 0;
  int __NWhile00 = C + 1; // Check if output is not correct
  int __vWhile00[__NWhile00];
  memset(__vWhile00,0,__NWhile00);
  int __count0 = 0;
  int __N01 = C - 0 + 2;
  int __v01[__N01];
  memset(__v01,0,__N01);
  int __N0111 = C - 0 + 2;
  int __v0111[__N0111];
  memset(__v0111,0,__N0111);
  int __N =  C - 0 + 2; //added
  int __gCnt[__N]; //added
  memset(__gCnt, 0, __N*sizeof(int)); //added

#pragma omp parallel 
{
    int i;
      do {
        
#pragma omp for private(i) 
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][0])) {
            __H[i][0] = 1;
            __vWhile00[i] = (iters < N);
            __v01[i] = ((int )__vWhile00[i]) != 0;
          }
        }
        
#pragma omp for  private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][1])) {
            __H[i][1] = 1;
            if (__v01[i]) {
              if (i == 0) 
                newProfit[i] = 0;
              if (i < weights[iters]) 
                newProfit[i] = oldProfit[i];
              else 
                newProfit[i] = ((oldProfit[i] > (profits[iters] + oldProfit[i - weights[iters]]))?oldProfit[i] : (profits[iters] + oldProfit[i - weights[iters]]));
            }
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][2])) {
            __H[i][2] = 1;
            if (__v01[i]) 
              __Phase[i]++;
          }
          if (__Phase[i] != __cp + 1) {
            __flag = 0;
          }
        }
#pragma omp single 
{
          __tmpflag = __flag;
          if (__flag) {
            __cp++;
          }
          __flag = 1;
        }
        if (__tmpflag) {
          continue; 
        }
/* **************End of barrier************* */
        
#pragma omp for  private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][3])) {
            __H[i][3] = 1;
            __v0111[i] = __v01[i];
          }
        }
        
#pragma omp for  private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][4])) {
            __H[i][4] = 1;
            if (__v0111[i]) {
							{
              if (i == 0) {
							//	fprintf(stderr,"inside critical tid : %d\n", omp_get_thread_num());
                temp = oldProfit;
                oldProfit = newProfit;
                newProfit = temp;
                iters++;
              }
							}
            }
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][5])) {
            __H[i][5] = 1;
            if (__v0111[i]) 
              __Phase[i]++;
          }
          if (__Phase[i] != __cp + 1) {
            __flag = 0;
          }
        }
#pragma omp single 
{
          __tmpflag = __flag;
          if (__flag) {
            __cp++;
          }
          __flag = 1;
        }
        if (__tmpflag) {
          continue; 
        }
/* **************End of barrier************* */
#pragma omp for  private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][6])) {
            __H[i][6] = 1;
            if (__v0111[i]) {
              __reset(i,0,0);
            }
          }
        }
        
#pragma omp for private(i)
        for (i = 0; i <= C; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][7])) {
            __H[i][7] = 1;
            if (!(__vWhile00[i] != 0)) {
#pragma omp critical 
              __count0++;
              __i_exit(i, __gCnt);
            }
          }
        }
#pragma omp single //added
{
	memset(__Phase,0,__NPhase*sizeof(int));
	memset(__H,0,(__NH * __S00*sizeof(int)));
	memset(__gCnt, 0, __N*sizeof(int)); //added

	__cp = 0;
//	__flag = 1;
}

        if (__count0 > __NWhile00) 
          break; 
/* Code generated to While loop ends */
      }while (1);
/* Code generated for while loop starts */
  }
  gettimeofday(&tv2,0);
  fprintf(stderr,"Run time = ");
  getruntime(tv1,tv2);
// End of "Solve for the optimal profit"
// Backtracking
//	int c=C;
//	int solution[N];
//	for ( i=N-1 ; i > 0 ; i-- ) {
//		if ( c-weights[i] < 0 ) {
//			//printf("i=%d: 0 \n",i);
//			solution[i] = 0;
//		} else {
//			if ( table(i-1,c) > table(i-1,c-weights[i]) + profits[i] ) {
//
//				//printf("i=%d: 0 \n",i);
//				solution[i] = 0;
//			} else {
//				//printf("i=%d: 1 \n",i);
//				solution[i] = 1;
//				c = c - weights[i];
//			}
//		}
//	} 
//	//wim: first row does not look back
//	if(c<weights[0]){
//		//printf("i=0: 1 \n");
//		solution[0]=0;
//	} else {
//		//printf("i=0: 0 \n");
//		solution[0]=1;
//	}
  if (oldProfit[C] > newProfit[C]) 
    printf("The optimal profit is %d\n",oldProfit[C]);
  else 
    printf("The optimal profit is %d\n",newProfit[C]);
//	if (verbose==1) {
//
//		printf("Solution vector is: ");
//		for (i=0 ; i<N ; i++ ) {
//			printf("%d ", solution[i]);
//		}
//		printf("\n");
//	}
//
//	if (verbose==2) {
//		for (j=1; j<=C; j++){
//			printf ("%d\t", j);
//			for (i=0; i<N; i++)
//				printf ("%d ", table(i, j));
//			printf("\n");
//		}
//	}
  return 0;
}
