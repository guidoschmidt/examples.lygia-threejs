#include "saturate.cuh"
#include "operations.cuh"

/*
original_author: Johan Ismael
description: Map a value between one range to another.
use: map(<float|float2|float3|float4> value, <float|float2|float3|float4> inMin, <float|float2|float3|float4> inMax, <float|float2|float3|float4> outMin, <float|float2|float3|float4> outMax)
*/

#ifndef FNC_MAP
#define FNC_MAP

inline __host__ __device__ float map( float value, float inMin, float inMax ) { return saturate( (value-inMin)/(inMax-inMin)); }
inline __host__ __device__ float2 map( float2 value, float2 inMin, float2 inMax ) { return saturate( (value-inMin)/(inMax-inMin)); }
inline __host__ __device__ float3 map( float3 value, float3 inMin, float3 inMax ) { return saturate( (value-inMin)/(inMax-inMin)); }
inline __host__ __device__ float4 map( float4 value, float4 inMin, float4 inMax ) { return saturate( (value-inMin)/(inMax-inMin)); }

inline __host__ __device__ float map(float value, float inMin, float inMax, float outMin, float outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

inline __host__ __device__ float2 map(float2 value, float2 inMin, float2 inMax, float2 outMin, float2 outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

inline __host__ __device__ float3 map(float3 value, float3 inMin, float3 inMax, float3 outMin, float3 outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

inline __host__ __device__ float4 map(float4 value, float4 inMin, float4 inMax, float4 outMin, float4 outMax) {
  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
}

#endif
