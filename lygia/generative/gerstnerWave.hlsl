#include "../math/const.hlsl"

/*
original_author: Patricio Gonzalez Vivo
description: Gerstner Wave generator based on this tutorial https://catlikecoding.com/unity/tutorials/flow/waves/
use: 
    - <float3> gerstnerWave (<float2> uv, <float2> dir, <float> steepness, <float> wavelength, <float> _time [, inout <float3> _tangent, inout <float3> _binormal] )
    - <float3> gerstnerWave (<float2> uv, <float2> dir, <float> steepness, <float> wavelength, <float> _time [, inout <float3> _normal] )
*/

#ifndef FNC_GERSTNERWAVE
#define FNC_GERSTNERWAVE

float3 gerstnerWave (in float2 _uv, in float2 _dir, in float _steepness, in float _wavelength, in float _time, inout float3 _tangent, inout float3 _binormal) {
    float k = 2.0 * PI / _wavelength;
    float c = sqrt(9.8 / k);
    float2 d = normalize(_dir);
    float f = k * (dot(d, _uv) - c * _time);
    float a = _steepness / k;

    _tangent += float3(
        -d.x * d.x * (_steepness * sin(f)),
        d.x * (_steepness * cos(f)),
        -d.x * d.y * (_steepness * sin(f))
    );
    _binormal += float3(
        -d.x * d.y * (_steepness * sin(f)),
        d.y * (_steepness * cos(f)),
        -d.y * d.y * (_steepness * sin(f))
    );
    return float3(
        d.x * (a * cos(f)),
        a * sin(f),
        d.y * (a * cos(f))
    );
}

float3 gerstnerWave (in float2 _uv, in float2 _dir, in float _steepness, in float _wavelength, in float _time, inout float3 _normal) {
    float3 _tangent = float3(0.0, 0.0, 0.0);
    float3 _binormal = float3(0.0, 0.0, 0.0);
    float3 pos = gerstnerWave (_uv, _dir, _steepness, _wavelength, _time, _tangent, _binormal);
    _normal = normalize(cross(_binormal, _tangent));
    return pos;
}

float3 gerstnerWave (in float2 _uv, in float2 _dir, in float _steepness, in float _wavelength, in float _time) {
    float3 _tangent = float3(0.0, 0.0, 0.0);
    float3 _binormal = float3(0.0, 0.0, 0.0);
    return gerstnerWave (_uv, _dir, _steepness, _wavelength, _time, _tangent, _binormal);
}

#endif