if [ "$#" -ne 3 ]
then
    echo "usange run_on_virgo.sh <N> <NTHREADS> <MACHINE>"
    exit 1
fi
N=$1
NTHREADS=$2
MACHINE=$3
echo "
#include <float.h>
#define M $N
#define N $N
#define NITERS 10000
" > header.h

make

echo "#!/bin/bash
#@ output     = sor_orig$N+$NTHREADS.out
#@ error      = sor_orig$N+$NTHREADS.err
#@ job_type   = MPICH

#@ class      = Csmedium

#@ node = 1

#@ tasks_per_node = 8
#@ requirements = (Machine == \"$MACHINE\")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=\`echo \$LOADL_STEP_ID | cut -f 6 -d .\`
tmpdir=\$HOME/scratch/job\$Jobid
mkdir -p \$tmpdir; cd \$tmpdir
cp -R \$LOADL_STEP_INITDIR/* \$tmpdir
export OMP_NUM_THREADS=$(( N - 2 ))
taskset -c 0-$(( NTHREADS - 1 )) ./orig
cd -;" > openmp_orig.cmd


echo "#!/bin/bash
#@ output     = sor_trans$N+$NTHREADS.out
#@ error      = sor_trans$N+$NTHREADS.err
#@ job_type   = MPICH

#@ class      = Csmedium

#@ node = 1

#@ tasks_per_node = 8
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
