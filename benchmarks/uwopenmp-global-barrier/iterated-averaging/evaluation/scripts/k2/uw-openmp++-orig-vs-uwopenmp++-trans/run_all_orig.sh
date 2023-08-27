if [ $# -ne 2 ]
then
  echo "Usage: ./run_all_orig.sh <MACHIN> <NUM_OF_RUNS>"
  exit
fi
machine=$1
num_of_runs=$2
size=100
nthreads=64

#./run_on_k2.sh $nthreads $machine
# Create the job files.

SRCDIR=../../../..
NTHREADS=$nthreads
MACHINE=$machine

rm orig; gcc -O3 -fopenmp $SRCDIR/iterated_averaging.c -o orig

rundir="/home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/iterated-averaging/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans"

echo "#!/bin/bash
#PBS -l mem=4gb,nodes=$MACHINE:ppn=64,walltime=3:00:00
#PBS -m abe
#PBS -o iteravg_orig.out
#PBS -e iteravg_orig.err
export OMP_NUM_THREADS=$size
taskset -c 0-$(( NTHREADS - 1 )) $rundir/orig
" > openmp_orig.sh

sum=0.0
i=1
while [ $i -le $num_of_runs ]
do
	t=`date +%s`
	echo $t
	jobname="job$i$jES$t"
	echo $jobname
	jobid=`qsub -N $jobname openmp_orig.sh`
	echo "running job " $jobname  "with id" $jobid
	./waitfor_job.sh $jobid $jobname
    cat iteravg_orig.err
	rtime=`cat iteravg_orig.err | grep "Run time" | awk '{print $4}'`
	echo $i $rtime
	echo $i $rtime >> iteragv_orig_$size.results
	sum=`echo "$rtime + $sum" | bc -l`
	echo $sum
	i=$(( i+1 ))
done
avg=`echo "$sum / $num_of_runs" | bc -l`
echo "Average Running Time for iteravg_orig = " $avg
echo "$nthreads $size $avg" >> iteravg_orig.results
#rm iteravg_orig.out iteravg_orig.err
