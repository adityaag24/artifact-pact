#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
int size_x;
int size_y;

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
int **table;
//two sequences
char *x;
char *y;

void printInput()
{
  fprintf(stdout,"size_x = %d, size_y = %d\n",size_x,size_y);
  fprintf(stdout,"x = %s\n",x);
  fprintf(stdout,"y = %s\n",y);
}

void printTable()
{
  int i;
  int j;
  for (i = 0; i <= size_x; i++) {
    for (j = 0; j <= size_y; j++) {
      fprintf(stdout,"%d ",table[i][j]);
    }
    fprintf(stdout,"\n");
  }
}

int c = 0;
int main(int argc,char **argv)
{
  struct timeval tv1;
  struct timeval tv2;
  double time;
  FILE *fp;
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
  fscanf(fp,"%d %d",&size_x,&size_y);
  x = (malloc((size_x * sizeof(char ))));
  if (x == ((char *)((char *)((void *)0)))) {
    printf("[ERROR] : Failed to allocate memory for first seq.\n");
    exit(1);
  }
  y = (malloc((size_y * sizeof(char ))));
  if (y == ((char *)((char *)((void *)0)))) {
    printf("[ERROR] : Failed to allocate memory for second seq.\n");
    exit(1);
  }
  fscanf(fp,"%s",x);
  fscanf(fp,"%s",y);
  int i;
  table = ((int **)(calloc((size_x + 1),(sizeof(int *)))));
  for (i = 0; i < (size_x + 1); i++) 
    table[i] = ((int *)(calloc((size_y + 1),(sizeof(int )))));
  gettimeofday(&tv1,0);
  int __NPhase = (size_x - 0 + 2); // edited
  int __Phase[__NPhase];
  int __S00 = 8;//edited
  int __NH = (size_x - 0 + 2); // edited
  int __H[__NH][__S00];
  memset(__H,0,(__NH * __S00));
	int __flag = 1;
	int __tmpflag = 0;
  int __cp = 0;
  int __NWhile01 = (size_x - 0 + 1); // edited
  int __vWhile01[__NWhile01];
  memset(__vWhile01,0,__NWhile01); // added
  int __count0 = 0;
  int __N02 = size_x - 0 + 2; // edited
  char __v02[__N02];
  memset(__v02,0,__N02);
	
  int __N =  size_x - 0 + 2; //added
  int __gCnt[__N]; //added
  memset(__gCnt, 0, __N*sizeof(int)); //added

#pragma omp parallel 
	{
		int i;
		int j = 0;

		do {
#pragma omp for 
			for (i = 0; i <= size_x; i++) {
				if ((__cani_enter(i,0, __gCnt) != 0) && ((__Phase[i] == __cp) && !(__H[i][0] != 0))) {
					__H[i][0] = 1;
				}
			}
			/* Code generated for while loop starts */

#pragma omp for  
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][1])) {
					__H[i][1] = 1;
					__vWhile01[i] = (c <= (size_x + size_y));
					__v02[i] = ((int )__vWhile01[i]) != 0;
				}
			}

#pragma omp for 
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][2])) {
					__H[i][2] = 1;
					if (__v02[i]) {
						if ((c >= i) && (c <= (i + size_y))) {
							j = (c - i);
							if ((i == 0) || (j == 0)) 
								table[i][j] = 0;
							else if (x[i - 1] == y[j - 1]) 
								table[i][j] = (1 + table[i - 1][j - 1]);
							else 
								table[i][j] = ((table[i - 1][j] > table[i][j - 1])?table[i - 1][j] : table[i][j - 1]);
						}
					}
				}
			}
			/* *************Start of barrier************** */

#pragma omp for 
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][3])) {
					__H[i][3] = 1;
					if (__v02[i]) 
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

#pragma omp for
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][4])) {
					__H[i][4] = 1;
					if (__v02[i]) {
						if (i == 0) {
							c++;
						}
					}
				}
			}

			/* *************Start of barrier************** */

#pragma omp for 
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][5])) {
					__H[i][5] = 1;
					if (__v02[i]) 
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
#pragma omp for
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][6])) {
					__H[i][6] = 1;
					if (__v02[i]) {
						__reset(i,0,0);
					}
				}
			}
#pragma omp for 
			for (i = 0; i <= size_x; i++) {
				if (__cani_enter(i,0, __gCnt) && (__Phase[i] == __cp && !__H[i][7])) {
					__H[i][7] = 1;
					if (!(__vWhile01[i] != 0)) {
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


			if (__count0 > __NWhile01) 
				break; 
		}while (1);
		/* Code generated to While loop ends */
	}
printTable();
  gettimeofday(&tv2,0);
  fprintf(stderr,"Run time = ");
  getruntime(tv1,tv2);
  fprintf(stdout,"longest subseq length = %d\n",table[size_x][size_y]);
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
