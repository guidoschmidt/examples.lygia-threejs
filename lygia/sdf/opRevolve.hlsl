/*
original_author:  Inigo Quiles
description: revolve operation of a 2D SDFs into a 3D one
use: <float2> opRevolve( in <float3> p, <float> w ) 
*/

#ifndef FNC_OPREVOLVE
#define FNC_OPREVOLVE

float2 opRevolve( in float3 p, float w ) {
    return float2( length(p.xz) - w, p.y );
}

#endif

