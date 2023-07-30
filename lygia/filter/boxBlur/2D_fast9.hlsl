#include "../../sample.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: simple two dimentional box blur, so can be apply in a single pass
use: boxBlur1D_fast9(<SAMPLER_TYPE> texture, <float2> st, <float2> pixel_direction)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - BOXBLUR2D_FAST9_TYPE: Default is `float4`
    - BOXBLUR2D_FAST9_SAMPLER_FNC(TEX, UV): Default is `texture2D(tex, TEX, UV)`
*/

#ifndef BOXBLUR2D_FAST9_TYPE
#ifdef BOXBLUR_TYPE
#define BOXBLUR2D_FAST9_TYPE BOXBLUR_TYPE
#else
#define BOXBLUR2D_FAST9_TYPE float4
#endif
#endif

#ifndef BOXBLUR2D_FAST9_SAMPLER_FNC
#ifdef BOXBLUR_SAMPLER_FNC
#define BOXBLUR2D_FAST9_SAMPLER_FNC(TEX, UV) BOXBLUR_SAMPLER_FNC(TEX, UV)
#else
#define BOXBLUR2D_FAST9_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif
#endif

#ifndef FNC_BOXBLUR2D_FAST9
#define FNC_BOXBLUR2D_FAST9
BOXBLUR2D_FAST9_TYPE boxBlur2D_fast9(in SAMPLER_TYPE tex, in float2 st, in float2 offset) {
    BOXBLUR2D_FAST9_TYPE color = BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st);           // center
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(-offset.x, offset.y));  // tleft
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(-offset.x, 0.));        // left
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(-offset.x, -offset.y)); // bleft
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(0., offset.y));         // top
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(0., -offset.y));        // bottom
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + offset);                     // tright
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(offset.x, 0.));         // right
    color += BOXBLUR2D_FAST9_SAMPLER_FNC(tex, st + float2(offset.x, -offset.y));  // bright
    return color * 0.1111111111; // 1./9.
}
#endif
