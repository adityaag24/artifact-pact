#!/bin/bash
#@ output     = 3mm_trans4000+16.out
#@ error      = 3mm_trans4000+16.err
#@ job_type   = MPICH

#@ class      = Csmedium

#@ node = 1

#@ tasks_per_node = 8
#@ requirements = (Machine == "c2n02")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=`echo $LOADL_STEP_ID | cut -f 6 -d .`
olddir=/home1/phd/cs12d015/balancedBarriers/benchmarks/testcases/3mm1
tmpdir=$HOME/scratch/job$Jobid
mkdir -p $tmpdir; cd $tmpdir
cp -R $LOADL_STEP_INITDIR/* $tmpdir
export OMP_NUM_THREADS=24
taskset -c 0-15 ./trans
cd -;
