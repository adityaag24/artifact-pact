if [ "$#" -ne 3 ]
then
    echo "usange run_on_k2.sh <N> <NTHREADS> <MACHINE>"
    exit 1
fi

N=$1
T=$(( N-2 ))
THREADS=$2
MACHINE=$3
echo "SIZE=$N"
#echo "#define PROBLEM_SIZE  $N
#define NITER_DEFAULT 200
#define DT_DEFAULT  0.0001
#define CONVERTDOUBLE FALSE
#define COMPILETIME \"11 Jul 2014\"
#define NPBVERSION \"2.3\"
#define CS1 \"gcc\"
#define CS2 \"gcc\"
#define CS3 \"(none)\"
#define CS4 \"-I../common\"
#define CS5 \"-O3 -lm -fopenmp \"
#define CS6 \"(none)\"
#define CS7 \"randdp\"" > npbparams.h

rundir="/home/raghesh/balancedBarriers/benchmarks/polybench-3.2/stencils/jacobi-2d-imper"
echo "#!/bin/bash
#PBS -l mem=4gb,nodes=$MACHINE:ppn=64,walltime=1:00:00
#PBS -m abe
#PBS -o jacobi_orig.out
#PBS -e jacobi_orig.err
export OMP_NUM_THREADS=$T
taskset -c 0-$(( THREADS - 1 )) $rundir/orig.out
" > openmp_orig.sh

echo "#!/bin/bash
#PBS -l mem=4gb,nodes=$MACHINE:ppn=64,walltime=1:00:00
#PBS -m abe
#PBS -o jacobi_trans.out
#PBS -e jacobi_trans.err
export OMP_NUM_THREADS=$THREADS
taskset -c 0-$(( THREADS - 1 )) $rundir/trans.out
" > openmp_trans.sh
