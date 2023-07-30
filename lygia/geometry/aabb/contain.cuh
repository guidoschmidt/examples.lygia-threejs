
#include "aabb.cuh"

/*
original_author: Patricio Gonzalez Vivo
description: Compute if point is inside AABB
use: <bool> contain(<AABB> box, <vec3> point ) 
*/

#ifndef FNC_AABB_CONTAIN
#define FNC_AABB_CONTAIN

inline __host__ __device__ bool contain(const AABB& _box, const float3& _point ) {
    return  (_point.x >= _box.min.x && _point.x <= _box.max.x) &&
            (_point.y >= _box.min.y && _point.y <= _box.max.y) &&
            (_point.z >= _box.min.z && _point.z <= _box.max.z);
}

#endif