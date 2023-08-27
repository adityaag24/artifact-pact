
CC = gcc
OBJS = timer.o
FLAGS = -fopenmp
SEQFLAGS = -O3 

EXEC = knapsack knapSeq

all: $(EXEC)

knapSeq: knapsack-ser.c timer.o
	$(CC)  $(SEQFLAGS) -o knapSeq knapsack-ser.c $(OBJS) 

knapsack: knapsack.c timer.o
	$(CC)  $(FLAGS) -o knapsack knapsack.c $(OBJS) 

timer.o: timer.c
	$(CC) -o $@ -c timer.c

clean:
	rm -f $(EXEC) $(OBJS)
