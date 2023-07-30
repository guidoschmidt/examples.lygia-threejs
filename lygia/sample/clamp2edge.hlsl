#include "../sample.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: fakes a clamp to edge texture 
use: <float4> sampleClamp2edge(<SAMPLER_TYPE> tex, <float2> st [, <float2> texResolution]);
options:
    - SAMPLER_FNC(TEX, UV)
*/

#ifndef FNC_SAMPLECLAMP2EDGE
#define FNC_SAMPLECLAMP2EDGE
float4 sampleClamp2edge(SAMPLER_TYPE tex, float2 st, float2 texResolution) {
    float2 pixel = 1.0/texResolution;
    return SAMPLER_FNC( tex, clamp(st, pixel, 1.0-pixel) );
}

float4 sampleClamp2edge(SAMPLER_TYPE tex, float2 st) { 
    return SAMPLER_FNC( tex, clamp(st, float2(0.01, 0.01), float2(0.99,0.99) ) ); 
}
#endif