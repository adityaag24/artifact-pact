gcc -fopenmp -I ../../utilities -I ../../stencils/fdtd-2d ../../utilities/polybench.c -DPOLYBENCH_TIME fdtd-2d.c -o trans.out
