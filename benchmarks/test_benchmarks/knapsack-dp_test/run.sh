uwopenmp -rose:openmp:ast_only ./knapsack.c -global-barrier
echo "=================================================================================="
gcc -g rose_knapsack.c -fopenmp
./a.out
