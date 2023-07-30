#include "random.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: Worley noise
use: <float2> worley(<float2|float3> pos)
*/

#ifndef FNC_WORLEY
#define FNC_WORLEY

float worley(float2 p){
    float2 n = floor( p );
    float2 f = frac( p );

    float dis = 1.0;
    for( int j= -1; j <= 1; j++ )
        for( int i=-1; i <= 1; i++ ) {	
                float2  g = float2(i,j);
                float2  o = random2( n + g );
                float2  delta = g + o - f;
                float d = length(delta);
                dis = min(dis,d);
    }

    return 1.0-dis;
}

float worley(float3 p){
    float3 n = floor( p );
    float3 f = frac( p );

    float dis = 1.0;
    for( int k = -1; k <= 1; k++ )
        for( int j= -1; j <= 1; j++ )
            for( int i=-1; i <= 1; i++ ) {	
                float3  g = float3(i,j,k);
                float3  o = random3( n + g );
                float3  delta = g+o-f;
                float d = length(delta);
                dis = min(dis,d);
    }

    return 1.0-dis;
}

#endif