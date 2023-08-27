cp orig_src/gemver.c .
# This script get the results for varying number of threads.
# The problem size is same as the number of threads.
if [ $# -ne 2 ]
then
  echo "Usage: ./run_all_orig.sh <MACHIN> <NUM_OF_RUNS>"
  exit
fi
num_of_runs=$2
machine=$1
size=8000
threads=( 16 )
echo "SIZE   THREADS AvgRuntime" >> gemver_orig.results
for thread in ${threads[@]}
do
    echo $size
    ./run_on_virgo.sh $size $thread $machine
    ./compile_orig.sh
    sum=0.0
    i=1
    while [ $i -le $num_of_runs ]
    do
        llsubmit -s openmp_orig.cmd 
        rtime=`cat gemver_orig.out | head -n 1 | awk '{print $1}'`
        echo $i $rtime
        sum=`echo "$rtime + $sum" | bc -l`
        echo $sum
        i=$(( i+1 ))
    done
    avg=`echo "$sum / $num_of_runs" | bc -l`
    echo "Average Running Time for gemver_orig$size+$thread = " $avg
    echo "$size $thread $avg" >> gemver_orig.results
done
