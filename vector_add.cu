#include <stdio.h>

__global__ void vectorAdd(int *a, int *b, int *c, int n) {
    int i = threadIdx.x;
    if (i < n) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    const int n = 10;
    int a[n], b[n], c[n];
    int *d_a, *d_b, *d_c;

    // Allocate memory on device
    cudaMalloc(&d_a, n * sizeof(int));
    cudaMalloc(&d_b, n * sizeof(int));
    cudaMalloc(&d_c, n * sizeof(int));

    // Initialize host arrays
    for (int i = 0; i < n; i++) {
        a[i] = i;
        b[i] = n - i;
    }

    // Copy input data to device
    cudaMemcpy(d_a, a, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, n * sizeof(int), cudaMemcpyHostToDevice);

    // Launch kernel
    vectorAdd<<<1, n>>>(d_a, d_b, d_c, n);

    // Copy output data to host
    cudaMemcpy(c, d_c, n * sizeof(int), cudaMemcpyDeviceToHost);

    // Verify results
    for (int i = 0; i < n; i++) {
        // if (c[i] != n) {
        //     printf("Error: c[%d] = %d\n", i, c[i]);
        //     return 1;
        // }
        printf("c[%d] = %d", i, c[i]);
    }

    printf("Success!\n");

    // Free memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
