/*
original_author: Patricio Gonzalez Vivo
description: Fix the aspect ratio of a space keeping things squared for you.
use: ratio(float2 st, float2 st_size)
*/

#ifndef FNC_RATIO
#define FNC_RATIO
float2 ratio(in float2 st, in float2 s) {
    return lerp(    float2((st.x*s.x/s.y)-(s.x*.5-s.y*.5)/s.y,st.y),
                    float2(st.x,st.y*(s.y/s.x)-(s.y*.5-s.x*.5)/s.x),
                    step(s.x, s.y));
}
#endif
