#!/bin/bash
#@ output     = fdtd_trans.out
#@ error      = fdtd_trans.err
#@ job_type   = MPICH

#@ class      = Csmedium

#@ node = 1

#@ tasks_per_node = 8
#@ requirements = (Machine == "c2n02")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=`echo $LOADL_STEP_ID | cut -f 6 -d .`
olddir=/home1/phd/cs12d015/balancedBarriers/benchmarks/polybench-3.2/stencils/fdtd-2d
tmpdir=$HOME/scratch/job$Jobid
mkdir -p $tmpdir; cd $tmpdir
cp -R $LOADL_STEP_INITDIR/* $tmpdir
export OMP_NUM_THREADS=16
taskset -c 0-15 ./trans.out
cd -;
