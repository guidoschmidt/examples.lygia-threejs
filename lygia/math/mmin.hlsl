/*
original_author: Patricio Gonzalez Vivo
description: extend HLSL min function to add more arguments
use: 
  - min(<float> A, <float> B, <float> C[, <float> D])
  - min(<float2|float3|float4> A)
*/

#ifndef FNC_MMIN
#define FNC_MMIN

float mmin(in float a, in float b) { return min(a, b); }
float mmin(in float a, in float b, in float c) { return min(a, min(b, c)); }
float mmin(in float a, in float b, in float c, in float d) { return min(min(a,b), min(c, d)); }

float mmin(const float2 v) { return min(v.x, v.y); }
float mmin(const float3 v) { return mmin(v.x, v.y, v.z); }
float mmin(const float4 v) { return mmin(v.x, v.y, v.z, v.w); }

#endif
