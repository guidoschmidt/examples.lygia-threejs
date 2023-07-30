/*
original_author: Patricio Gonzalez Vivo
description: gaussian coeficient
use: <float4|float3|float2|float> gaussian(<float4|float3|float2|float> d, <float> sigma)
*/

#ifndef FNC_GAUSSIAN
#define FNC_GAUSSIAN

inline __host__ __device__ float gaussian( float d, float sigma) { return exp(-(d*d) / (2.0 * sigma*sigma)); }
inline __host__ __device__ float gaussian(float2 d, float sigma) { return exp(-( d.x*d.x + d.y*d.y) / (2.0 * sigma*sigma)); }
inline __host__ __device__ float gaussian(float3 d, float sigma) { return exp(-( d.x*d.x + d.y*d.y + d.z*d.z ) / (2.0 * sigma*sigma)); }
inline __host__ __device__ float gaussian(float4 d, float sigma) { return exp(-( d.x*d.x + d.y*d.y + d.z*d.z + d.w*d.w ) / (2.0 * sigma*sigma)); }

#endif