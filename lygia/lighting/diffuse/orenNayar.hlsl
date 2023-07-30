/*
original_author: Patricio Gonzalez Vivo
description: calculate diffuse contribution using Oren and Nayar equation https://en.wikipedia.org/wiki/Oren%E2%80%93Nayar_reflectance_model
use: 
    - <float> diffuseOrenNayar(<float3> light, <float3> normal, <float3> view, <float> roughness )
    - <float> diffuseOrenNayar(<float3> L, <float3> N, <float3> V, <float> NoV, <float> NoL, <float> roughness)
*/

#ifndef FNC_DIFFUSE_ORENNAYAR
#define FNC_DIFFUSE_ORENNAYAR

float diffuseOrenNayar(float3 L, float3 N, float3 V, float NoV, float NoL, float roughness) {
    float LoV = dot(L, V);
    
    float s = LoV - NoL * NoV;
    float t = lerp(1.0, max(NoL, NoV), step(0.0, s));

    float sigma2 = roughness * roughness;
    float A = 1.0 + sigma2 * (1.0 / (sigma2 + 0.13) + 0.5 / (sigma2 + 0.33));
    float B = 0.45 * sigma2 / (sigma2 + 0.09);

    return max(0.0, NoL) * (A + B * s / t);
}

float diffuseOrenNayar(float3 L, float3 N, float3 V, float roughness) {
    float NoV = max(dot(N, V), 0.001);
    float NoL = max(dot(N, L), 0.001);
    return diffuseOrenNayar(L, N, V, NoV, NoL, roughness);
}

#endif