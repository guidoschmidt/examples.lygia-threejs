#include "../color/space/YCbCr2rgb.hlsl"
#include "../sample.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: a way to solve the YUV camare texture on iOS
use: sampleYUV(<SAMPLER_TYPE> tex1, <SAMPLER_TYPE> tex2, <float2> st)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
*/

#ifndef FNC_SAMPLEYUV
#define FNC_SAMPLEYUV
float4 sampleYUV(in SAMPLER_TYPE tex_Y, in SAMPLER_TYPE tex_UV, in float2 st) {
    float4 yuv = float4(0.0, 0.0, 0.0, 0.0);
    yuv.xw = SAMPLER_FNC(tex_Y, st).ra;
    yuv.yz = SAMPLER_FNC(tex_UV, st).rg;
    return YCbCr2rgb(yuv);
}
#endif
