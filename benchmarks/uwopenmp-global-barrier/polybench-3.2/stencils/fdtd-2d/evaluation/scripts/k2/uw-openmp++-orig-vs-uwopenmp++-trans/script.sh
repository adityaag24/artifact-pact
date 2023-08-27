if [ "$#" -ne 4 ]
then
    echo "usage ./script.sh <SIZE> <TSTPES> <NRUNS> <NTHREADS>"
    exit 1
fi

NTHREADS=$4
NTASKS=$4
SIZE=$1
TSTEPS=$2
NRUNS=$3
SRCDIR=../../../..
echo "
#define __NX__ $SIZE
#define __NY__ $SIZE
#define __TMAX__ $TSTEPS
" > $SRCDIR/header.h

cp $SRCDIR/unopt_src/fdtd-2d.c $SRCDIR/rose_fdtd-2d_final.c
echo -n -e "ics-15-uwomp\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt


cp $SRCDIR/rose_fdtd-2d.c $SRCDIR/rose_fdtd-2d_final.c
echo -n -e "uwopenmp-cps\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh k2n02 $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt
