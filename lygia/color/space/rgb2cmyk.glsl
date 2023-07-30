#include "../../math/mmin.glsl"
#include "../../math/saturate.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: convert CMYK to RGB
use: rgb2cmyk(<vec3|vec4> rgba)
*/

#ifndef FNC_RGB2CMYK
#define FNC_RGB2CMYK
vec4 rgb2cmyk(vec3 rgb) {
    float k = mmin(1.0 - rgb);
    float invK = 1.0 - k;
    vec3 cmy = (1.0 - rgb - k) / invK;
    cmy *= step(0.0, invK);
    return saturate(vec4(cmy, k));
}
#endif