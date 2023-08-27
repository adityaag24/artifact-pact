if [ "$#" -ne 3 ]
then
    echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS> <SIZE>"
    exit 1
fi

# This script get the results for varying number of threads.
# The problem size is same as the number of threads.
num_of_runs=$2
machine=$1
size=$3
NTHREADS=32
#echo "SIZE   VAL NTHREADS AvgRuntime    ITERATIONS" >> sor_trans.results
./run_on_virgo.sh $size $NTHREADS $machine
sum=0.0
i=1
while [ $i -le $num_of_runs ]
do
  llsubmit -s openmp_trans.cmd > /dev/null
  rtime=`cat sor_trans.out | grep "Run time" | awk '{print $4}'`
  echo $i $rtime 1>&2
  sum=`echo "$rtime + $sum" | bc -l`
#echo $sum
  i=$(( i+1 ))
done

avg=`echo "$sum / $num_of_runs" | bc -l`
#echo "Average Running Time for sor_trans = " $avg
echo $avg
#echo "$size   FLT_MAX/2 $thread $avg   $iters" >> sor_trans.results
