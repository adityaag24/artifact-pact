int num_bytes_allocated = 0;
int num_mallocs =0;

#define calloc(num_elements, size) calloc(num_elements, size); _Pragma("omp critical") {num_mallocs += 1; num_bytes_allocated += num_elements*size;}
#define malloc(size) malloc(size); _Pragma("omp critical") {num_mallocs += 1; num_bytes_allocated += size;}
#define print_malloc_stats() {fprintf(stderr, "nummallocs = %d num_bytes_allocated = %d", num_mallocs, num_bytes_allocated);}

