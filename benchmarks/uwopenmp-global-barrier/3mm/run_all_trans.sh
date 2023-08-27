# This script get the results for varying number of threads.
# The problem size is same as the number of threads.
cp trans_src/3mm_trans.c .
num_of_runs=$2
machine=$1
#size=8000
size=4000
threads=( 16 )
echo "SIZE   THREADS AvgRuntime" >> 3mm_trans.results
for thread in ${threads[@]}
do
    ./run_on_virgo.sh $size $thread $machine
    sum=0.0
    i=1
    while [ $i -le $num_of_runs ]
    do
        echo $size $thread $machine $i
        llsubmit -s openmp_trans.cmd 
        rtime=`cat 3mm_trans$size+$thread.err | grep "Run time" | awk '{print $4}'`
        echo $i $rtime
        sum=`echo "$rtime + $sum" | bc -l`
        echo $sum
        i=$(( i+1 ))
    done
    avg=`echo "$sum / $num_of_runs" | bc -l`
    echo "Average Running Time for 3mm_trans$size+$thread = " $avg
    echo "$size $thread $avg" >> 3mm_trans.results
done
