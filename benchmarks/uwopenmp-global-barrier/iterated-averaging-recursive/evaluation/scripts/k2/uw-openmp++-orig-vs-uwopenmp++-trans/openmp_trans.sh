#!/bin/bash
#PBS -l mem=4gb,nodes=k2n02:ppn=64,walltime=3:00:00
#PBS -m abe
#PBS -o iteravg_trans.out
#PBS -e iteravg_trans.err
export OMP_NUM_THREADS=32
taskset -c 0-31 /home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/iterated-averaging/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans/trans

