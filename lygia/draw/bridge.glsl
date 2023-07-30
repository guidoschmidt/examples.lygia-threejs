#include "stroke.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: create a bridge on a given in_value and draw a stroke inside that gap
use: bridge(<float|vec2|vec3|vec4> in_value, <float> sdf, <float> size, <float> width)
*/

#ifndef FNC_BRIDGE
#define FNC_BRIDGE
float bridge(float c, float d, float s, float w) {
    c *= 1.0 - stroke(d, s , w * 2.0);
    return c + stroke(d, s, w);
}

vec2 bridge(vec2 c, float d, float s, float w) {
    c *= 1.0 - stroke(d, s , w * 2.0);
    return c + stroke(d, s, w);
}

vec3 bridge(vec3 c, float d, float s, float w) {
    c *= 1.0 - stroke(d, s , w * 2.0);
    return c + stroke(d, s, w);
}

vec4 bridge(vec4 c, float d, float s, float w) {
    c *= 1.0 - stroke(d, s , w * 2.0);
    return c + stroke(d, s, w);
}

#endif