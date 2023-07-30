/*
original_author: [Ivan Dianov, Kathy McGuiness]
description: cartesian to polar transformation.
use: <float2|float3> cart2polar(<float2|float3> st)
*/

#ifndef FNC_CART2POLAR
#define FNC_CART2POLAR

float2 cart2polar(in float2 st) {
    return float2(atan2(st.y, st.x), length(st));
}

float3 cart2polar( in float3 st) {
   float r = length(st);
   float theta = atan( length(st.xy), st.z);
   float phi = atan(st.y, st.x);
   return float3(r, theta, phi);
}
#endif