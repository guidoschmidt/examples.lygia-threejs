#include "../../math/operations.cuh"

/*
original_author: Patricio Gonzalez Vivo
description: Simpler fire color ramp 
use: <float3> fire(<float> value)
*/

#ifndef FNC_FIRE
#define FNC_FIRE

inline __host__ __device__  float3 fire(float x) { return make_float3(1.0f, 0.25f, 0.0625f) * exp(4.0 * x - 1.0); }

#endif