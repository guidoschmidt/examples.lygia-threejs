#include "../math/make.cuh"
#include "../math/lerp.cuh"
#include "../math/step.cuh"

/*
original_author: Patricio Gonzalez Vivo
description: Fix the aspect ratio of a space keeping things squared for you.
use: ratio(float2 st, float2 st_size)
*/

#ifndef FNC_RATIO
#define FNC_RATIO
inline __host__ __device__ float2 ratio(float2 st, float2 s) {
    return lerp(    make_float2((st.x*s.x/s.y)-(s.x*.5-s.y*.5)/s.y, st.y),
                    make_float2( st.x,st.y*(s.y/s.x)-(s.y*.5-s.x*.5)/s.x),
                    step(s.x, s.y) );
}
#endif
