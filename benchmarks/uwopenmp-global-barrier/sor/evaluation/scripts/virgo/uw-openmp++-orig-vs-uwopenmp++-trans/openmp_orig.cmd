#!/bin/bash
#@ output     = sor_orig.out
#@ error      = sor_orig.err
#@ job_type   = MPICH

#@ class      = Csverylong

#@ node = 1

#@ tasks_per_node = 32 
#@ requirements = (Machine == "c2n03")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=`echo $LOADL_STEP_ID | cut -f 6 -d .`
tmpdir=$HOME/scratch/job$Jobid
mkdir -p $tmpdir; cd $tmpdir
cp -R $LOADL_STEP_INITDIR/* $tmpdir
export OMP_NUM_THREADS=4096
taskset -c 0-31 ./orig
rm -rf $tmpdir
cd -;
