/*
original_author: Patricio Gonzalez Vivo
description: Fix the aspect ratio of a space keeping things squared for you.
use: ratio(vec2 st, vec2 st_size)
*/

#ifndef FNC_RATIO
#define FNC_RATIO
vec2 ratio(in vec2 st, in vec2 s) {
    return mix( vec2((st.x*s.x/s.y)-(s.x*.5-s.y*.5)/s.y,st.y),
                vec2(st.x,st.y*(s.y/s.x)-(s.y*.5-s.x*.5)/s.x),
                step(s.x,s.y));
}
#endif
