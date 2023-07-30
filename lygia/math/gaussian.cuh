/*
original_author: Patricio Gonzalez Vivo
description: gaussian coeficient
use: <float4|float3|float2|float> gaussian(<float> sigma, <float4|float3|float2|float> d)
*/

#ifndef FNC_GAUSSIAN
#define FNC_GAUSSIAN

#include <cuda_runtime.h>

inline __host__ __device__ float gaussian(        float d, float sigma) { return exp(-(d*d) / (2.0f * sigma*sigma)); }
inline __host__ __device__ float gaussian(const float2& d, float sigma) { return exp(-( d.x*d.x + d.y*d.y) / (2.0f * sigma*sigma)); }
inline __host__ __device__ float gaussian(const float3& d, float sigma) { return exp(-( d.x*d.x + d.y*d.y + d.z*d.z ) / (2.0f * sigma*sigma)); }
inline __host__ __device__ float gaussian(const float4& d, float sigma) { return exp(-( d.x*d.x + d.y*d.y + d.z*d.z + d.w*d.w ) / (2.0f * sigma*sigma)); }

#endif