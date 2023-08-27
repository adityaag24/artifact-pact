if [ "$#" -ne 4 ]
then
    echo "usange run_on_virgo.sh <N> <C> <NTHREADS>  <MACHINE>"
    exit 1
fi
N=$1
C=$2
NTHREADS=$3
MACHINE=$4
SRCDIR=../../../..
size=$N

rm trans; gcc -O1 -foptimize-sibling-calls -fopenmp $SRCDIR/rose_knapsack_final.c -o trans


echo "#!/bin/bash
#@ output     = knapsack_trans.out
#@ error      = knapsack_trans.err
#@ job_type   = MPICH

#@ class      = Csverylong

#@ node = 1

#@ tasks_per_node = 32
#@ requirements = (Machine == \"$MACHINE\")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=\`echo \$LOADL_STEP_ID | cut -f 6 -d .\`
olddir=`pwd`
tmpdir=\$HOME/scratch/job\$Jobid
mkdir -p \$tmpdir; cd \$tmpdir
cp -R \$LOADL_STEP_INITDIR/* \$tmpdir
export OMP_NUM_THREADS=$NTHREADS
taskset -c 0-$(( NTHREADS - 1 )) ./trans `pwd`/$SRCDIR/sample/k"$size""x""$C".txt
cd -;" > openmp_trans.cmd
