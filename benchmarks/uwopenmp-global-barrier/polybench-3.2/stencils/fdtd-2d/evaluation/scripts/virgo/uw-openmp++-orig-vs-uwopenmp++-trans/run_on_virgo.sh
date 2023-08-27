if [ "$#" -ne 4 ]
then
    echo "usage run_on_virgo.sh <N> <NTHREADS>  <MACHINE> <TSTEPS>"
    exit 1
fi
N=$1
NTHREADS=$2
MACHINE=$3
TSTEPS=$4
SRCDIR=../../../..
rm trans; gcc -O3 -fopenmp -I $SRCDIR/../../utilities -I $SRCDIR/../../stencils/fdtd-2d $SRCDIR/../../utilities/polybench.c -DPOLYBENCH_TIME $SRCDIR/rose_fdtd-2d_final.c -o trans 

echo "#!/bin/bash
#@ output     = fdtd-2d_"$TSTEPS"_orig.out
#@ error      = fdtd-2d_"$TSTEPS"_orig.err
#@ job_type   = MPICH

#@ class      = Csmedium

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
rm -rf \$tmpdir
cd -;" > openmp_orig.cmd


echo "#!/bin/bash
#@ output     = fdtd-2d_"$TSTEPS"_trans.out
#@ error      = fdtd-2d_"$TSTEPS"_trans.err
#@ job_type   = MPICH

#@ class      = Csmedium

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
rm -rf \$tmpdir
cd -;" > openmp_trans.cmd
