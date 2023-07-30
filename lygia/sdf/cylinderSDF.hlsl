/*
original_author:  Inigo Quiles
description: generate the SDF of a cylinder
use: 
    - <float> cylinderSDF( in <float3> pos, in <float2|float> h [, <float> r] ) 
    - <float> cylinderSDF( <float3> p, <float3> a, <float3> b, <float> r) 
*/

#ifndef FNC_CYLINDERSDF
#define FNC_CYLINDERSDF

// vertical
float cylinderSDF( float3 p, float2 h ) {
    float2 d = abs(float2(length(p.xz),p.y)) - h;
    return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

float cylinderSDF( float3 p, float h ) {
    return cylinderSDF( p, float2(h, h) );
}

float cylinderSDF( float3 p, float h, float r ) {
    float2 d = abs(float2(length(p.xz),p.y)) - float2(h,r);
    return min(max(d.x,d.y),0.0) + length(max(d,0.0));
}

// arbitrary orientation
float cylinderSDF(float3 p, float3 a, float3 b, float r) {
    float3 pa = p - a;
    float3 ba = b - a;
    float baba = dot(ba,ba);
    float paba = dot(pa,ba);

    float x = length(pa*baba-ba*paba) - r*baba;
    float y = abs(paba-baba*0.5)-baba*0.5;
    float x2 = x*x;
    float y2 = y*y*baba;
    float d = (max(x,y)<0.0)?-min(x2,y2):(((x>0.0)?x2:0.0)+((y>0.0)?y2:0.0));
    return sign(d)*sqrt(abs(d))/baba;
}

#endif