#include "../sample.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: Standar way to get normals from a normal map
use: sampleNormal(<SAMPLER_TYPE> tex, <float2> st)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
*/

#ifndef FNC_SAMPLENORMALMAP
#define FNC_SAMPLENORMALMAP
float3 sampleNormalMap(in SAMPLER_TYPE tex, in float2 st) { return SAMPLER_FNC(tex, st).xyz * 2.0 - 1.0; }
#endif
