# This script get the results for varying number of threads from 1 to 32
# The problem size is same as the number of threads.
cp unopt_src/jacobi-1d-imper.c .
if [ $# -ne 2 ]
then
  echo "Usage: ./run_all_trans.sh <MACHIN> <NUM_OF_RUNS>"
  exit
fi
machine=$1
num_of_runs=$2
echo "SIZE  NTHREADS AvgRuntime" >> jacobi_trans.results
for size in $(seq 10000 10000)
do
    echo $size
    threads=$size
    ./run_on_virgo_ee.sh $size $threads $machine
    ./compile_trans.sh
    sum=0.0
    i=1
    while [ $i -le $num_of_runs ]
    do
        llsubmit -s openmp_trans.cmd 
        rtime=`cat jacobi_trans.out | head -n 1 | awk '{print $1}'`
        echo $i $rtime
        sum=`echo "$rtime + $sum" | bc -l`
        echo $sum
        i=$(( i+1 ))
    done
    avg=`echo "$sum / $num_of_runs" | bc -l`
    echo "Average Running Time for jacobi_trans$size+$size = " $avg
    echo "$size   $threads   $avg" >> jacobi_trans.results
done
