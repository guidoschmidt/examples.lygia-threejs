/*
original_author:  Inigo Quiles
description: generate the SDF of an approximated ellipsoid
use: <float> ellipsoidSDF( in <float3> p, in <float3> r )
*/

#ifndef FNC_ELLIPSOIDSDF
#define FNC_ELLIPSOIDSDF

float ellipsoidSDF( in float3 p, in float3 r ) {
    float k0 = length(p/r);
    float k1 = length(p/(r*r));
    return k0*(k0-1.0)/k1;
}

#endif