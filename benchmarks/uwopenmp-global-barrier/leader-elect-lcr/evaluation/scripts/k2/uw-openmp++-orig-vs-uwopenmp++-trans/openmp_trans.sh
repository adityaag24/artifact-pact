#!/bin/bash
#PBS -l mem=4gb,nodes=k2n01:ppn=64,walltime=12:00:00
#PBS -m abe
#PBS -o lcr_trans.out
#PBS -e lcr_trans.err
export OMP_NUM_THREADS=64
taskset -c 0-63 /home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/leader-elect-lcr/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans/trans -in /home/induk/raghesh/uw-openmp/benchmarks/uwopenmp-global-barrier/leader-elect-lcr/evaluation/scripts/k2/uw-openmp++-orig-vs-uwopenmp++-trans/../../../../inputleader_elect_lcr_131072.txt -ver

