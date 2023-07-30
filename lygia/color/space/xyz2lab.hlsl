/*
original_author: Patricio Gonzalez Vivo
description: Converts a XYZ color to Lab color space.
use: xyz2rgb(<float3|float4> color)
*/

#ifndef FNC_XYZ2LAB
#define FNC_XYZ2LAB
float3 xyz2lab(in float3 c) {
    float3 n = c / float3(95.047, 100.0, 108.883);
    float3 c0 = pow(n, float3(1.0 / 3.0));
    float3 c1 = (7.787 * n) + (16.0 / 116.0);
    float3 v = lerp(c0, c1, step(n, float3(0.008856)));
    return float3((116.0 * v.y) - 16.0,
                500.0 * (v.x - v.y),
                200.0 * (v.y - v.z));
}

float4 xyz2lab(in float4 c) { return float4(xyz2lab(c.xyz), c.w); }
#endif