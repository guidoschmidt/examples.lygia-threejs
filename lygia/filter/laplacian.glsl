#include "../sample.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: laplacian filter
use: laplacian(<SAMPLER_TYPE> texture, <vec2> st, <vec2> pixels_scale [, <float> pixel_padding])
options:
    - LAPLACIAN_TYPE: Return type, defaults to float
    - LAPLACIAN_SAMPLER_FNC: Function used to sample the input texture, defaults to texture2D(tex,TEX, UV).r
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
examples:
    - /shaders/filter_laplacian2D.frag
*/

#ifndef LAPLACIAN_TYPE
#define LAPLACIAN_TYPE vec4
#endif

#ifndef LAPLACIAN_SAMPLER_FNC
#define LAPLACIAN_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif

#ifndef LAPLACIAN_FNC
#define LAPLACIAN_FNC laplacian_w4
#endif

// #define LAPLACE_W4 0
// #define LAPLACE_W8 0
// #define LAPLACE_W12 0

// LAPLACE FILTER (highpass)
//                                  
//   0  1  0    1  1  1    1   2   1
//   1 -4  1    1 -8  1    2 -12   2
//   0  1  0    1  1  1    1   2   1
//    

#ifndef FNC_LAPLACIAN
#define FNC_LAPLACIAN

LAPLACIAN_TYPE laplacian_w4(SAMPLER_TYPE tex, vec2 st, vec2 pixel) {
    LAPLACIAN_TYPE acc = LAPLACIAN_TYPE(0.0);
    acc += LAPLACIAN_SAMPLER_FNC(tex, st) * 4.0;
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2(-1.0,  0.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 0.0, -1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 0.0,  1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  0.0) * pixel);
    return acc;
}

LAPLACIAN_TYPE laplacian_w8(SAMPLER_TYPE tex, vec2 st, vec2 pixel) {
    LAPLACIAN_TYPE acc = LAPLACIAN_TYPE(0.0);
    acc += LAPLACIAN_SAMPLER_FNC(tex, st) * 8.0;
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2(-1.0,  0.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 0.0, -1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 0.0,  1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  0.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2(-1.0,  1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0, -1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  1.0) * pixel);
    return acc;
}

LAPLACIAN_TYPE laplacian_w12(SAMPLER_TYPE tex, vec2 st, vec2 pixel) {
    LAPLACIAN_TYPE acc = LAPLACIAN_TYPE(0.0);
    acc += LAPLACIAN_SAMPLER_FNC(tex, st) * 12.0;
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2(-1.0,  0.0) * pixel) * 2.0;
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 0.0, -1.0) * pixel) * 2.0;
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 0.0,  1.0) * pixel) * 2.0;
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  0.0) * pixel) * 2.0;

    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2(-1.0,  1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0, -1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  1.0) * pixel);
    acc -= LAPLACIAN_SAMPLER_FNC(tex, st + vec2( 1.0,  1.0) * pixel);
    return acc;
}

LAPLACIAN_TYPE laplacian(SAMPLER_TYPE tex, vec2 st, vec2 pixel) {
    return LAPLACIAN_FNC(tex, st, pixel);
}

bool laplacian_isOutside(vec2 pos) {
    return (pos.x < 0.0 || pos.y < 0.0 || pos.x > 1.0 || pos.y > 1.0);
}

LAPLACIAN_TYPE laplacian_w4(SAMPLER_TYPE tex, vec2 st, vec2 pixel, float pixel_pad) {
    LAPLACIAN_TYPE acc = LAPLACIAN_TYPE(0.0);
    vec2 uv = st * vec2(1.0 + pixel_pad * 2.0 * pixel) - pixel_pad * pixel;
    vec3 pixelShift = vec3(pixel, 0.0);

    if (!laplacian_isOutside(uv)) acc = 4.0 * LAPLACIAN_SAMPLER_FNC(tex, uv);
    vec2 e = uv + pixelShift.xz;
    if (!laplacian_isOutside(e)) acc -= LAPLACIAN_SAMPLER_FNC(tex, e);
    vec2 n = uv + pixelShift.zy;
    if (!laplacian_isOutside(n)) acc -= LAPLACIAN_SAMPLER_FNC(tex, n);
    vec2 w = uv - pixelShift.xz;
    if (!laplacian_isOutside(w)) acc -= LAPLACIAN_SAMPLER_FNC(tex, w);
    vec2 s = uv - pixelShift.zy;
    if (!laplacian_isOutside(s)) acc -= LAPLACIAN_SAMPLER_FNC(tex, s);
    return acc;
}

LAPLACIAN_TYPE laplacian_w8(SAMPLER_TYPE tex, vec2 st, vec2 pixel, float pixel_pad) {
    LAPLACIAN_TYPE acc = LAPLACIAN_TYPE(0.0);
    vec2 uv = st * vec2(1.0 + pixel_pad * 2.0 * pixel) - pixel_pad * pixel;
    vec3 pixelShift = vec3(pixel, 0.0);

    if (!laplacian_isOutside(uv)) acc = 8.0 * LAPLACIAN_SAMPLER_FNC(tex, uv);
    vec2 e = uv + pixelShift.xz;
    if (!laplacian_isOutside(e)) acc -= LAPLACIAN_SAMPLER_FNC(tex, e);
    vec2 n = uv + pixelShift.zy;
    if (!laplacian_isOutside(n)) acc -= LAPLACIAN_SAMPLER_FNC(tex, n);
    vec2 w = uv - pixelShift.xz;
    if (!laplacian_isOutside(w)) acc -= LAPLACIAN_SAMPLER_FNC(tex, w);
    vec2 s = uv - pixelShift.zy;
    if (!laplacian_isOutside(s)) acc -= LAPLACIAN_SAMPLER_FNC(tex, s);

    vec2 ne = n + e;
    if (!laplacian_isOutside(e)) acc -= LAPLACIAN_SAMPLER_FNC(tex, e);
    vec2 nw = n + w;
    if (!laplacian_isOutside(n)) acc -= LAPLACIAN_SAMPLER_FNC(tex, n);
    vec2 se = s + e;
    if (!laplacian_isOutside(w)) acc -= LAPLACIAN_SAMPLER_FNC(tex, w);
    vec2 sw = s + w;
    if (!laplacian_isOutside(s)) acc -= LAPLACIAN_SAMPLER_FNC(tex, s);

    return acc;
}

LAPLACIAN_TYPE laplacian_w12(SAMPLER_TYPE tex, vec2 st, vec2 pixel, float pixel_pad) {
    LAPLACIAN_TYPE acc = LAPLACIAN_TYPE(0.0);
    vec2 uv = st * vec2(1.0 + pixel_pad * 2.0 * pixel) - pixel_pad * pixel;
    vec3 pixelShift = vec3(pixel, 0.0);

    if (!laplacian_isOutside(uv)) acc = 12.0 * LAPLACIAN_SAMPLER_FNC(tex, uv);

    vec2 e = uv + pixelShift.xz;
    if (!laplacian_isOutside(e)) acc -= LAPLACIAN_SAMPLER_FNC(tex, e) * 2.0;
    vec2 n = uv + pixelShift.zy;
    if (!laplacian_isOutside(n)) acc -= LAPLACIAN_SAMPLER_FNC(tex, n) * 2.0;
    vec2 w = uv - pixelShift.xz;
    if (!laplacian_isOutside(w)) acc -= LAPLACIAN_SAMPLER_FNC(tex, w) * 2.0;
    vec2 s = uv - pixelShift.zy;
    if (!laplacian_isOutside(s)) acc -= LAPLACIAN_SAMPLER_FNC(tex, s) * 2.0;

    vec2 ne = n + e;
    if (!laplacian_isOutside(e)) acc -= LAPLACIAN_SAMPLER_FNC(tex, e);
    vec2 nw = n + w;
    if (!laplacian_isOutside(n)) acc -= LAPLACIAN_SAMPLER_FNC(tex, n);
    vec2 se = s + e;
    if (!laplacian_isOutside(w)) acc -= LAPLACIAN_SAMPLER_FNC(tex, w);
    vec2 sw = s + w;
    if (!laplacian_isOutside(s)) acc -= LAPLACIAN_SAMPLER_FNC(tex, s);

    return acc;
}

LAPLACIAN_TYPE laplacian(SAMPLER_TYPE tex, vec2 st, vec2 pixel, float pixel_pad) {
    return LAPLACIAN_FNC(tex, st, pixel, pixel_pad);
}

#endif