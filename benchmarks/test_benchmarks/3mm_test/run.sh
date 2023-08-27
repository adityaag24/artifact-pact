uwopenmp -rose:openmp:ast_only ./3mm.c -global-barrier
echo "=================================================================================="
gcc -g rose_3mm.c -fopenmp
./a.out
