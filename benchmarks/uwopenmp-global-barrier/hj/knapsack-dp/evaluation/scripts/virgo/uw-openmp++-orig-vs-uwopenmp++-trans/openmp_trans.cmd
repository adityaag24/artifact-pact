#!/bin/bash
#@ output     = lcr_trans.out
#@ error      = lcr_trans.err
#@ job_type   = MPICH

#@ class      = Csverylong

#@ node = 1

#@ tasks_per_node = 32
#@ requirements = (Machine == "c2n03")
#@ environment = COPY_ALL
#@ resources = ConsumableMemory(60gb)
#@ queue
Jobid=`echo $LOADL_STEP_ID | cut -f 6 -d .`
olddir=/home1/phd/cs12d015/uw-openmp/benchmarks/uwopenmp-global-barrier/leader-elect-lcr/evaluation/scripts/virgo/uw-openmp++-orig-vs-uwopenmp++-trans
tmpdir=$HOME/scratch/job$Jobid
mkdir -p $tmpdir; cd $tmpdir
cp -R $LOADL_STEP_INITDIR/* $tmpdir
export OMP_NUM_THREADS=32
taskset -c 0-31 ./trans -in /home1/phd/cs12d015/uw-openmp/benchmarks/uwopenmp-global-barrier/leader-elect-lcr/evaluation/scripts/virgo/uw-openmp++-orig-vs-uwopenmp++-trans/../../../../inputleader_elect_lcr_512.txt -ver
cd -;
