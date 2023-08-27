#!/bin/bash
#PBS -l mem=4gb,nodes=k2n02:ppn=64,walltime=3:00:00
#PBS -m abe
#PBS -o iteravg_orig.out
#PBS -e iteravg_orig.err
export OMP_NUM_THREADS=100
taskset -c 0-63 /home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/iterated-averaging/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans/orig

