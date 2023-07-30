#include "../sample.hlsl"

/*
original_author: [Patricio Gonzalez Vivo, Johan Ismael]
description: Samples multiple times a texture in the specified direction
use: stretch(<SAMPLER_TYPE> tex, <float2> st, <float2> direction [, int samples])
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - STRETCH_SAMPLES: number of samples taken, defaults to 20
    - STRETCH_TYPE: return type, defauls to float4
    - STRETCH_SAMPLER_FNC(TEX, UV): function used to sample the input texture, defaults to texture2D(tex, TEX, UV)
    - STRETCH_WEIGHT: shaping equation to multiply the sample weight.
*/

#ifndef STRETCH_SAMPLES
#define STRETCH_SAMPLES 20
#endif

#ifndef STRETCH_TYPE
#define STRETCH_TYPE float4
#endif

#ifndef STRETCH_SAMPLER_FNC
#define STRETCH_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif

#ifndef FNC_STRETCH
#define FNC_STRETCH
STRETCH_TYPE stretch(in SAMPLER_TYPE tex, in float2 st, in float2 direction, const int i_samples) {
    float f_samples = float(i_samples);
    STRETCH_TYPE color = float(0., 0., 0., 0.);

    #ifdef PLATFORM_WEBGL
    for (int i = 0; i < 50; i++) {
        if (i == i_samples) break;
    #else
    for (int i = 0; i < i_samples; i++) {
    #endif

        float f_sample = float(i);
        STRETCH_TYPE tx = STRETCH_SAMPLER_FNC(tex, st + direction * f_sample);
        #ifdef STRETCH_WEIGHT
        tx *= STRETCH_WEIGHT;
        #endif
        color += tx;
    }
    return color / f_samples;
}

STRETCH_TYPE stretch(in SAMPLER_TYPE tex, in float2 st, in float2 direction) {
    float f_samples = float(STRETCH_SAMPLES);  
    STRETCH_TYPE color = float4(0., 0., 0., 0.);
    for (int i = 0; i < STRETCH_SAMPLES; i++) {
        float f_sample = float(i);    
        STRETCH_TYPE tx = STRETCH_SAMPLER_FNC(tex, st + direction * f_sample);
        #ifdef STRETCH_WEIGHT
        tx *= STRETCH_WEIGHT;    
        #endif
        color += tx;
    }
    return color / f_samples;
}
#endif
