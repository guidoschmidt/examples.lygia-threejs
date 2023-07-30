#include "../../math/saturate.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: convert CMYK to RGB
use: cmyk2rgb(<vec4> cmyk)
*/

#ifndef FNC_CMYK2RGB
#define FNC_CMYK2RGB
vec3 cmyk2rgb(vec4 cmyk) {
    float invK = 1.0 - cmyk.w;
    return saturate(1.0-min(vec3(1.0), cmyk.xyz * invK + cmyk.w));
}
#endif