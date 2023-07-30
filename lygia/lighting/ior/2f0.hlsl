#include "../../math/pow2.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: index of refraction to reflectance at 0 degree https://handlespixels.wordpress.com/tag/f0-reflectance/
use: <float|float3|float4> ior2f0(<float|float3|float4> ior)
*/

#ifndef FNC_IOR2F0
#define FNC_IOR2F0
float ior2f0(const float ior) { return pow2(ior - 1.0) / pow2(ior + 1.0); }
float3 ior2f0(const float3 ior) { return pow2(ior - 1.0) / pow2(ior + 1.0); }
float4 ior2f0(const float4 ior) { return float4(pow2(ior.rgb - 1.0) / pow2(ior.rgb + 1.0), ior.a); }
#endif