uwopenmp -rose:openmp:ast_only ./wavefront-uwomp++.c -global-barrier
echo "=================================================================================="
gcc -g rose_wavefront-uwomp++.c -fopenmp
./a.out
