if [ "$#" -ne 5 ]
then
    echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS> <SIZE> <TSTEPS> <NTHREADS>"
    exit 1
fi

# This script get the results for varying number of threads.
# The problem size is same as the number of threads.
num_of_runs=$2
machine=$1
size=$3
NTHREADS=$5
TSTEPS=$4
#echo "SIZE   VAL NTHREADS AvgRuntime    ITERATIONS" >> jacobi-1d_trans.results
./valrun_on_virgo.sh $size $NTHREADS $machine $TSTEPS
sum=0.0
i=1
while [ $i -le $num_of_runs ]
do
  llsubmit -s openmp_trans.cmd > /dev/null
  rtime=`cat jacobi-1d_"$size"_"$TSTEPS"_trans.out | grep "Run time" | awk '{print $4}'`
  echo $i $rtime 1>&2
  sum=`echo "$rtime + $sum" | bc -l`
#echo $sum
  i=$(( i+1 ))
done

avg=`echo "$sum / $num_of_runs" | bc -l`
#echo "Average Running Time for jacobi-1d_trans = " $avg
echo $avg
#echo "$size   FLT_MAX/2 $thread $avg   $iters" >> jacobi-1d_trans.results
