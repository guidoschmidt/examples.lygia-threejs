#include "shadowLerp.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: sample shadow map using PCF
use:
    - <float> sampleShadowPCF(<SAMPLER_TYPE> depths, <vec2> size, <vec2> uv, <float> compare)
    - <float> sampleShadowPCF(<vec3> lightcoord)
options:
    - LIGHT_SHADOWMAP_BIAS
    - SAMPLESHADOWPCF_SAMPLER_FNC
*/

#ifndef SAMPLESHADOWPCF_SAMPLER_FNC
#define SAMPLESHADOWPCF_SAMPLER_FNC sampleShadowLerp
#endif

#ifndef FNC_SAMPLESHADOWPCF
#define FNC_SAMPLESHADOWPCF

float sampleShadowPCF(SAMPLER_TYPE depths, vec2 size, vec2 uv, float compare) {
    vec2 pixel = 1.0/size;
    float result = 0.0;
    for (float x= -2.0; x <= 2.0; x++)
        for (float y= -2.0; y <= 2.0; y++) 
            result += SAMPLESHADOWPCF_SAMPLER_FNC(depths, size, uv + vec2(x,y) * pixel, compare);
    return result/25.0;
}

#endif