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
MACHINE="c2n02"
echo "
#define __SIZE__ $SIZE
#define __TSTEPS__ $TSTEPS
" > $SRCDIR/header.h

echo `date` >> results.txt

cp $SRCDIR/unopt_src/jacobi-1d-imper.c $SRCDIR/rose_jacobi-1d-imper_final.c
echo -n -e "uwopenmp\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./valrun_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt
mv jacobi-1d_"$SIZE"_"$TSTEPS"_trans.err jacobi-1d_"$SIZE"_"$TSTEPS"_uwopenmp.err
#mv massif.out.* massif."$SIZE"."$TSTEPS"_uwopenmp.out

cp $SRCDIR/rose_jacobi-1d-imper-no-reuseopt.c $SRCDIR/rose_jacobi-1d-imper_final.c
echo -n -e "uwomp++-no-reuseopt\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./valrun_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt
mv jacobi-1d_"$SIZE"_"$TSTEPS"_trans.err jacobi-1d_"$SIZE"_"$TSTEPS"_uwomp++-naive.err
#mv massif.out.* massif."$SIZE"."$TSTEPS"_uwomp++-naive.out

cp $SRCDIR/rose_jacobi-1d-imper-reuse-opt.c $SRCDIR/rose_jacobi-1d-imper_final.c
echo -n -e "uwomp++\t\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./valrun_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt
mv jacobi-1d_"$SIZE"_"$TSTEPS"_trans.err jacobi-1d_"$SIZE"_"$TSTEPS"_uwomp++.err
#mv massif.out.* massif."$SIZE"."$TSTEPS"_uwomp++.out

cp $SRCDIR/rose_jacobi-1d-imper-opt.c $SRCDIR/rose_jacobi-1d-imper_final.c
echo -n -e "uwomp++-opt\t$SIZE\t$TSTEPS\t$NTASKS\t$NTHREADS\t$NRUNS\t$MACHINE " >> results.txt
./valrun_all_trans.sh $MACHINE $NRUNS $SIZE $TSTEPS $NTHREADS >> results.txt
mv jacobi-1d_"$SIZE"_"$TSTEPS"_trans.err jacobi-1d_"$SIZE"_"$TSTEPS"_uwomp++-opt.err
#mv massif.out.* massif."$SIZE"."$TSTEPS"_uwomp++-opt.out
