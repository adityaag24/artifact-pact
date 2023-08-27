# This script get the results for varying number of threads from 1 to 32
# The problem size is same as the number of threads.
machine=$1
num_of_runs=$2
echo "SIZE  NTHREADS AvgRuntime" >> sor_trans.results
for size in $(seq 600 600)
do
    echo $size
    threads=$(( size-2 ))
    ./run_on_virgo_ee.sh $size $threads $machine
    sum=0.0
    i=1
    while [ $i -le $num_of_runs ]
    do
        llsubmit -s openmp_trans.cmd 
        rtime=`cat sor_trans$size+$threads.err | grep "Run time" | awk '{print $4}'`
        echo $i $rtime
        sum=`echo "$rtime + $sum" | bc -l`
        echo $sum
        i=$(( i+1 ))
    done
    avg=`echo "$sum / $num_of_runs" | bc -l`
    echo "Average Running Time for sor_trans$size+$size = " $avg
    echo "$size   $threads   $avg" >> sor_trans.results
done
