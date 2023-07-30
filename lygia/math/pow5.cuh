#include "operations.cuh"

/*
original_author: Patricio Gonzalez Vivo
description: power of 5
use: pow5(<float|float2|float3|float4> x)
*/

#ifndef FNC_POW5
#define FNC_POW5

inline __host__ __device__ float pow5(float x) {
    float x2 = x * x;
    return x2 * x2 * x;
}

inline __host__ __device__ float2 pow5(const float2& x) {
    float2 x2 = x * x;
    return x2 * x2 * x;
}

inline __host__ __device__ float3 pow5(const float3& x) {
    float3 x2 = x * x;
    return x2 * x2 * x;
}

inline __host__ __device__ float4 pow5(const float4& x) {
    float4 x2 = x * x;
    return x2 * x2 * x;
}

#endif
