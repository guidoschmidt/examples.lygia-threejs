#include "../math/const.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: fisheye 2D projection to 3D vector 
use: <float3> fisheye2xyz(<float2> uv)
*/

#ifndef FNC_FISHEYE2XYZ
#define FNC_FISHEYE2XYZ
float3 fisheye2xyz(float2 uv) {
    float2 ndc = uv * 2.0 - 1.0;
    float R = sqrt(ndc.x * ndc.x + ndc.y * ndc.y);
    float3 dir = float3(ndc.x / R, 0.0, ndc.y / R);
    float Phi = (R) * PI * 0.52;
    dir.y   = cos(Phi);//clamp(, MinCos, 1.0);
    dir.xz *= sqrt(1.0 - dir.y * dir.y);
    return dir;
}
#endif