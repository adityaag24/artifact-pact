for file in ./*.i
do
	gcc-11 -fopenmp -o file file
done

