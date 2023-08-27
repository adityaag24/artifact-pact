all: trans orig task
trans: sor_trans.c header.h
	gcc -O3 -fopenmp sor_trans.c -o trans
orig: sor.c header.h
	gcc -O3 -fopenmp sor.c -o orig
task: sor_task.c header.h
	gcc -O3 -fopenmp sor_task.c -o task
clean:
	rm trans orig task
