if [ $# -ne 5 ]
then
  echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS> <SIZE> <TSTEPS> <NTHREADS>"
  exit
fi
machine=$1
num_of_runs=$2
size=$3
TSTEPS=$4
nthreads=$5

#./run_on_k2.sh $nthreads $machine
# Create the job files.

SRCDIR=../../../..
NTHREADS=$nthreads
MACHINE=$machine

rm trans; gcc -O3 -fopenmp -I $SRCDIR/../../utilities -I $SRCDIR/../../stencils/fdtd-2d $SRCDIR/../../utilities/polybench.c -DPOLYBENCH_TIME $SRCDIR/rose_fdtd-2d_final.c -o trans

rundir="/home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/polybench-3.2/stencils/fdtd-2d/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans"


echo "#!/bin/bash
#PBS -l mem=4gb,nodes=$MACHINE:ppn=$NTHREADS,walltime=10:00:00
#PBS -m abe
#PBS -o fdtd-2d_"$TSTEPS"_trans.out
#PBS -e fdtd-2d_"$TSTEPS"_trans.err
export OMP_NUM_THREADS=$NTHREADS
taskset -c 0-$(( NTHREADS - 1 )) $rundir/trans
" > openmp_trans.sh

sum=0.0
i=1
while [ $i -le $num_of_runs ]
do
	t=`date +%s`
	echo $t 1>&2
	jobname="job$i$jES$t"
	echo $jobname 1>&2 
	jobid=`qsub -N $jobname openmp_trans.sh`
	echo "running job " $jobname  "with id" $jobid 1>&2
	./waitfor_job.sh $jobid $jobname
	rtime=`cat fdtd-2d_"$TSTEPS"_trans.out | grep "Run time" | awk '{print $4}'`
	echo $i $rtime 1>&2
	sum=`echo "$rtime + $sum" | bc -l`
	#echo $sum
	i=$(( i+1 ))
done
avg=`echo "$sum / $num_of_runs" | bc -l`
#echo "Average Running Time for iteravg_trans = " $avg
echo $avg
