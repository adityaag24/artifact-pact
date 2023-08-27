if [ "$#" -ne 4 ]
then
    echo "usage ./script.sh <N> <C> <NRUNS> <NTHREADS>"
    exit 1
fi

SIZE=$1
C=$2
NRUNS=$3
NTHREADS=$4
NTASKS=$NTHREADS
MACHINE="c2n02"
SRCDIR=../../../..

cp $SRCDIR/unopt_src/knapsack-while.c $SRCDIR/rose_knapsack_final.c
echo -n -e "uwopenmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS>> results.txt
mv knapsack_trans.err knapsack_trans-uwopenmp.err
mv knapsack_trans.out knapsack_trans-uwopenmp.out

cp $SRCDIR/rose_knapsack-no-reuse-opt.c $SRCDIR/rose_knapsack_final.c
echo -n -e "uwomp++-no-reuseopt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
mv knapsack_trans.err knapsack_trans-uwomp++-no-reuse-opt.err
mv knapsack_trans.out knapsack_trans-uwomp++-no-reuse-opt.out

cp $SRCDIR/rose_knapsack-reuse-opt.c $SRCDIR/rose_knapsack_final.c
echo -n -e "uwomp++\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
mv knapsack_trans.err knapsack_trans-uwomp++.err
mv knapsack_trans.out knapsack_trans-uwomp++.out


cp $SRCDIR/rose_knapsack-opt.c $SRCDIR/rose_knapsack_final.c
echo -n -e "uwomp++-opt\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $C $NTHREADS >> results.txt
mv knapsack_trans.err knapsack_trans-uwomp++-opt.err
mv knapsack_trans.out knapsack_trans-uwomp++-opt.out


