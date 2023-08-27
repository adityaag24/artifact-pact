#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#define N 1024 // Number of vertices
//#include "uwomp-clock.h"

void bfs_parallel_clocked(int);

typedef struct {
	int u, v, w;
} Edge;

int n; /* the number of nodes */
int e; /* the number of edges */
Edge *edges; // Size e
int *d; /* d[i] is the minimum distance from node s to node i. Size n */
int *num_neighbors; // num_neighbors[i] is the number of neighbours of node i
int **neighbor; // Size n*n
int *predecessor; // Size n
int *visited; // Size n

#define INFINITY 10000

void printDist() {
	int i;

	printf("Distances:\n");

	for (i = 0; i < n; ++i)
		printf("to %d: %d\t", i, d[i]);
	printf("\n");

	printf("Predecessor:\n");
	for (i = 0; i < n; ++i) 
		printf("of %d: %d\t", i, predecessor[i]);

	printf("\n\n");
}

void bfs_parallel_clocked(int u) {
	int i;

#pragma omp critical
	{  
		visited[u] = 1; //true
	}


	// UwOpenMP change
	omp_set_num_threads(num_neighbors[u]);
	// UwOpenMP change
#pragma omp parallel
	{
#pragma omp for private(i)
		for (i = 0; i < num_neighbors[u]; ++i) {
//#pragma uwomp_clocked (i)
			int v = neighbor[u][i];
#pragma omp critical
			{
				if (d[v] > (d[u] + 1)) {
					d[v] = d[u] + 1;
					predecessor[v] = u;
					visited[v] = 0; // false
				}
			}

			//#pragma uwomp_advance_all
	// UwOpenMP change
#pragma omp barrier

			if (!visited[v]) {
				bfs_parallel_clocked(v);
			}
		}
	}
}


void graph_init(char *filename) {
	int w;
	FILE *fin = fopen(filename, "r");
	fscanf(fin, "%d", &n);
	e = 0;

	d = (int *)calloc(n, sizeof(int));
  num_neighbors = (int *)calloc(n, sizeof(int));
	neighbor = (int **)calloc(n, sizeof(int *));
	visited = (int *)calloc(n, sizeof(int));
	predecessor = (int *)calloc(n, sizeof(int));

	int i, j;
	for (i = 0; i < n; ++i) {
		num_neighbors[i] = 0;;
		for (j = 0; j < n; ++j) {
			fscanf(fin, "%d", &w);
			if (w != 0) {
				++e;
				num_neighbors[i]++;
			}
		}
		printf("Num Neighbors for %d %d:\n", i, num_neighbors[i]);
		neighbor[i] = (int *)calloc(num_neighbors[i], sizeof(int));
	}
	fclose(fin);

  edges = (Edge *)calloc(e, sizeof(Edge));

	fin = fopen(filename, "r");
	fscanf(fin, "%d", &n);

	int e1 = 0;
	for (i = 0; i < n; ++i) {
		int neighbor_index = 0;
		for (j = 0; j < n; ++j) {
			fscanf(fin, "%d", &w);
			if (w != 0) {
				edges[e1].u = i;
				edges[e1].v = j;
				edges[e1].w = w;
				neighbor[i][neighbor_index] = j;
				++neighbor_index;
				++e1;
			}
		}
	}

	fclose(fin);
}

void bfs_init() {
	int i;
	for (i = 0; i < n; ++i) {
		visited[i] = 0; // false.
		d[i] = INFINITY;
		predecessor[i] = INFINITY;
	}
}

void printNeighbors() {
	int i, j;

	for (i = 0; i < n; i++) {
		printf("Neighbors for %d %d:", i);
		for (j = 0; j < num_neighbors[i]; j++) {
			printf("\t %d", neighbor[i][j]);
		}
		printf("\n");
	}
}

int main(int argc, char *argv[]) {
	int i, j, k;

	if (argc != 2) {
		printf("Usage: ./a.out <input-file>\n");
		exit(0);
	}


	graph_init(argv[1]);

	bfs_init();

	printNeighbors();

	/* printDist(); */

	//#pragma omp parallel
	d[0] = 0;
	//bfs_parallel_clocked(0);
	// UwOpenMP change
	omp_set_nested(1);
	// UwOpenMP change
//#pragma omp parallel
	{
		bfs_parallel_clocked(0);
	}

	printDist();

	return 0;
}
