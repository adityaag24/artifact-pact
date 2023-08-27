uwopenmp -rose:openmp:ast_only ./iterated_averaging.c -global-barrier
echo "===================================================================================================="
gcc -g ./rose_iterated_averaging.c -fopenmp
./a.out
