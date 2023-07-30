#include "../../color/space/gamma2linear.glsl"
#include "../../sample.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: get material emissive property from GlslViewer's defines https://github.com/patriciogonzalezvivo/glslViewer/wiki/GlslViewer-DEFINES#material-defines 
use: vec4 materialEmissive()
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
*/

#ifndef FNC_MATERIAL_EMISSIVE
#define FNC_MATERIAL_EMISSIVE

#ifdef MATERIAL_EMISSIVEMAP
uniform SAMPLER_TYPE MATERIAL_EMISSIVEMAP;
#endif

vec3 materialEmissive() {
    vec3 emission = vec3(0.0);

#if defined(MATERIAL_EMISSIVEMAP) && defined(MODEL_VERTEX_TEXCOORD)
    vec2 uv = v_texcoord.xy;
    #if defined(MATERIAL_EMISSIVEMAP_OFFSET)
    uv += (MATERIAL_EMISSIVEMAP_OFFSET).xy;
    #endif
    #if defined(MATERIAL_EMISSIVEMAP_SCALE)
    uv *= (MATERIAL_EMISSIVEMAP_SCALE).xy;
    #endif
    emission = gamma2linear( SAMPLER_FNC(MATERIAL_EMISSIVEMAP, uv) ).rgb;

#elif defined(MATERIAL_EMISSIVE)
    emission = MATERIAL_EMISSIVE;
#endif

    return emission;
}

#endif