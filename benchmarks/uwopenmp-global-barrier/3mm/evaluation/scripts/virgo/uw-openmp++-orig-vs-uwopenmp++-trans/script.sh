if [ "$#" -ne 4 ]
then
    echo "usage ./script.sh <SIZE> <NRUNS> <ICS | CPS | OPT | NOOPT> <NTHREADS>"
    exit 1
fi

NTHREADS=$4
NTASKS=32
SIZE=$1
NRUNS=$2
SRCDIR=../../../..
MACHINE=c2n02
echo "
#define N $SIZE
" > $SRCDIR/header.h

if [ $3 = "ICS" ]
then
  cp $SRCDIR/unopt_src/3mm.c $SRCDIR/rose_3mm_final.c
  echo -n -e "uwopenmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
  ./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi


if [ $3 = "CPS" ]
then
cp $SRCDIR/rose_3mm.c $SRCDIR/rose_3mm_final.c
echo -n -e "uwomp++\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi

if [ $3 = "NOOPT" ]
then
cp $SRCDIR/rose_3mm-no-reuseopt.c $SRCDIR/rose_3mm_final.c
echo -n -e "uwomp++-no-reuseopt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi


if [ $3 = "OPT" ]
then
cp $SRCDIR/rose_3mm-opt.c $SRCDIR/rose_3mm_final.c
echo -n -e "uwomp++-opt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi
