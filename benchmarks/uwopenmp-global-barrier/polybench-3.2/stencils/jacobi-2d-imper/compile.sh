rm transnoreuse; gcc   -O3 -fopenmp -I ./../../utilities -I ./../../stencils/jacobi-2d-imper ./../../utilities/polybench.c -DPOLYBENCH_TIME ./rose_jacobi-2d-imper-no-reuseopt.c -o transnoreuse
rm transreuse; gcc   -O3 -fopenmp -I ./../../utilities -I ./../../stencils/jacobi-2d-imper ./../../utilities/polybench.c -DPOLYBENCH_TIME ./rose_jacobi-2d-imper-reuse-opt.c -o transreuse
rm transopt; gcc   -O3 -fopenmp -I ./../../utilities -I ./../../stencils/jacobi-2d-imper ./../../utilities/polybench.c -DPOLYBENCH_TIME ./rose_jacobi-2d-imper-opt.c -o transopt
