#include "make.cuh"

/*
original_author: Patricio Gonzalez Vivo
description: Sum elements of a vector
use: <float> sum(<float2|float3|float4> value)
*/

#ifndef FNC_SUM
#define FNC_SUM

inline __host__ __device__ float sum( float v ) { return v; }
inline __host__ __device__ float sum( const float2& v ) { return v.x+v.y; }
inline __host__ __device__ float sum( const float3& v ) { return v.x+v.y+v.z; }
inline __host__ __device__ float sum( const float4& v ) { return v.x+v.y+v.z+v.w; }

inline __host__ __device__ int sum( int v ) { return v; }
inline __host__ __device__ int sum( int2 v ) { return v.x+v.y; }
inline __host__ __device__ int sum( int3 v ) { return v.x+v.y+v.z; }
inline __host__ __device__ int sum( int4 v ) { return v.x+v.y+v.z+v.w; }

inline __host__ __device__ uint sum( uint v ) { return v; }
inline __host__ __device__ uint sum( uint2 v ) { return v.x+v.y; }
inline __host__ __device__ uint sum( uint3 v ) { return v.x+v.y+v.z; }
inline __host__ __device__ uint sum( uint4 v ) { return v.x+v.y+v.z+v.w; }

#endif