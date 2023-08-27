if [ "$#" -ne 4 ]
then
    echo "usage ./script.sh <SIZE> <TSTPES> <NRUNS> <NTHREADS>"
    exit 1
fi

NTHREADS=$4
SIZE=$1
TSTEPS=$2
NRUNS=$3
SRCDIR=../../../..
MACHINE="k2n02"
echo "
#define __SIZE__ $SIZE
#define __TSTEPS__ $TSTEPS
" > $SRCDIR/header.h

cp $SRCDIR/unopt_src/jacobi-2d-imper.c $SRCDIR/rose_jacobi-2d-imper_final.c
echo -n -e "uwopenmp\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS>> results.txt


cp $SRCDIR/rose_jacobi-2d-imper-no-reuseopt.c $SRCDIR/rose_jacobi-2d-imper_final.c
echo -n -e "uwomp++-no-reuseopt\t\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt

cp $SRCDIR/rose_jacobi-2d-imper-reuse-opt.c $SRCDIR/rose_jacobi-2d-imper_final.c
echo -n -e "uwomp++\t\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt

cp $SRCDIR/rose_jacobi-2d-imper-opt.c $SRCDIR/rose_jacobi-2d-imper_final.c
echo -n -e "uwomp++-opt\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt
