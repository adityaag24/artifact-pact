rm transnoreuse; gcc   -O3 -fopenmp -I ./../../utilities -I ./../../stencils/jacobi-1d-imper ./../../utilities/polybench.c -DPOLYBENCH_TIME ./rose_jacobi-1d-imper-no-reuseopt.c -o transnoreuse
rm transreuse; gcc  -O3 -fopenmp -I ./../../utilities -I ./../../stencils/jacobi-1d-imper ./../../utilities/polybench.c -DPOLYBENCH_TIME ./rose_jacobi-1d-imper-reuse-opt.c -o transreuse
rm transopt; gcc  -O3 -fopenmp -I ./../../utilities -I ./../../stencils/jacobi-1d-imper ./../../utilities/polybench.c -DPOLYBENCH_TIME ./rose_jacobi-1d-imper-opt.c -o transopt
