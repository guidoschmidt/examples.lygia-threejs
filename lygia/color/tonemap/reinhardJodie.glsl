
#include "../luminance.glsl"

/*
original_author: [Erik Reinhard, Michael Stark, Peter Shirley, James Ferwerda]
description: Photographic Tone Reproduction for Digital Images. http://www.cmap.polytechnique.fr/~peyre/cours/x2005signal/hdr_photographic.pdf
use: <vec3|vec4> tonemapReinhardJodie(<vec3|vec4> x)
*/

#ifndef FNC_TONEMAPREINHARDJODIE
#define FNC_TONEMAPREINHARDJODIE
vec3 tonemapReinhardJodie(const vec3 x) { 
    float l = luminance(x);
    vec3 tc = x / (x + 1.0);
    return mix(x / (l + 1.0), tc, tc); 
}
vec4 tonemapReinhardJodie(const vec4 x) { return vec4( tonemapReinhardJodie(x.rgb), x.a ); }
#endif