if [ "$#" -ne 4 ]
then
    echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS> <SIZE> <TSTEPS>"
    exit 1
fi

# This script get the results for varying number of threads.
# The problem size is same as the number of threads.
num_of_runs=$2
machine=$1
size=$3
NTHREADS=32
TSTEPS=$4
#echo "SIZE   VAL NTHREADS AvgRuntime    ITERATIONS" >> fdtd-2d_trans.results
./run_on_virgo.sh $size $NTHREADS $machine $TSTEPS
sum=0.0
i=1
while [ $i -le $num_of_runs ]
do
  llsubmit -s openmp_trans.cmd > /dev/null
  rtime=`cat fdtd-2d_"$TSTEPS"_trans.out | grep "Run time" | awk '{print $4}'`
  echo $i $rtime 1>&2
  sum=`echo "$rtime + $sum" | bc -l`
#echo $sum
  i=$(( i+1 ))
done

avg=`echo "$sum / $num_of_runs" | bc -l`
#echo "Average Running Time for fdtd-2d_trans = " $avg
echo $avg
#echo "$size   FLT_MAX/2 $thread $avg   $iters" >> fdtd-2d_trans.results
