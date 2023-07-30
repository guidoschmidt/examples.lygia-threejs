/*
original_author: Patricio Gonzalez Vivo
description: convert YCbCr to RGB according to https://en.wikipedia.org/wiki/YCbCr
use: YCbCr2rgb(<float3|float4> color)
*/

#ifndef FNC_YCBCR2RGB
#define FNC_YCBCR2RGB
float3 YCbCr2rgb(in float3 ycbcr) {
    float cb = ycbcr.y - .5;
    float cr = ycbcr.z - .5;
    float y = ycbcr.x;
    float r = 1.402 * cr;
    float g = -.344 * cb - .714 * cr;
    float b = 1.772 * cb;
    return float3(r, g, b) + y;
}

float4 YCbCr2rgb(in float4 ycbcr) {
    return float4(YCbCr2rgb(ycbcr.rgb),ycbcr.a);
}
#endif
