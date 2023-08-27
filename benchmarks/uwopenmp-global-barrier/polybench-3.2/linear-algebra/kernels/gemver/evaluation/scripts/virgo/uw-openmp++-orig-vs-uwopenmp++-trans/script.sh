if [ "$#" -ne 3 ]
then
    echo "usage ./script.sh <SIZE> <NRUNS> <NTRHEDS>"
    exit 1
fi

NTHREADS=$3
NTASKS=32
SIZE=$1
NRUNS=$2
SRCDIR=../../../..
MACHINE="c2n04"
echo "
#define __N__ $SIZE
" > $SRCDIR/header.h

#cp $SRCDIR/unopt_src/gemver.c $SRCDIR/rose_gemver_final.c
#echo -n -e "uwopenmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
#
#
#cp $SRCDIR/rose_gemver-reuse-opt.c $SRCDIR/rose_gemver_final.c
#echo -n -e "uwomp++\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt

cp $SRCDIR/rose_gemver-no-reuseopt.c $SRCDIR/rose_gemver_final.c
echo -n -e "uwomp++-no-reuseopt\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt

#cp $SRCDIR/rose_gemver-opt.c $SRCDIR/rose_gemver_final.c
#echo -n -e "uwomp++-opt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
