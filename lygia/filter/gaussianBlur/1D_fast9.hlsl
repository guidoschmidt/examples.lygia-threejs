#include "../../sample.hlsl"

/*
original_author: Matt DesLauriers
description: adapted versions of gaussian fast blur 13 from https://github.com/Jam3/glsl-fast-gaussian-blur
use: gaussianBlur1D_fast9(<SAMPLER_TYPE> texture, <float2> st, <float2> pixel_direction)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - GAUSSIANBLUR1D_FAST9_TYPE
    - GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(TEX, UV)
*/

#ifndef GAUSSIANBLUR1D_FAST9_TYPE
#ifdef GAUSSIANBLUR_TYPE
#define GAUSSIANBLUR1D_FAST9_TYPE GAUSSIANBLUR_TYPE
#else
#define GAUSSIANBLUR1D_FAST9_TYPE float4
#endif
#endif

#ifndef GAUSSIANBLUR1D_FAST9_SAMPLER_FNC
#ifdef GAUSSIANBLUR_SAMPLER_FNC
#define GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(TEX, UV) GAUSSIANBLUR_SAMPLER_FNC(TEX, UV)
#else
#define GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif
#endif

#ifndef FNC_GAUSSIANBLUR1D_FAST9
#define FNC_GAUSSIANBLUR1D_FAST9
GAUSSIANBLUR1D_FAST9_TYPE gaussianBlur1D_fast9(in SAMPLER_TYPE tex, in float2 st, in float2 offset) {
    float2 off1 = float2(1.3846153846, 1.3846153846) * offset;
    float2 off2 = float2(3.2307692308, 3.2307692308) * offset;
    GAUSSIANBLUR1D_FAST9_TYPE color = GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(tex, st) * .2270270270;
    color += GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(tex, st + (off1)) * .3162162162;
    color += GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(tex, st - (off1)) * .3162162162;
    color += GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(tex, st + (off2)) * .0702702703;
    color += GAUSSIANBLUR1D_FAST9_SAMPLER_FNC(tex, st - (off2)) * .0702702703;
    return color;
}
#endif
