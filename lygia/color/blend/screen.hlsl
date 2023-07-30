/*
original_author: Jamie Owen
description: Photoshop Screen blend mode mplementations sourced from this article on https://mouaif.wordpress.com/2009/01/05/photoshop-math-with-glsl-shaders/
use: blendScreen(<float|float3> base, <float|float3> blend [, <float> opacity])
*/

#ifndef FNC_BLENDSCREEN
#define FNC_BLENDSCREEN
float blendScreen(in float base, in float blend) {
    return 1. - ((1. - base) * (1. - blend));
}

float3 blendScreen(in float3 base, in float3 blend) {
    return float3(  blendScreen(base.r, blend.r),
                    blendScreen(base.g, blend.g),
                    blendScreen(base.b, blend.b) );
}

float3 blendScreen(in float3 base, in float3 blend, float opacity) {
    return (blendScreen(base, blend) * opacity + base * (1. - opacity));
}
#endif
