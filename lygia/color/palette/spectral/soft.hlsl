/*
original_author: Patricio Gonzalez Vivo
description: Simpler chroma spectrum 
use: <float3> spectral_soft(<float> value)
*/

#include "../../../math/const.hlsl"

#ifndef FNC_SPECTRAL_SOFT
#define FNC_SPECTRAL_SOFT

float3 spectral_soft(float x) {
    float delta = 0.5;
    float3 color = float3(1.0, 1.0, 1.0);
    float freq = x * PI;
    color.r = sin(freq - delta);
    color.g = sin(freq);
    color.b = sin(freq + delta);
    return pow(color, float3(4.0, 4.0, 4.0));
}

#endif