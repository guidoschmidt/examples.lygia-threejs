/*
original_author: Patricio Gonzalez Vivo
description: Converts a XYZ color to Lab color space.
use: xyz2rgb(<vec3|vec4> color)
*/

#ifndef FNC_XYZ2LAB
#define FNC_XYZ2LAB
vec3 xyz2lab(in vec3 c) {
    vec3 n = c / vec3(95.047, 100.0, 108.883);
    vec3 c0 = pow(n, vec3(1.0 / 3.0));
    vec3 c1 = (7.787 * n) + (16.0 / 116.0);
    vec3 v = mix(c0, c1, step(n, vec3(0.008856)));
    return vec3((116.0 * v.y) - 16.0,
                500.0 * (v.x - v.y),
                200.0 * (v.y - v.z));
}

vec4 xyz2lab(in vec4 c) { return vec4(xyz2lab(c.xyz), c.w); }
#endif