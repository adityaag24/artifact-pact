#!/bin/bash
#PBS -l mem=4gb,nodes=k2n02:ppn=64,walltime=10:00:00
#PBS -m abe
#PBS -o jacobi-2d_128_trans.out
#PBS -e jacobi-2d_128_trans.err
export OMP_NUM_THREADS=64
taskset -c 0-63 /home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/polybench-3.2/stencils/jacobi-2d-imper/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans/trans

