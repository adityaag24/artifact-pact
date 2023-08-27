if [ "$#" -ne 4 ]
then
    echo "usage ./eval.sh <SIZE> <TSTEPS> <THREADS> <NUM_RUNS>"
    exit 1
fi
SIZE=$1
TSTEPS=$2
THREADS=$3
num_of_runs=$4

SRCDIR=.

echo "
#define __NX__ $SIZE 
#define __NY__ $SIZE
#define __TMAX__ $TSTEPS
" > $SRCDIR/header.h

echo -e "CODE\t\tSIZE\tNUM_THREADS\tRUN_TIME\tITERATIONS" >> results.txt
echo -e "----\t\t----\t-----------\t--------\t----------" >> results.txt

function evaluate() {
  sum=0.0
	bm=$1
	outputtype=$2
	filetype=$3

  i=1
  while [ $i -le $num_of_runs ]
  do
  	rm $outputtype; gcc -O3 -fopenmp -I $SRCDIR/../../utilities -I $SRCDIR/../../stencils/fdtd-2d $SRCDIR/../../utilities/polybench.c -DPOLYBENCH_TIME rose_$bm-$filetype.c -o $outputtype 2> /dev/null
  	export OMP_NUM_THREADS=$THREADS
  	./$outputtype > out
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

evaluate "fdtd-2d" "OMOpenMP" "omopenmp"
evaluate "fdtd-2d" "OMOmp++-Naive" "no-reuseopt"
evaluate "fdtd-2d" "OMOmp++" "reuse-opt"
evaluate "fdtd-2d" "OMOmp++-Opt" "opt"
