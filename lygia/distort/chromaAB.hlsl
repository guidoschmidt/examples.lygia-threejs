#include "../math/lengthSq.hlsl"
#include "../sample.hlsl"

/*
original_author: Patricio Gonzalez Vivo, Johan Ismael
description: Chroma Aberration inspired by https://www.shadertoy.com/view/4sX3z4
use: chromaAB(<SAMPLER_TYPE> texture, <float2> st [, <float|float2> sdf|offset, <float> pct])
options:
    CHROMAAB_TYPE: return type, defauls to float3
    CHROMAAB_PCT: amount of aberration, defaults to 1.5
    CHROMAAB_SAMPLER_FNC: function used to sample the input texture, defaults to texture2D(TEX, UV)
    CHROMAAB_CENTER_BUFFER: scalar to attenuate the sdf passed in   
*/

#ifndef CHROMAAB_PCT
#define CHROMAAB_PCT 1.5
#endif

#ifndef CHROMAAB_TYPE
#define CHROMAAB_TYPE float3
#endif

#ifndef CHROMAAB_SAMPLER_FNC
#define CHROMAAB_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif

#ifndef FNC_CHROMAAB
#define FNC_CHROMAAB

CHROMAAB_TYPE chromaAB(in SAMPLER_TYPE tex, in float2 st, in float2 direction, in float3 distortion ) {
    CHROMAAB_TYPE c = float4(1., 1., 1., 1.);
    c.r = CHROMAAB_SAMPLER_FNC(tex, st + direction * distortion.r).r;
    c.g = CHROMAAB_SAMPLER_FNC(tex, st + direction * distortion.g).g;
    c.b = CHROMAAB_SAMPLER_FNC(tex, st + direction * distortion.b).b;
    return c;
}

CHROMAAB_TYPE chromaAB(in SAMPLER_TYPE tex, in float2 st, in float2 offset, in float pct) {

  #ifdef CHROMAAB_CENTER_BUFFER
    // modify the distance from the center, so that only the edges are affected
    offset = max(offset - CHROMAAB_CENTER_BUFFER, 0.);
  #endif

  // Distort the UVs
  float2 stR = st * (1.0 + offset * 0.02 * pct),
       stB = st * (1.0 - offset * 0.02 * pct);

  // Get the individual channels using the modified UVs
  CHROMAAB_TYPE c = float4(1., 1., 1., 1.);
  c.r = CHROMAAB_SAMPLER_FNC(tex, stR).r;
  c.g = CHROMAAB_SAMPLER_FNC(tex, st).g;
  c.b = CHROMAAB_SAMPLER_FNC(tex, stB).b;
  return c;
}

CHROMAAB_TYPE chromaAB(in SAMPLER_TYPE tex, in float2 st, in float sdf, in float pct) {
  return chromaAB(tex, st, float2(sdf, sdf), pct);
}

CHROMAAB_TYPE chromaAB(in SAMPLER_TYPE tex, in float2 st, in float sdf) {
  return chromaAB(tex, st, sdf, CHROMAAB_PCT);
}

CHROMAAB_TYPE chromaAB(in SAMPLER_TYPE tex, in float2 st, in float2 offset) {
  return chromaAB(tex, st, offset, CHROMAAB_PCT);
}

CHROMAAB_TYPE chromaAB(in SAMPLER_TYPE tex, in float2 st) {
  return chromaAB(tex, st, lengthSq(st - .5), CHROMAAB_PCT);
}

#endif
