all: trans orig 
trans: 3mm_trans.c header.h
	gcc -O3 -fopenmp 3mm_trans.c -o trans
orig: 3mm.c header.h
	gcc -O3 -fopenmp 3mm.c -o orig
clean:
	rm trans orig 
