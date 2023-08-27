gcc -fopenmp -I ../../utilities -I ../../stencils/jacobi-2d-imper ../../utilities/polybench.c -DPOLYBENCH_TIME jacobi-2d-imper.c -o trans.out
