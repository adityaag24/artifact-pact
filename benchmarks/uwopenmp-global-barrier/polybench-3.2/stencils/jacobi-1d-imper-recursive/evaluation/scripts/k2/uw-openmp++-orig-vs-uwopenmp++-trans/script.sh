if [ "$#" -ne 3 ]
then
    echo "usage ./script.sh <SIZE> <TSTPES> <NRUNS>"
    exit 1
fi

NTHREADS=64
SIZE=$1
TSTEPS=$2
NRUNS=$3
SRCDIR=../../../..
echo "
#define __SIZE__ $SIZE
#define __TSTEPS__ $TSTEPS
" > $SRCDIR/header.h

cp $SRCDIR/unopt_src/jacobi-1d-imper.c $SRCDIR/rose_jacobi-1d-imper_final.c
echo -n -e "ics-15-uwomp\t$SIZE\t$TSTEPS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $TSTEPS >> results.txt


cp $SRCDIR/rose_jacobi-1d-imper.c $SRCDIR/rose_jacobi-1d-imper_final.c
echo -n -e "uwopenmp-cps\t$SIZE\t$TSTEPS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $TSTEPS >> results.txt
