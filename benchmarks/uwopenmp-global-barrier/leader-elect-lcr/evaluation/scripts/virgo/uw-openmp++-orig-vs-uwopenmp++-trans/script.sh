if [ "$#" -ne 3 ]
then
    echo "usage ./script.sh <SIZE> <NRUNS> <NTHREADS>"
    exit 1
fi

NTHREADS=$3
NTASKS=32
SIZE=$1
NRUNS=$2
SRCDIR=../../../..
MACHINE="c2n03"

#cp $SRCDIR/unopt_src/leader_elect_lcr-while.c $SRCDIR/rose_leader_elect_lcr-while_final.c
#echo -n -e "uwopenmp\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt


#cp $SRCDIR/rose_leader_elect_lcr-while-reuse-opt.c $SRCDIR/rose_leader_elect_lcr-while_final.c
#echo -n -e "uwomp++\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt

cp $SRCDIR/rose_leader_elect_lcr-while-no-reuseopt.c $SRCDIR/rose_leader_elect_lcr-while_final.c
echo -n -e "uwomp++-no-reuseopt\t\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./run_all_trans.sh $MACHINE $NRUNS $SIZE $NTHREADS >> results.txt

#cp $SRCDIR/rose_leader_elect_lcr-while-opt.c $SRCDIR/rose_leader_elect_lcr-while_final.c
#echo -n -e "uwomp++\t$SIZE\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
#./run_all_trans.sh c2n03 $NRUNS $SIZE $NTHREADS >> results.txt
