#include "../sample.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: sharpening filter
use: sharpen(<SAMPLER_TYPE> texture, <vec2> st, <vec2> renderSize [, float streanght])
options:
    - SHARPEN_KERNELSIZE: Defaults 2
    - SHARPEN_TYPE: defaults to vec3
    - SHARPEN_SAMPLER_FNC(TEX, UV): defaults to texture2D(TEX, UV).rgb
    - SHARPEN_FNC: defaults to sharpenFast
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
*/

#ifndef RADIALBLUR_SAMPLER_FNC
#define RADIALBLUR_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif

#ifndef SHARPEN_TYPE
#define SHARPEN_TYPE vec3
#endif

#ifndef SHARPEN_SAMPLER_FNC
#define SHARPEN_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV).rgb
#endif

#ifndef SHARPEN_FNC
#define SHARPEN_FNC sharpenFast
#endif

#include "sharpen/fast.glsl"
#include "sharpen/adaptive.glsl"
#include "sharpen/contrastAdaptive.glsl"

#ifndef FNC_SHARPEN
#define FNC_SHARPEN

SHARPEN_TYPE sharpen(in SAMPLER_TYPE tex, in vec2 st, in vec2 pixel, float strenght) {
    return SHARPEN_FNC (tex, st, pixel, strenght);
}

SHARPEN_TYPE sharpen(in SAMPLER_TYPE tex, in vec2 st, in vec2 pixel) {
    return SHARPEN_FNC (tex, st, pixel);
}

#endif 