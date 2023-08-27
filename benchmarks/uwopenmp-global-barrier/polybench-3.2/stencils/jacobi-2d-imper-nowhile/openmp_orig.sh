#!/bin/bash
#PBS -l mem=4gb,nodes=k2n01:ppn=64,walltime=1:00:00
#PBS -m abe
#PBS -o jacobi_orig.out
#PBS -e jacobi_orig.err
export OMP_NUM_THREADS=3998
taskset -c 0-63 /home/raghesh/balancedBarriers/benchmarks/polybench-3.2/stencils/jacobi-2d-imper/orig.out

