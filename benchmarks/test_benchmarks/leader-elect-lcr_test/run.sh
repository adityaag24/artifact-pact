uwopenmp -rose:openmp:ast_only ./leader_elect_lcr-while.c -global-barrier
echo "================================================================================="
gcc -g ./rose_leader_elect_lcr-while.c -fopenmp
./a.out
