/*
original_author:  Inigo Quiles
description: generate the SDF of a hexagonal prism
use: <float> hexPrismSDF( in <float3> pos, in <float2> h ) 
*/

#ifndef FNC_HEXPRISMSDF
#define FNC_HEXPRISMSDF

float hexPrismSDF( float3 p, float2 h ) {
    float3 q = abs(p);
    float d1 = q.z-h.y;
    float d2 = max((q.x*0.866025+q.y*0.5),q.y)-h.x;
    return length(max(float2(d1,d2),0.0)) + min(max(d1,d2), 0.);
}

#endif