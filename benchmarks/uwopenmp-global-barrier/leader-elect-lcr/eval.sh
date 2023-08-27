if [ "$#" -ne 3 ]
then
    echo "usage ./eval.sh <SIZE> <THREADS> <NUM_RUNS>"
    exit 1
fi
SIZE=$1
THREADS=$2
num_of_runs=$3

echo -e "CODE\t\tSIZE\tNUM_THREADS\tRUN_TIME" >> results.txt
echo -e "----\t\t----\t-----------\t--------" >> results.txt

function evaluate() {
  sum=0.0
	bm=$1
	outputtype=$2
	filetype=$3

  i=1
  while [ $i -le $num_of_runs ]
  do
  	rm $outputtype; gcc -O3 -fopenmp rose_$bm-$filetype.c -o $outputtype 2> /dev/null
  	export OMP_NUM_THREADS=$THREADS
  	./$outputtype -in ./input"$bm"_$SIZE.txt -ver 2> out
  	cat out
  	rtime=`cat out | grep "Run time" | awk '{print $4}'`
  	echo $i $rtime 1>&2
  	sum=`echo "$rtime + $sum" | bc -l`
  	i=$(( i+1 ))
  done
  rm out
  avg=`echo "scale=6; $sum / $num_of_runs" | bc -l | awk '{printf "%f\n", $0}'`
  echo -e "$outputtype\t$SIZE\t$THREADS\t$avg\t$iters" >> results.txt
}

evaluate "leader_elect_lcr" "OMOpenMP" "omopenmp"
evaluate "leader_elect_lcr" "OMOmp++-Naive" "no-reuseopt"
evaluate "leader_elect_lcr" "OMOmp++" "reuse-opt"
evaluate "leader_elect_lcr" "OMOmp++-Opt" "opt"
