if [ "$#" -ne 3 ]
then
    echo "usage ./script.sh <SIZE> <NRUNS> <NTHREADS>"
    exit 1
fi

NTHREADS=$3
NTASKS=32
SIZE=$1
NRUNS=$2
SRCDIR=../../../..
MACHINE="c2n04"

echo "
#include <float.h>
# define N $SIZE 
//# define EPSILON 1e-60
# define EPSILON 20e-4
//# define VAL (FLT_MAX*(1.0/2.0))
# define VAL (FLT_MAX*(1.0/100000000000000000000000000000000.0))
" > $SRCDIR/header.h

#cp $SRCDIR/unopt_src/iterated_averaging.c $SRCDIR/rose_iterated_averaging_final.c
#echo -n -e "uwopenmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
#
#
#cp $SRCDIR/rose_iterated_averaging-reuse-opt.c $SRCDIR/rose_iterated_averaging_final.c
#echo -n -e "uwomp++\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt

cp $SRCDIR/rose_iterated_averaging-no-reuseopt.c $SRCDIR/rose_iterated_averaging_final.c
echo -n -e "uwomp++-no-reuseopt\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt

#cp $SRCDIR/rose_iterated_averaging-opt.c $SRCDIR/rose_iterated_averaging_final.c
#echo -n -e "uwomp++-opt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
