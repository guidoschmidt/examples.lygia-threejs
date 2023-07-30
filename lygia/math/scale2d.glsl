/*
original_author: Patricio Gonzalez Vivo
description: returns a 2x2 scale matrix
use: 
    - scale2d(<float|vec2> radians)
    - scale2d(<float> x, <float> y)
*/

#ifndef FNC_SCALE4D
mat2 scale2d(float _scale) {
    return mat2(
        _scale, 0.0,
        0.0, _scale
    );
}

mat2 scale2d(vec2 s) {
    return mat2(
        s.x, 0.0,
        0.0, s.y
    );
}

mat2 scale2d(float x, float y) {
    return mat2(
         x, 0.0,
        0.0,  y
    );
}
#endif