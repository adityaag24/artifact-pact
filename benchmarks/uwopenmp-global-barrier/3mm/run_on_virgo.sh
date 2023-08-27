if [ "$#" -ne 3 ]
then
    echo "usange run_on_virgo.sh <N> <NTHREADS> <MACHINE>"
    exit 1
fi
N=$1
NTHREADS=$2
MACHINE=$3
echo "
#define N $N
" > header.h

make

echo "#!/bin/bash
#@ output     = 3mm_orig$N+$NTHREADS.out
#@ error      = 3mm_orig$N+$NTHREADS.err
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
export OMP_NUM_THREADS=$N
taskset -c 0-$(( NTHREADS - 1 )) ./orig
cd -;" > openmp_orig.cmd


echo "#!/bin/bash
#@ output     = 3mm_trans$N+$NTHREADS.out
#@ error      = 3mm_trans$N+$NTHREADS.err
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
