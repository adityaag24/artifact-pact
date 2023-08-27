#!/bin/bash
#@ output     = jacobi_trans.out
#@ error      = jacobi_trans.err
#@ job_type   = MPICH

#@ class      = Csmedium

#@ node = 1

#@ tasks_per_node = 8
#@ requirements = (Machine == "c2n03")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=`echo $LOADL_STEP_ID | cut -f 6 -d .`
olddir=/home1/phd/cs12d015/balancedBarriers/benchmarks/polybench-3.2/stencils/jacobi-2d-imper
tmpdir=$HOME/scratch/job$Jobid
mkdir -p $tmpdir; cd $tmpdir
cp -R $LOADL_STEP_INITDIR/* $tmpdir
export OMP_NUM_THREADS=16
taskset -c 0-15 ./trans.out
cd -;
