#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#define N 1024 // Number of vertices
//#include "uwomp-clock.h"

void bfs_Dijkstra_parallel_clocked(int);
void bfs_Dijkstra_serial(int u);
int getMinDistNode(int u);

typedef struct {
	int u, v, w;
} Edge;

int n; /* the number of nodes */
int e; /* the number of edges */
Edge *edges; // Size e
int *d; /* d[i] is the minimum distance from node s to node i. Size n */
int *num_neighbors; // num_neighbors[i] is the number of neighbours of node i
int **neighbor; // Size n* n
int *predecessor; // Size n
int *visited; // Size n
int **weight; // Size n * n;

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

void bfs_Dijkstra_serial(int u) {
	visited[u] = 1;

	int i;
	for (i = 0; i < num_neighbors[u]; i++) {
		int v = neighbor[u][i];
		if (!visited[v]) {
			int wt = weight[u][i];
			int new_dist = d[u] + wt;
			if (d[v] > new_dist) {
				d[v] = new_dist;
				predecessor[v] = u;
			}
		}
	}

	int new_node = getMinDistNode(u);
	if (new_node != -1) {
		bfs_Dijkstra_serial(new_node);
	}
}



void bfs_Dijkstra_parallel_unclocked(int u) {

	visited[u] = 1; //true

	int i;

	// UwOpenMP change
	omp_set_num_threads(num_neighbors[u]);
	// UwOpenMP change
#pragma omp parallel
	{
#pragma omp for private(i)
		for (i = 0; i < num_neighbors[u]; i++) {
			int v = neighbor[u][i];
			if (!visited[v]) {
				int wt = weight[u][i];
				int new_dist = d[u] + wt;
				if (d[v] > new_dist) {
					d[v] = new_dist;
					predecessor[v] = u;
				}
			}
		}
	}

	int new_node = getMinDistNode(u);
	if (new_node != -1) {
		bfs_Dijkstra_serial(new_node);
	}
}

// Get node the minimum distance among the neighbours of u.
// TODO: This can be improved using a Minheap implementation.
int getMinDistNode(int u) {
	int i;

	// If there are no nieghbors, we cannot move further the the tree will be
	// disconncted.
	if (num_neighbors[u] == 0)
		return -1;

	int min_node = -1;
	int min_node_dist = INFINITY;
	for (i = 0; i < num_neighbors[u]; i++) {
	//for (i = 0; i < n; i++) {
		int v = neighbor[u][i];
		//int v = i;
		// If already visited, we already no the shortest distance to v.
		if (!visited[v]) {
			if (d[v] < min_node_dist) {
				min_node = v;
				min_node_dist = d[v];
			}
		}
	}

	return min_node;
}

void bfs_Dijkstra_parallel_clocked(int u) {

	visited[u] = 1; //true

	int i;

	// UwOpenMP change
	omp_set_num_threads(num_neighbors[u]);
	// UwOpenMP change
	int min_node = -1;
	int min_node_dist = INFINITY;
#pragma omp parallel shared(min_node_dist)
	{
#pragma omp for private(i) lastprivate(min_node) firstprivate(min_node)
		for (i = 0; i < num_neighbors[u]; i++) {
			int v = neighbor[u][i];
			if (!visited[v]) {
				int wt = weight[u][i];
				int new_dist = d[u] + wt;
				if (d[v] > new_dist) {
					d[v] = new_dist;
					predecessor[v] = u;
				}
			}
#pragma omp barrier
			// If already visited, we already know the shortest distance to v.
			if (!visited[v]) {
#pragma omp critical
				{
					if (d[v] < min_node_dist) {
						min_node = v;
						min_node_dist = d[v];
					}
				}
			}
		}
	}

	int new_node = min_node;
	// If there are no nieghbors, we cannot move further the the tree will be
	// disconncted.
	if (new_node != -1) {
		bfs_Dijkstra_parallel_clocked(new_node);
	}
}

void graph_init(char *filename) {
	int w;
	FILE *fp = fopen(filename, "r");
	fscanf(fp, "%d", &n);
	e = 0;

	d = (int *)calloc(n, sizeof(int));
  num_neighbors = (int *)calloc(n, sizeof(int));
	neighbor = (int **)calloc(n, sizeof(int *));
	visited = (int *)calloc(n, sizeof(int));
	predecessor = (int *)calloc(n, sizeof(int));
	weight = (int **)calloc(n, sizeof(int *));

	int i, j;
	for (i = 0; i < n; ++i) {
		num_neighbors[i] = 0;;
		for (j = 0; j < n; ++j) {
			fscanf(fp, "%d", &w);
			if (w != 0) {
				++e;
				num_neighbors[i]++;
			}
		}
		neighbor[i] = (int *)calloc(num_neighbors[i], sizeof(int));
		weight[i] = (int *)calloc(num_neighbors[i], sizeof(int));
	}
  edges = (Edge *)calloc(e, sizeof(Edge));

	rewind(fp);

	fscanf(fp, "%d", &n);

	int e1 = 0;
	for (i = 0; i < n; ++i) {
		int neighbor_index = 0;
		for (j = 0; j < n; ++j) {
			fscanf(fp, "%d", &w);
			if (w != 0) {
				edges[e1].u = i;
				edges[e1].v = j;
				edges[e1].w = w;
				neighbor[i][neighbor_index] = j;
				weight[i][neighbor_index] = w;
				++neighbor_index;
				++e1;
			}
		}
	}

	fclose(fp);
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
		printf("Neighbors for %d:", i);
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
	//bfs_Dijkstra_parallel_clocked(0);
	// UwOpenMP change
	omp_set_nested(1);
	// UwOpenMP change
//#pragma omp parallel
	{
		//bfs_Dijkstra_parallel_clocked(0);
		bfs_Dijkstra_parallel_unclocked(0);
		//bfs_Dijkstra_serial(0);
	}

	printDist();

	return 0;
}
