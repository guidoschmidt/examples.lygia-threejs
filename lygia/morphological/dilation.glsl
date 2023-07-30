#include "../sample.glsl"
#include "../math/saturate.glsl"
#include "../math/sum.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: |
    morphological dilation operation. Based on: 
        https://lettier.github.io/3d-game-shaders-for-beginners/dilation.html
        https://www.shadertoy.com/view/WsyXWc
use: dilation(<SAMPLER_TYPE> texture, <float2> st, <float2> pixels_scale, <int> passes)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - DILATION_TYPE
    - DILATION_SAMPLE_FNC(TEX, UV)
*/

#ifndef DILATION_TYPE
#define DILATION_TYPE float
#endif

#ifndef DILATION_SAMPLE_FNC
#define DILATION_SAMPLE_FNC(TEX, UV) SAMPLER_FNC(TEX, UV).r
#endif

#ifndef FNC_DILATE
#define FNC_DILATE

DILATION_TYPE dilation(SAMPLER_TYPE tex, vec2 st, vec2 pixel, int radius) {

    float invKR = 1.0 / float(radius);
    DILATION_TYPE acc = DILATION_TYPE(0.0);
    float w = 0.0;
    for(int i = -radius; i <= radius; ++i)
    for(int j = -radius; j <= radius; ++j) {
        vec2 rxy = vec2(ivec2(i, j));
        vec2 kst = rxy * invKR * 2.0;
        vec2 texOffset = st + rxy * pixel;
        float kernel = saturate(1.0 - dot(kst, kst));
        DILATION_TYPE t = DILATION_SAMPLE_FNC(tex, texOffset);
        DILATION_TYPE v = t + kernel;
        if (sum(v) > sum(acc)) {
            acc = v;
            w = kernel;
        }
    }
    
    return acc - w;
}

#endif