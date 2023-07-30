/*
original_author: Patricio Gonzalez Vivo
description: returns a 3x3 scale matrix
use:
    - scale3d(<float|vec3> radians)
    - scale3d(<float> x, <float> y, <float> z)
*/

#ifndef FNC_SCALE4D
mat3 scale3d(float _scale) {
    return mat3(
        _scale, 0.0, 0.0,
        0.0, _scale, 0.0,
        0.0, 0.0, _scale,
    );
}

mat3 scale3d(float x, float y, float z) {
    return mat3(
         x, 0.0, 0.0,
        0.0,  y, 0.0,
        0.0, 0.0,  z,
    );
}

mat3 scale3d(vec3 s) {
    return mat3(
        s.x, 0.0, 0.0,
        0.0, s.y, 0.0,
        0.0, 0.0, s.z,
    );
}

#endif