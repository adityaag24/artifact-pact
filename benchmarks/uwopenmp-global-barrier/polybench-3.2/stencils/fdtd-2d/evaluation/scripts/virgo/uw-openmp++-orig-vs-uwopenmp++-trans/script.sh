if [ "$#" -ne 4 ]
then
    echo "usage ./script.sh <SIZE> <TSTPES> <NRUNS> <NTHREADS>"
    exit 1
fi

NTHREADS=$4
NTASKS=32
SIZE=$1
TSTEPS=$2
NRUNS=$3
SRCDIR=../../../..
MACHINE="c2n03"
echo "
#define __NX__ $SIZE 
#define __NY__ $SIZE
#define __TMAX__ $TSTEPS
" > $SRCDIR/header.h

#cp $SRCDIR/unopt_src/fdtd-2d.c $SRCDIR/rose_fdtd-2d_final.c
#echo -n -e "uwopenmp\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh c2n03 $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt

#cp $SRCDIR/rose_fdtd-2d-reuse-opt.c $SRCDIR/rose_fdtd-2d_final.c
#echo -n -e "uwomp++\t\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh c2n03 $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt

cp $SRCDIR/rose_fdtd-2d-no-reuseopt.c $SRCDIR/rose_fdtd-2d_final.c
echo -n -e "uwomp++-no-reuseopt\t\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh c2n03 $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt

#cp $SRCDIR/rose_fdtd-2d-opt.c $SRCDIR/rose_fdtd-2d_final.c
#echo -n -e "uwopenmp-cps-opt\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh c2n03 $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt

