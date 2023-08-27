if [ "$#" -ne 4 ]
then
    echo "usage ./script.sh <N> <C> <NRUNS> <NTHREADS>"
    exit 1
fi

SIZE=$1
C=$2
NRUNS=$3
NTHREADS=$4
NTASKS=$NTHREADS
MACHINE="k2n02"

SRCDIR=../../../..

echo -n "hj    $SIZE  $C  $NTHREADS   " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
