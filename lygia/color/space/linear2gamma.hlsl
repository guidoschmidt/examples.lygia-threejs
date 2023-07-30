/*
original_author: Patricio Gonzalez Vivo
description: convert from linear to gamma color space.
use: linear2gamma(<float|float3|float4> color)
*/

#if  !defined(GAMMA) && !defined(TARGET_MOBILE) && !defined(PLATFORM_RPI) && !defined(PLATFORM_WEBGL)
#define GAMMA 2.2
#endif

#ifndef FNC_LINEAR2GAMMA
#define FNC_LINEAR2GAMMA
float3 linear2gamma(in float3 v) {
#ifdef GAMMA
    float f = 1. / GAMMA;
    return pow(v, float3(f,f,f));
#else
    // assume gamma 2.0
    return sqrt(v);
#endif
}

float4 linear2gamma(in float4 v) {
    return float4(linear2gamma(v.rgb), v.a);
}

float linear2gamma(in float v) {
#ifdef GAMMA
    return pow(v, 1. / GAMMA);
#else
    // assume gamma 2.0
    return sqrt(v);
#endif
}
#endif
