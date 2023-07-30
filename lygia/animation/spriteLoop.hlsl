#include "../sample/sprite.hlsl"
#include "../math/mod.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: sample a frame on a sprite sheet
use: <SPRITELOOP_TYPE> SpriteLOOP(<SAMPLER_TYPE >tex, <float2> st, <float2> grid, <float> frame)
options:
    - SAMPLER_FNC(TEX, UV)
    - SAMPLESPRITE_TYPE: float4
    - SAMPLESPRITE_SAMPLER_FNC(UV)
*/

#ifndef FNC_SPRITELOOP
#define FNC_SPRITELOOP

SAMPLESPRITE_TYPE spriteLoop(SAMPLER_TYPE tex, float2 st, float2 grid, float start_index, float end_index, float time) {
    float frame = mod(time, end_index-start_index);
    return sampleSprite(tex, st, grid, start_index + frame);
}

#endif