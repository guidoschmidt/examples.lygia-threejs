/*
original_author:  Inigo Quiles
description: extrude operation of a 2D SDFs into a 3D one
use: <float> opExtrude( in <float3> p, in <float> sdf, in <float> h )
*/

#ifndef FNC_OPEXTRUDE
#define FNC_OPEXTRUDE

float opExtrude( in float3 p, in float sdf, in float h ) {
    float2 w = float2( sdf, abs(p.z) - h );
  	return min(max(w.x,w.y),0.0) + length(max(w,0.0));
}

#endif

