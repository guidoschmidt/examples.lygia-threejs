#include "../../sample.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: simple two dimentional box blur, so can be apply in a single pass
use: boxBlur2D(<SAMPLER_TYPE> texture, <vec2> st, <vec2> pixel_offset, <int> kernelSize)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - BOXBLUR2D_TYPE: Default `vec4`
    - BOXBLUR2D_SAMPLER_FNC(TEX, UV): default is `texture2D(tex, TEX, UV)`
    - BOXBLUR2D_KERNELSIZE: Use only for WebGL 1.0 and OpenGL ES 2.0 . For example RaspberryPis is not happy with dynamic loops. Default is 'kernelSize'
examples:
    - /shaders/filter_boxBlur2D.frag
*/

#ifndef BOXBLUR2D_TYPE
#ifdef BOXBLUR_TYPE
#define BOXBLUR2D_TYPE BOXBLUR_TYPE
#else
#define BOXBLUR2D_TYPE vec4
#endif
#endif

#ifndef BOXBLUR2D_SAMPLER_FNC
#ifdef BOXBLUR_SAMPLER_FNC
#define BOXBLUR2D_SAMPLER_FNC(TEX, UV) BOXBLUR_SAMPLER_FNC(TEX, UV)
#else
#define BOXBLUR2D_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV)
#endif
#endif

#ifndef FNC_BOXBLUR2D
#define FNC_BOXBLUR2D
BOXBLUR2D_TYPE boxBlur2D(in SAMPLER_TYPE tex, in vec2 st, in vec2 pixel, const int kernelSize) {
    BOXBLUR2D_TYPE color = BOXBLUR2D_TYPE(0.);

    #ifndef BOXBLUR2D_KERNELSIZE

    #if defined(PLATFORM_WEBGL)
    #define BOXBLUR2D_KERNELSIZE 20
    float kernelSizef = float(kernelSize);
    #else
    #define BOXBLUR2D_KERNELSIZE kernelSize
    float kernelSizef = float(BOXBLUR2D_KERNELSIZE);
    #endif

    #else
    float kernelSizef = float(BOXBLUR2D_KERNELSIZE);
    #endif

    float accumWeight = 0.;
    float kernelSize2 = kernelSizef * kernelSizef;
    float weight = 1. / kernelSize2;

    for (int j = 0; j < BOXBLUR2D_KERNELSIZE; j++) {
        #if defined(PLATFORM_WEBGL)
        if (j >= kernelSize)
            break;
        #endif
        float y = -.5 * (kernelSizef - 1.) + float(j);
        for (int i = 0; i < BOXBLUR2D_KERNELSIZE; i++) {
            #if defined(PLATFORM_WEBGL)
            if (i >= kernelSize)
                break;
            #endif
            float x = -.5 * (kernelSizef - 1.) + float(i);
            color += BOXBLUR2D_SAMPLER_FNC(tex, st + vec2(x, y) * pixel) * weight;
        }
    }
    return color;
}
#endif
