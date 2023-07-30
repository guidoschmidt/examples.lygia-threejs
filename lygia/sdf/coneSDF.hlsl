/*
original_author:  Inigo Quiles
description: generate the SDF of a cone
use: <float> coneSDF( in <float3> pos, in <float3> c ) 
*/

#ifndef FNC_CONESDF
#define FNC_CONESDF

float coneSDF( in float3 p, in float3 c ) {
    float2 q = float2( length(p.xz), p.y );
    float d1 = -q.y-c.z;
    float d2 = max( dot(q,c.xy), q.y);
    return length(max(float2(d1,d2),0.0)) + min(max(d1,d2), 0.);
}

// vertical
float coneSDF( in float3 p, in float2 c, float h ) {
    float2 q = h*float2(c.x,-c.y)/c.y;
    float2 w = float2( length(p.xz), p.y );
    
	float2 a = w - q*clamp( dot(w,q)/dot(q,q), 0.0, 1.0 );
    float2 b = w - q*float2( clamp( w.x/q.x, 0.0, 1.0 ), 1.0 );
    float k = sign( q.y );
    float d = min(dot( a, a ),dot(b, b));
    float s = max( k*(w.x*q.y-w.y*q.x),k*(w.y-q.y)  );
	return sqrt(d)*sign(s);
}

// Round
float coneSDF( in float3 p, in float r1, float r2, float h ) {
    float2 q = float2( length(p.xz), p.y );
    
    float b = (r1-r2)/h;
    float a = sqrt(1.0-b*b);
    float k = dot(q,float2(-b,a));
    
    if( k < 0.0 ) return length(q) - r1;
    if( k > a*h ) return length(q-float2(0.0,h)) - r2;
        
    return dot(q, float2(a,b) ) - r1;
}

#endif