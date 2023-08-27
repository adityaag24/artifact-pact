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
#include <float.h>
# define N $SIZE 
//# define EPSILON 1e-60
# define EPSILON 20e-4
//# define VAL (FLT_MAX*(1.0/2.0))
# define VAL (FLT_MAX*(1.0/100000000000000000000000000000000.0))
" > $SRCDIR/header.h

cp $SRCDIR/unopt_src/iterated_averaging.c $SRCDIR/rose_iterated_averaging_final.c
echo -n -e "ics-15-uwomp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $NTHREADS>> results.txt


cp $SRCDIR/rose_iterated_averaging.c $SRCDIR/rose_iterated_averaging_final.c
echo -n -e "uwopenmp-cps\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $NTHREADS>> results.txt
