/*
original_author: Patricio Gonzalez Vivo  
description: |
    Convert rgb to LMS. LMS (long, medium, short), is a color space which represents the response of the three types of cones of the human eye, named for their responsivity (sensitivity) peaks at long, medium, and short wavelengths. 
    Refs https://en.wikipedia.org/wiki/LMS_color_space https://arxiv.org/pdf/1711.10662
use: <vec3|vec4> rgb2lms(<vec3|vec4> rgb)
*/

#ifndef FNC_RGB2LMS
#define FNC_RGB2LMS
vec3 rgb2lms(vec3 rgb) {
    // mat3 rgb2lms_mat = mat3(
    //     3.90405e-1, 5.49941e-1, 8.92632e-3,
    //     7.08416e-2, 9.63172e-1, 1.35775e-3,
    //     2.31082e-2, 1.28021e-1, 9.36245e-1
    // );

    mat3 rgb2lms_mat = mat3(
        17.8824,  3.45565,  0.0299566,
        43.5161, 27.1554,   0.184309,
        4.11935,  0.184309, 1.46709
    );

    return rgb2lms_mat * rgb;
}
vec4 rgb2lms(vec4 rgb) { return vec4(rgb.rgb, rgb.a); }
#endif