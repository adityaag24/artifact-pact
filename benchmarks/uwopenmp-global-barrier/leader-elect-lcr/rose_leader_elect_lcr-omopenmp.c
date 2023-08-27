#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#include <limits.h>
#define TRUE 1
#define FALSE 0
#define Infinity INT_MAX
#define FILE_NAME_SIZE 100

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
char input_file[100UL];
char output_file[100UL];
/**
 * <code>PROCESS</code> specifies the structure for each abstract node
 * part of the Leader election algorithm.
 */

struct Process 
{
/** Specifies identifier for each node. */
  int id;
/** Represents the Identifier that the process will send to its neighbor. */
  int send;
/** Represents the Identifier of the leader. */
  int leaderId;
/** Represents the Identifier that the process receives from its neighbor. */
  int recievedId;
/** Represents the status of the process and will be set to true for leader. */
  int status;
}
;
int processes;
int *IdStore;
struct Process *processSet;
int step;
/** Initializes all the fields of the abstract node. */

void initialize()
{
  int i;
  for (i = 0; i < processes; i++) {
    int pt = i;
    processSet[i].id = IdStore[pt];
    processSet[i].leaderId = processSet[i].id;
    processSet[i].send = processSet[i].id;
    processSet[i].status = 0;
  }
}
/** 
 * Sends message to the neighbor.
 * 
 * @param	receiver	Node which receives the message.
 * @param	sval		Message value.
 */
//#define sendMessage(receiver, sval) processSet[receiver].recievedId = sval
/** Aims at selecting the leader from a set of nodes. */

void leaderElect()
{
  int __NPhase = (processes - 0 + 1);
  int __Phase[__NPhase];
  memset(__Phase,0,__NPhase);
  int __S00 = 8; //edited
  int __NH = (processes - 0 + 1);
  int __H[__NH][__S00];
  memset(__H,0,(__NH * __S00));
  int __flag = 1;
  int __tmpflag = 0;
  int __cp = 0;
  int __NWhile00 = (processes - 0 + 1);
  int __vWhile00[__NWhile00];
  int __count0 = 0;
  int __N01 = processes - 0 + 1;
  int __v01[__N01];
  int __N0111 = processes - 0 + 1;
  int __v0111[__N0111];
  int __N = processes - 0 + 1; //added
  int __gCnt[__N]; //added
  memset(__gCnt, 0, __N*sizeof(int)); //added

#pragma omp parallel 
{
    int i;
    int pt;
    int p;
    int sval;
      do {
        
#pragma omp for private(i)
        for (i = 0; i < processes; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][0])) {
            __H[i][0] = 1;
            __vWhile00[i] = (step < processes);
            __v01[i] = ((int )__vWhile00[i]) != 0;
          }
        }
        
#pragma omp for  private(i) 
        for (i = 0; i < processes; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][1])) {
            __H[i][1] = 1;
            if (__v01[i]) {
              pt = i;
              pt = ((pt + 1) % processes);
              p = pt;
              sval = processSet[i].send;
              processSet[p].recievedId = sval;
            }
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for private(i)
        for (i = 0; i < processes; i++) {
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
        
#pragma omp for   private(i)
        for (i = 0; i < processes; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][3])) {
            __H[i][3] = 1;
            __v0111[i] = __v01[i];
          }
        }
        
#pragma omp for  private(i) 
        for (i = 0; i < processes; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][4])) {
            __H[i][4] = 1;
            if (__v0111[i]) {
              if (processSet[i].recievedId > processSet[i].leaderId) {
                processSet[i].send = processSet[i].recievedId;
                processSet[i].leaderId = processSet[i].recievedId;
              }
              else if (processSet[i].recievedId == processSet[i].id) {
                processSet[i].status = 1;
                processSet[i].leaderId = processSet[i].id;
              }
              if (i == 1) {
                step++;
              }
            }
          }
        }
/* *************Start of barrier************** */
        
#pragma omp for  private(i)
        for (i = 0; i < processes; i++) {
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
        
#pragma omp for   private(i)
        for (i = 0; i < processes; i++) {
          if (__cani_enter(i,0,__gCnt) && (__Phase[i] == __cp && !__H[i][6])) {
            __H[i][6] = 1;
            if (__v0111[i]) {
              __reset(i,0,0);
            }
          }
        }
        
#pragma omp for  private(i)
        for (i = 0; i < processes; i++) {
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
        __flag = 1;
      }

        if (__count0 > __NWhile00) 
          break; 
/* Code generated to While loop ends */
      }while (1);
/* Code generated for while loop starts */
  }
}
/** 
 * Sets the leader for a node.
 * 
 * @param	uNode		Leader node.
 * @param	aNode		Node whose leader has to be set.
 */
//#define setLeader(uNode, aNode) processSet[aNode].leaderId = uNode
/** Transmits the message from one node to another. */

void transmitLeader()
{
  int lead = 0;
  int tmp = 0;
  int i;
  for (i = 0; i < processes; i++) {
    int check = 0;
    if (processSet[i].status != 0) 
      check = 1;
    tmp = check;
    if (tmp == 1) 
      lead = i;
//if(!loadValue.equals(0)) {
//	at(D(i)) {
//		val ipt:Long = i(0);
//		nval(i) = loadweight(nval(i)+ipt);
//	}
//}
  }
  int pt = lead;
  int j;
  for (j = 0; j < processes; j++) {
    int pt_loc = lead;
//if(pt.equals(R.maxPoint())) {
    if (pt == (processes - 1)) {
      pt = 0;
    }
    else {
      pt = (pt + 1);
    }
    processSet[pt].leaderId = pt_loc;
  }
  int lindex = lead;
  int pt_loc = lindex;
  processSet[lindex].leaderId = pt_loc;
}
/** Validates the output resulting from the execution of the algorithm. */

void outputVerifier()
{
  int max = -2147483647 - 1;
  int i;
  for (i = 0; i < processes; i++) {
    if (max < IdStore[i]) {
      max = IdStore[i];
    }
  }
  int p = 0;
  int lead = processSet[p].leaderId;
  int q = lead;
  lead = processSet[q].id;
  if (max == lead) {
    fprintf(stdout,"Output verified\n");
  }
  else {
    fprintf(stdout,"Output not verified\n");
  }
}

int main(int argc,char *argv[])
{
  strcpy(input_file,"inputlcr.txt");
  strcpy(output_file,"outputlcr.txt");
  int verify = 0;
  int i;
  for (i = 1; i < argc; i++) {
    if ((strcmp(argv[i],"-ver") == 0) || (strcmp(argv[i],"-verify") == 0)) {
      verify = 1;
    }
    else if (strcmp(argv[i],"-in") == 0) {
      i++;
      strcpy(input_file,argv[i]);
    }
    else if (strcmp(argv[i],"-out") == 0) {
      i++;
      strcpy(output_file,argv[i]);
    }
  }
  FILE *input = fopen(input_file,"r");
  if (input == ((FILE *)((FILE *)((void *)0)))) {
    fprintf(stderr,"Error in opening the input file\n");
    exit(0);
  }
  fscanf(input,"%d",&processes);
  IdStore = (calloc(processes,(sizeof(int ))));
  for (i = 0; i < processes; i++) {
    fscanf(input,"%d",(IdStore + i));
  }
  processSet = (calloc(processes,(sizeof(struct Process ))));
  initialize();
  struct timeval tv1;
  struct timeval tv2;
  gettimeofday(&tv1,((void *)((void *)((void *)0))));
//for(step = 0; step < processes; step++) {
  leaderElect();
//}
  transmitLeader();
  gettimeofday(&tv2,((void *)((void *)((void *)0))));
  fprintf(stderr,"Run time = ");
  getruntime(tv1,tv2);
//printOutput(output_file);
  if (verify != 0) 
    outputVerifier();
//if(!bfs.loadValue.equals(0)) {
//	var sumval:double=0;
//	for(i=0; i<bfs.nodes; i++) {
//		val pt:Point = Point.make(i);
//		var arrSum:Long = bfs.getNval(pt);
//		sumval = sumval + arrSum;
//	}
//	if(sumval > 0)
//		Console.OUT.println();
//}
  return 0;
}
