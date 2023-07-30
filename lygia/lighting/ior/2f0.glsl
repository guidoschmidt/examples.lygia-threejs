#include "../../math/pow2.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: index of refraction to reflectance at 0 degree https://handlespixels.wordpress.com/tag/f0-reflectance/
use: <float|vec3|vec4> ior2f0(<float|vec3|vec4> ior)
*/

#ifndef FNC_IOR2F0
#define FNC_IOR2F0
float ior2f0(const in float ior) { return pow2(ior - 1.0) / pow2(ior + 1.0); }
vec3 ior2f0(const in vec3 ior) { return pow2(ior - 1.0) / pow2(ior + 1.0); }
vec4 ior2f0(const in vec4 ior) { return vec4(pow2(ior.rgb - 1.0) / pow2(ior.rgb + 1.0), ior.a); }
#endif