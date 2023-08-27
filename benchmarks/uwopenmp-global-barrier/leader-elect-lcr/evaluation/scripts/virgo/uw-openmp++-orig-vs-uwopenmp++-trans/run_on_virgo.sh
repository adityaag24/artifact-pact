if [ "$#" -ne 3 ]
then
    echo "usange run_on_virgo.sh <N> <NTHREADS>  <MACHINE>"
    exit 1
fi
N=$1
NTHREADS=$2
MACHINE=$3
SRCDIR=../../../..

rm trans; gcc -O3 -fopenmp $SRCDIR/rose_leader_elect_lcr-while_final.c -o trans

echo "#!/bin/bash
#@ output     = lcr_trans.out
#@ error      = lcr_trans.err
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
taskset -c 0-$(( NTHREADS - 1 )) ./trans -in `pwd`/$SRCDIR/inputleader_elect_lcr_$N.txt -ver
cd -;" > openmp_trans.cmd
