#include "../math/const.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: equirect 2D projection to 3D vector 
use: <float3> equirect2xyz(<float2> uv)
*/

#ifndef FNC_EQUIRECT2XYZ
#define FNC_EQUIRECT2XYZ
float3 equirect2xyz(float2 uv) {
    float Phi = PI - uv.y * PI;
    float Theta = uv.x * TWO_PI;
    float3 dir = float3(cos(Theta), 0.0, sin(Theta));
    dir.y   = cos(Phi);//clamp(cos(Phi), MinCos, 1.0);
    dir.xz *= sqrt(1.0 - dir.y * dir.y);
    return dir;
}
#endif