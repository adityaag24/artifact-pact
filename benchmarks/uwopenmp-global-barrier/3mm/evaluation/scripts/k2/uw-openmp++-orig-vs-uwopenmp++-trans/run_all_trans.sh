if [ $# -ne 4 ]
then
  echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS> <SIZE> <NTHREADS>"
  exit
fi
machine=$1
num_of_runs=$2
size=$3
nthreads=$4

#./run_on_k2.sh $nthreads $machine
# Create the job files.

SRCDIR=../../../..
NTHREADS=$nthreads
MACHINE=$machine

rm trans; gcc -O3 -fopenmp $SRCDIR/rose_3mm_final.c -o trans

rundir="/home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/3mm/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans"

echo "#!/bin/bash
#PBS -l mem=4gb,nodes=$MACHINE:ppn=$NTHREADS,walltime=10:00:00
#PBS -m abe
#PBS -o 3mm_trans.out
#PBS -e 3mm_trans.err
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
	rtime=`cat 3mm_trans.out | grep "Run time" | awk '{print $4}'`
	echo $i $rtime 1>&2
	sum=`echo "$rtime + $sum" | bc -l`
	echo $sum 1>&2
	i=$(( i+1 ))
done
avg=`echo "$sum / $num_of_runs" | bc -l`
echo $avg
#rm 3mm_trans.out 3mm_trans.err
