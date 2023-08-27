if [ $# -ne 5 ]
then
  echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS> <SIZE> <C> <NTHREADS>"
  exit
fi
machine=$1
num_of_runs=$2
size=$3
C=$4
nthreads=$5

#./run_on_k2.sh $nthreads $machine
# Create the job files.

SRCDIR=../../../..
ABS_PATH=/home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/knapsack-dp
NTHREADS=$nthreads
MACHINE=$machine

rm trans; gcc -O1 -foptimize-sibling-calls -fopenmp $SRCDIR/rose_knapsack_final.c -o trans

rundir="/home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/knapsack-dp/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans"

echo "#!/bin/bash
#PBS -l mem=4gb,nodes=$MACHINE:ppn=64,walltime=3:00:00
#PBS -m abe
#PBS -o knapsack_trans.out
#PBS -e knapsack_trans.err
export OMP_NUM_THREADS=$NTHREADS
taskset -c 0-$(( NTHREADS - 1 )) $rundir/trans $ABS_PATH/sample/k"$size""x""$C".txt
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
  #  cat knapsack_trans.err
	rtime=`cat knapsack_trans.err | grep "Run time" | awk '{print $4}'`
	echo $i $rtime 1>&2
	sum=`echo "$rtime + $sum" | bc -l`
	echo $sum 1>&2
	i=$(( i+1 ))
done
avg=`echo "$sum / $num_of_runs" | bc -l`
echo $avg
#rm knapsack_trans.out knapsack_trans.err
