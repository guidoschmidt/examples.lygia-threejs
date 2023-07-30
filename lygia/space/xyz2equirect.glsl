#include "../math/const.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: 3D vector to equirect 2D projection 
use: <vec2> xyz2equirect(<vec2> d)
*/

#ifndef FNC_XYZ2EQUIRECT
#define FNC_XYZ2EQUIRECT
vec2 xyz2equirect(vec3 d) {
    return vec2(atan(d.z, d.x) + PI, acos(-d.y)) / vec2(2.0 * PI, PI);
}
#endif