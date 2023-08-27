if [ "$#" -ne 3 ]
then
    echo "usage ./script.sh <SIZE> <NRUNS> <NTHREADS>"
    exit 1
fi

NTHREADS=$3
NTASKS=$NTHREADS
SIZE=$1
NRUNS=$2
SRCDIR=../../../..
echo "
#define __N__ $SIZE
" > $SRCDIR/header.h

cp $SRCDIR/unopt_src/gemver.c $SRCDIR/rose_gemver_final.c
echo -n -e "ics-15-uwomp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $NTHREADS >> results.txt


cp $SRCDIR/rose_gemver.c $SRCDIR/rose_gemver_final.c
echo -n -e "uwopenmp-cps\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $NTHREADS >> results.txt
