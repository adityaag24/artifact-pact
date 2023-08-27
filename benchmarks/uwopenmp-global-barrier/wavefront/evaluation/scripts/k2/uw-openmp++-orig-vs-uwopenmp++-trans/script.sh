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
MACHINE="k2n01"
echo "
#define N $SIZE
#define M $SIZE
" > $SRCDIR/header.h

cp $SRCDIR/input/wavefront-openmp.c $SRCDIR/rose_wavefront_final.c
echo -n -e "openmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS>> results.txt
mv wavefront_trans.err wavefront_trans-openmp.err
mv wavefront_trans.out wavefront_trans-openmp.out

cp $SRCDIR/input/wavefront-uwomp++.c $SRCDIR/rose_wavefront_final.c
echo -n -e "uwomp++\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS>> results.txt
mv wavefront_trans.err wavefront_trans-uwomp++.err
mv wavefront_trans.out wavefront_trans-uwomp++.out


#if [ $3 = "ICS" ]
#then
#  cp $SRCDIR/unopt_src/wavefront.c $SRCDIR/rose_wavefront_final.c
#  echo -n -e "uwopenmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#  ./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
#fi
#
#if [ $3 = "NOOPT" ]
#then
#cp $SRCDIR/rose_wavefront-no-reuseopt.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwomp++-no-reuseopt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
#fi
#
#if [ $3 = "CPS" ]
#then
#cp $SRCDIR/rose_wavefront-reuse-opt.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwomp++\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
#fi
#
#
#if [ $3 = "OPT" ]
#then
#cp $SRCDIR/rose_wavefront-opt.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwomp++-opt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt
#fi
