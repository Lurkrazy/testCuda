#!/bin/bash

# Compile the CUDA program
nvcc -g -o vector_add vector_add.cu

# Profile the program using nv-nsight-cu-cli
#ncu --target-processes all --set full --print-details ./vector_add 2>&1 | tee result.log
ncu --target-processes all --set full  --csv ./vector_add 2>&1 | tee result.log
