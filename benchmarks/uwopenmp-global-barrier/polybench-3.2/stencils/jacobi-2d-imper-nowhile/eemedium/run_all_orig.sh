# This script get the results for varying number of threads from 1 to 32
# The problem size is same as the number of threads.
cp orig_src/jacobi-2d-imper.c .
if [ $# -ne 2 ]
then
  echo "Usage: ./run_all_orig.sh <MACHIN> <NUM_OF_RUNS>"
  exit
fi
machine=$1
num_of_runs=$2
echo "SIZE  NTHREADS AvgRuntime" >> jacobi_orig.results
for size in $(seq 4000 4000)
do
    echo $size
    threads=$size
    ./run_on_virgo_ee.sh $size $threads $machine
    ./compile_orig.sh
    sum=0.0
    i=1
    while [ $i -le $num_of_runs ]
    do
        llsubmit -s openmp_orig.cmd 
        rtime=`cat jacobi_orig.out | head -n 1 | awk '{print $1}'`
        echo $i $rtime
        sum=`echo "$rtime + $sum" | bc -l`
        echo $sum
        i=$(( i+1 ))
    done
    avg=`echo "$sum / $num_of_runs" | bc -l`
    echo "Average Running Time for jacobi_orig$size+$size = " $avg
    echo "$size   $threads   $avg" >> jacobi_orig.results
done
