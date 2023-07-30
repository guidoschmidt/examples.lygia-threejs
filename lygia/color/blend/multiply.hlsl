/*
original_author: Jamie Owen
description: Photoshop Multiply blend mode mplementations sourced from this article on https://mouaif.wordpress.com/2009/01/05/photoshop-math-with-glsl-shaders/
use: blendMultiply(<float|float3> base, <float|float3> blend [, <float> opacity])
*/

#ifndef FNC_BLENDMULTIPLY
#define FNC_BLENDMULTIPLY
float blendMultiply(in float base, in float blend) {
    return base * blend;
}

float3 blendMultiply(in float3 base, in float3 blend) {
    return base * blend;
}

float3 blendMultiply(in float3 base, in float3 blend, float opacity) {
    return (blendMultiply(base, blend) * opacity + base * (1. - opacity));
}
#endif
