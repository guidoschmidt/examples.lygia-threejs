/*
original_author: Patricio Gonzalez Vivo
description: brick a pattern
use: 
    - <float2> brick(<float2> st [, <float> scale])
    - <float4> brick(<float4> tiles)
*/

#ifndef FNC_BRICK
#define FNC_BRICK
float2 brick(float2 st) {
    st.x += step(1., mod(st.y, 2.0)) * 0.5;
    return frac(st);
}

float2 brick(float2 st, float scale) {
    return brick(st * scale);
}

float4 brick(float4 tile) {
    tile.x += mod(tile.w,2.)*.5;
    tile.z = floor(tile.z+tile.x);
    tile.x = frac(tile.x);
    return tile;
}
#endif