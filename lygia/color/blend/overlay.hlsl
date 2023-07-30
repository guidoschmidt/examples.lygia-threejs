/*
original_author: Jamie Owen
description: Photoshop Overlay blend mode mplementations sourced from this article on https://mouaif.wordpress.com/2009/01/05/photoshop-math-with-glsl-shaders/
use: blendOverlay(<float|float3> base, <float|float3> blend [, <float> opacity])
*/

#ifndef FNC_BLENDOVERLAY
#define FNC_BLENDOVERLAY
float blendOverlay(in float base, in float blend) {
    return (base < .5)? (2.*base*blend): (1. - 2. * (1. - base) * (1. - blend));
}

float3 blendOverlay(in float3 base, in float3 blend) {
    return float3(  blendOverlay(base.r, blend.r),
                    blendOverlay(base.g, blend.g),
                    blendOverlay(base.b, blend.b) );
}

float3 blendOverlay(in float3 base, in float3 blend, in float opacity) {
    return (blendOverlay(base, blend) * opacity + base * (1. - opacity));
}
#endif
