#include "../math/saturate.glsl"

/*
original_author:  Inigo Quiles
description: intersection operation of two SDFs 
use: <float> opIntersection( in <float> d1, in <float> d2 [, <float> smooth_factor] ) 
*/

#ifndef FNC_OPINTERSECTION
#define FNC_OPINTERSECTION

float opIntersection( float d1, float d2 ) { return max(d1,d2); }

float opIntersection( float d1, float d2, float k ) {
    float h = saturate( 0.5 - 0.5*(d2-d1)/k );
    return mix( d2, d1, h ) + k*h*(1.0-h); 
}

#endif