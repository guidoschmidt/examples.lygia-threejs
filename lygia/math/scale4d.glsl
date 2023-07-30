/*
original_author: Patricio Gonzalez Vivo
description: returns a 4x4 scale matrix
use: 
    - scale4d(<float|vec3|vec4> radians)
    - scale4d(<float> x, <float> y, <float> z [, <float> w])
*/

#ifndef FNC_SCALE4D
mat4 scale4d(float _scale) {
    return mat4(
        _scale, 0.0, 0.0, 0.0,
        0.0, _scale, 0.0, 0.0,
        0.0, 0.0, _scale, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}

mat4 scale4d(float x, float y, float z) {
    return mat4(
         x, 0.0, 0.0, 0.0,
        0.0,  y, 0.0, 0.0,
        0.0, 0.0,  z, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}

mat4 scale4d(float x, float y, float z, float w) {
    return mat4(
         x, 0.0, 0.0, 0.0,
        0.0,  y, 0.0, 0.0,
        0.0, 0.0,  z, 0.0,
        0.0, 0.0, 0.0,  w
    );
}

mat4 scale4d(vec3 s) {
    return mat4(
        s.x, 0.0, 0.0, 0.0,
        0.0, s.y, 0.0, 0.0,
        0.0, 0.0, s.z, 0.0,
        0.0, 0.0, 0.0, 1.0
    );
}

mat4 scale4d(vec4 s) {
    return mat4(
        s.x, 0.0, 0.0, 0.0,
        0.0, s.y, 0.0, 0.0,
        0.0, 0.0, s.z, 0.0,
        0.0, 0.0, 0.0, s.w
    );
}
#endif
