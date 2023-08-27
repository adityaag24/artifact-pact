if [ "$#" -ne 5 ]
then
    echo "usage ./script.sh <SIZE> <NITERS> <NRUNS> <ICS | CPS> <NTHREADS>"
    exit 1
fi

NTHREADS=$5
NTASKS=$5
SIZE=$1
NITERS=$2
NRUNS=$3
SRCDIR=../../../..
MACHINE="k2n02"
echo "
#include <float.h>
#define M $SIZE
#define N $SIZE
#define NITERS $NITERS
" > $SRCDIR/header.h

if [ $4 = "ICS" ]
then
  cp $SRCDIR/unopt_src/sor.c $SRCDIR/rose_sor_final.c
  echo -n -e "uwopenmp\t$SIZE\t$NITERS\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
  ./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS>> results.txt
fi

if [ $4 = "NOOPT" ]
then
cp $SRCDIR/rose_sor-no-reuseopt.c $SRCDIR/rose_sor_final.c
echo -n -e "uwomp++-no-reuseopt\t\t$SIZE\t$NITERS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi



if [ $4 = "CPS" ]
then
cp $SRCDIR/rose_sor.c $SRCDIR/rose_sor_final.c
echo -n -e "uwomp++\t\t$SIZE\t$NITERS\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi


if [ $4 = "OPT" ]
then
cp $SRCDIR/rose_sor-opt.c $SRCDIR/rose_sor_final.c
echo -n -e "uwomp++-opt\t$SIZE\t$NITERS\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
fi
