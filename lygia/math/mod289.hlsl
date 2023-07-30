/*
original_author: [Stefan Gustavson, Ian McEwan]
description: modulus of 289
use: mod289(<float|float2|float3|float4> x)

*/
#ifndef FNC_MOD289
#define FNC_MOD289

float mod289(in float x) { return x - floor(x * (1. / 289.)) * 289.; }
float2 mod289(in float2 x) { return x - floor(x * (1. / 289.)) * 289.; }
float3 mod289(in float3 x) { return x - floor(x * (1. / 289.)) * 289.; }
float4 mod289(in float4 x) { return x - floor(x * (1. / 289.)) * 289.; }

#endif
