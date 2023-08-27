#!/bin/bash
#PBS -l mem=4gb,nodes=k2n02:ppn=1,walltime=10:00:00
#PBS -m abe
#PBS -o fdtd-2d_8192_trans.out
#PBS -e fdtd-2d_8192_trans.err
export OMP_NUM_THREADS=1
taskset -c 0-0 /home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/polybench-3.2/stencils/fdtd-2d/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans/trans

