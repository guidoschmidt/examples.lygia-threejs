#include "../sample.glsl"
#include "../math/saturate.glsl"

/*
Author: Patricio Gonzalez Vivo
description: Use a 2D texture as a 3D one
use: <vec4> sample2DCube(in <SAMPLER_TYPE> lut, in <vec3> xyz) 
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - SAMPLE_2DCUBE_CELL_SIZE
    - SAMPLE_2DCUBE_CELLS_PER_SIDE: defaults to 8
    - SAMPLE_2DCUBE_FNC
*/

#ifndef SAMPLE_2DCUBE_CELLS_PER_SIDE
#define SAMPLE_2DCUBE_CELLS_PER_SIDE 8.0
#endif

#ifndef SAMPLE_2DCUBE_FNC
#define SAMPLE_2DCUBE_FNC(TEX, UV) SAMPLER_FNC(TEX, saturate(UV))
#endif

#ifndef FNC_SAMPLE_2DCUBE
#define FNC_SAMPLE_2DCUBE
vec4 sample2DCube(in SAMPLER_TYPE lut, in vec3 xyz) {

#if defined(SAMPLE_2DCUBE_CELL_SIZE)
    const float cellsSize = SAMPLE_2DCUBE_CELL_SIZE;
    float cellsPerSide = sqrt(cellsSize);
    float cellsFactor = 1.0/cellsPerSide;
    float lutSize = cellsPerSide * cellsSize;
    float lutSizeFactor = 1.0/lutSize;

#elif defined(SAMPLE_2DCUBE_CELLS_PER_SIDE)
    const float cellsPerSide = SAMPLE_2DCUBE_CELLS_PER_SIDE;
    const float cellsSize = cellsPerSide * cellsPerSide;
    const float cellsFactor = 1.0/cellsPerSide;
    const float lutSize = cellsPerSide * cellsSize;
    const float lutSizeFactor = 1.0/lutSize;
#endif

    #ifndef SAMPLE_2DCUBE_FLIP_Z
    xyz.z = 1.0 - xyz.z;
    #endif

    xyz *= (cellsSize-1.0);
    float iz = floor(xyz.z);

    float x0 = mod(iz, cellsPerSide) * cellsSize;
    float y0 = floor(iz * cellsFactor) * cellsSize;

    float x1 = mod(iz + 1.0, cellsPerSide) * cellsSize;
    float y1 = floor((iz + 1.0) * cellsFactor) * cellsSize;

    vec2 uv0 = vec2(x0 + xyz.x + 0.5, y0 + xyz.y + 0.5) * lutSizeFactor;
    vec2 uv1 = vec2(x1 + xyz.x + 0.5, y1 + xyz.y + 0.5) * lutSizeFactor;

    #ifndef SAMPLE_2DCUBE_FLIP_Y
    uv0.y = 1.0 - uv0.y;
    uv1.y = 1.0 - uv1.y;
    #endif

    return mix( SAMPLE_2DCUBE_FNC(lut, uv0), 
                SAMPLE_2DCUBE_FNC(lut, uv1), 
                xyz.z - iz);
}
#endif 