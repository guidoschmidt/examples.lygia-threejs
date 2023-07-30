#include "../sample.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: given a texture return a simple box blured pixel
use: boxBlur(<SAMPLER_TYPE> texture, <float2> st, <float2> pixel_offset)
options:
    - BOXBLUR_2D: default to 1D
    - BOXBLUR_ITERATIONS: default 3
    - SAMPLER_FNC(TEX, UV): optional depending the target version of HLSL (tex2D(...) or texture(...))
*/

#ifndef BOXBLUR_ITERATIONS
#define BOXBLUR_ITERATIONS 3
#endif

#ifndef BOXBLUR_TYPE
#define BOXBLUR_TYPE float4
#endif

#ifndef BOXBLUR_SAMPLER_FNC
#define BOXBLUR_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif

#include "boxBlur/1D.hlsl"
#include "boxBlur/2D.hlsl"
#include "boxBlur/2D_fast9.hlsl"

#ifndef FNC_BOXBLUR
#define FNC_BOXBLUR
BOXBLUR_TYPE boxBlur13(in SAMPLER_TYPE tex, in float2 st, in float2 offset) {
#ifdef BOXBLUR_2D
  return boxBlur2D(tex, st, offset, 7);
#else
  return boxBlur1D(tex, st, offset, 7);
#endif
}

BOXBLUR_TYPE boxBlur9(in SAMPLER_TYPE tex, in float2 st, in float2 offset) {
#ifdef BOXBLUR_2D
  return boxBlur2D_fast9(tex, st, offset);
#else
  return boxBlur1D(tex, st, offset, 5);
#endif
}

BOXBLUR_TYPE boxBlur5(in SAMPLER_TYPE tex, in float2 st, in float2 offset) {
#ifdef BOXBLUR_2D
  return boxBlur2D(tex, st, offset, 3);
#else
  return boxBlur1D(tex, st, offset, 3);
#endif
}

BOXBLUR_TYPE boxBlur(in SAMPLER_TYPE tex, in float2 st, float2 offset, const int kernelSize) {
#ifdef BOXBLUR_2D
  return boxBlur2D(tex, st, offset, kernelSize);
#else
  return boxBlur1D(tex, st, offset, kernelSize);
#endif
}

BOXBLUR_TYPE boxBlur(in SAMPLER_TYPE tex, in float2 st, float2 offset) {
  #ifdef BOXBLUR_2D
    return boxBlur2D(tex, st, offset, BOXBLUR_ITERATIONS);
  #else
    return boxBlur1D(tex, st, offset, BOXBLUR_ITERATIONS);
  #endif
}
#endif
