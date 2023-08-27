if [ "$#" -ne 3 ]
then
    echo "usange run_on_virgo.sh <N> <NTHREADS>  <MACHINE>"
    exit 1
fi
N=$1
NTHREADS=$2
MACHINE=$3
SRCDIR=../../../..

rm trans; gcc -O3 -fopenmp $SRCDIR/rose_iterated_averaging_final.c -o trans

echo "#!/bin/bash
#@ output     = iteravg_orig.out
#@ error      = iteravg_orig.err
#@ job_type   = MPICH

#@ class      = Csverylong

#@ node = 1

#@ tasks_per_node = 32 
#@ requirements = (Machine == \"$MACHINE\")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=\`echo \$LOADL_STEP_ID | cut -f 6 -d .\`
tmpdir=\$HOME/scratch/job\$Jobid
mkdir -p \$tmpdir; cd \$tmpdir
cp -R \$LOADL_STEP_INITDIR/* \$tmpdir
export OMP_NUM_THREADS=$N
taskset -c 0-$(( NTHREADS - 1 )) ./orig
cd -;" > openmp_orig.cmd


echo "#!/bin/bash
#@ output     = iteravg_trans.out
#@ error      = iteravg_trans.err
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
taskset -c 0-$(( NTHREADS - 1 )) ./trans
cd -;" > openmp_trans.cmd
