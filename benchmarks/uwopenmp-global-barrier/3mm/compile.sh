rm transnoreuse; gcc -O3 -fopenmp rose_3mm-no-reuseopt.c -o transnoreuse
rm transreuse; gcc -O3 -fopenmp rose_3mm-reuse-opt.c -o transreuse
rm transopt; gcc -O3 -fopenmp rose_3mm-opt.c -o transopt
