#include "../lighting/raymarch/camera.glsl"
#include "../sample.glsl"

/*
original_author: Patricio Gonzalez Vivo
description: Displace UV space into a XYZ space using an heightmap
use: <vec3> displace(<SAMPLER_TYPE> tex, <vec3> ro, <vec3|vec2> rd) 
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - BILATERALBLUR_AMOUNT
    - BILATERALBLUR_TYPE
    - BILATERALBLUR_SAMPLER_FNC
*/

#ifndef DISPLACE_DEPTH
#define DISPLACE_DEPTH 1.
#endif

#ifndef DISPLACE_PRECISION
#define DISPLACE_PRECISION 0.01
#endif

#ifndef DISPLACE_SAMPLER_FNC
#define DISPLACE_SAMPLER_FNC(TEX, UV) SAMPLER_FNC(TEX, UV).r
#endif

#ifndef DISPLACE_MAX_ITERATIONS
#define DISPLACE_MAX_ITERATIONS 120
#endif

#ifndef FNC_DISPLACE
#define FNC_DISPLACE
vec3 displace(SAMPLER_TYPE tex, vec3 ro, vec3 rd) {

    // the z length of the target vector
    float dz = ro.z - DISPLACE_DEPTH;
    float t = dz / rd.z;

    // the intersection point between the ray and the hightest point on the plane
    vec3 prev = vec3(
        ro.x - rd.x * t,
        ro.y - rd.y * t,
        ro.z - rd.z * t
    );
    
    vec3 curr = prev;
    float lastD = prev.z;
    float hmap = 0.;
    float df = 0.;
    
    for (int i = 0; i < DISPLACE_MAX_ITERATIONS; i++) {
        prev = curr;
        curr = prev + rd * DISPLACE_PRECISION;

        hmap = DISPLACE_SAMPLER_FNC(tex, curr.xy - 0.5 );
        // distance to the displaced surface
        float df = curr.z - hmap * DISPLACE_DEPTH;
        
        // if we have an intersection
        if (df < 0.0) {
            // linear interpolation to find more precise df
            float t = lastD / (abs(df)+lastD);
            return (prev + t * (curr - prev)) + vec3(0.5, 0.5, 0.0);
        } 
        else
            lastD = df;
    }
    
    return vec3(0.0, 0.0, 1.0);
}

vec3 displace(SAMPLER_TYPE tex, vec3 ro, vec2 uv) {
    vec3 rd = raymarchCamera(ro) * normalize(vec3(uv - 0.5, 1.0));
    return displace(tex, ro, rd);
}
#endif