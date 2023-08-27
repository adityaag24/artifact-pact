cd 3mm_test
uwopenmp -rose:openmp:ast_only ./3mm.c -global-barrier
gcc -g rose_3mm.c -fopenmp
./a.out >> output.txt
cd ..
echo "---------------------------------------------------------------------------"  >> output.txt
echo "---------------------------------------------------------------------------"

cd iterated-averaging_test
uwopenmp -rose:openmp:ast_only ./iterated_averaging.c -global-barrier
gcc -g ./rose_iterated_averaging.c -fopenmp
./a.out >> output.txt
cd ..
echo "---------------------------------------------------------------------------" >> output.txt
echo "---------------------------------------------------------------------------"

cd iterated-averaging-recursive_test
uwopenmp -rose:openmp:ast_only ./iterated_averaging.c -global-barrier
gcc -g ./rose_iterated_averaging.c -fopenmp
./a.out  >> output.txt
cd ..
echo "---------------------------------------------------------------------------" >> output.txt
echo "---------------------------------------------------------------------------"

cd wavefront_test
uwopenmp -rose:openmp:ast_only ./wavefront-uwomp++.c -global-barrier
gcc -g rose_wavefront-uwomp++.c -fopenmp
./a.out >> output.txt
cd ..
echo "---------------------------------------------------------------------------" >> output.txt
echo "---------------------------------------------------------------------------"
