
#include "aabb.cuh"
#include "../triangle/triangle.cuh"
#include "../../math/operations.cuh"

/*
original_author: Patricio Gonzalez Vivo
description: Expand AABB
use: <bool> expand(<AABB> box, <AABB|float3|float> point ) 
*/

#ifndef FNC_AABB_EXPAND
#define FNC_AABB_EXPAND

inline __host__ __device__ void expand(AABB& _box, float _value ) {
    _box.min -= _value;
    _box.max += _value;
}

inline __host__ __device__ void expand(AABB& _box, const float3& _point ) {
    _box.min = min(_box.min, _point);
    _box.max = max(_box.max, _point);
}

inline __host__ __device__ void expand(AABB& _box, const Triangle& _tri ) {
    expand(_box, _tri.a); expand(_box, _tri.b); expand(_box, _tri.c);
}

inline __host__ __device__ void expand(AABB& _box, const AABB& _other ) {
    expand(_box, _other.min); 
    expand(_box, _other.max);
}

#endif