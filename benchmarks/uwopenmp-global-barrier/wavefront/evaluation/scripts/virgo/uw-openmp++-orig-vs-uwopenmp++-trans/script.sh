if [ "$#" -ne 3 ]
then
    echo "usage ./script.sh <N> <NRUNS> <NTHREADS>"
    exit 1
fi

SIZE=$1
NRUNS=$2
NTHREADS=$3
NTASKS=$NTHREADS
MACHINE="c2n01"
SRCDIR=../../../..

echo "
#define N $SIZE
#define M $SIZE
" > $SRCDIR/header.h

cp $SRCDIR/input/wavefront-openmp.c $SRCDIR/rose_wavefront_final.c
echo -n -e "openmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS>> results.txt
mv wavefront_trans.err wavefront_trans-openmp.err
mv wavefront_trans.out wavefront_trans-openmp.out


#cp $SRCDIR/unopt_src/wavefront-while.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwopenmp\t$SIZE\t$C\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS>> results.txt
#mv wavefront_trans.err wavefront_trans-uwopenmp.err
#mv wavefront_trans.out wavefront_trans-uwopenmp.out
#
#cp $SRCDIR/rose_wavefront-no-reuseopt.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwomp++-no-reuseopt\t$SIZE\t$C\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
#mv wavefront_trans.err wavefront_trans-uwomp++-no-reuse-opt.err
#mv wavefront_trans.out wavefront_trans-uwomp++-no-reuse-opt.out
#
#cp $SRCDIR/rose_wavefront-reuse-opt.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwomp++\t$SIZE\t$C\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
#mv wavefront_trans.err wavefront_trans-uwomp++.err
#mv wavefront_trans.out wavefront_trans-uwomp++.out
#
#
#cp $SRCDIR/rose_wavefront-opt.c $SRCDIR/rose_wavefront_final.c
#echo -n -e "uwomp++-opt\t$SIZE\t$C\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
#mv wavefront_trans.err wavefront_trans-uwomp++-opt.err
#mv wavefront_trans.out wavefront_trans-uwomp++-opt.out
#
#
