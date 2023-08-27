if [ "$#" -ne 3 ]
then
    echo "usange run_on_virgo.sh <N> <NTHREADS> <MACHINE>"
    exit 1
fi
N=$1
T=$(( N-2 ))
NTHREADS=$2
MACHINE=$3


echo "#!/bin/bash
#@ output     = jacobi_orig.out
#@ error      = jacobi_orig.err
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
export OMP_NUM_THREADS=$T
taskset -c 0-15 ./orig.out
cd -;" > openmp_orig.cmd


echo "#!/bin/bash
#@ output     = jacobi_trans.out
#@ error      = jacobi_trans.err
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
export OMP_NUM_THREADS=$T
taskset -c 0-15 ./trans.out
cd -;" > openmp_trans.cmd
