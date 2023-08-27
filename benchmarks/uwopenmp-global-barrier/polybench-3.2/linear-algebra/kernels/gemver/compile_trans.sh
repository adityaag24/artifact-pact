gcc -fopenmp -I ../../../utilities -I ../../../linear-algebra/kernels/gemver  ../../../utilities/polybench.c -DPOLYBENCH_TIME gemver.c -o trans.out
