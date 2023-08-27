uwopenmp -rose:openmp:ast_only ./longest-subseq-uwomp++.c -global-barrier
echo "=================================================================================="
gcc -g rose_longest-subseq-uwomp++.c -fopenmp
./a.out
