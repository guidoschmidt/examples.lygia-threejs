#include "../color/palette/hue.glsl"
#include "../color/space/w2rgb.glsl"
#include "../color/space/gamma2linear.glsl"

/*
original_author: Paniq (https://www.shadertoy.com/view/Ms33zj)
description: based on the picture in http://home.hiroshima-u.ac.jp/kin/publications/TVC01/examples.pdf
use: <vec3> iridescence(<float> angle, <float> thickness)
*/

#ifndef FNC_IRIDESCENCE
#define FNC_IRIDESCENCE
vec3 iridescence(float cosA, float thickness) {
    // typically the dot product of normal with eye ray
    float NxV = cosA;
    
    // energy of spectral colors
    float lum = 0.05064;
    // basic energy of light
    float luma = 0.01070;
    // tint of the final color
    vec3 tint = vec3(0.7333,0.89804,0.94902);
    // vec3 tint = vec3(0.49639,0.78252,0.88723);
    // interference rate at minimum angle
    float interf0 = 2.4;
    // phase shift rate at minimum angle
    float phase0 = 1.0 / 2.8;
    // interference rate at maximum angle
    float interf1 = interf0 * 4.0 / 3.0;
    // phase shift rate at maximum angle
    float phase1 = phase0;
    // fresnel (most likely completely wrong)
    float f = (1.0 - NxV) * (1.0 - NxV);
    float interf = mix(interf0, interf1, f);
    float phase = mix(phase0, phase1, f);
    float dp = (NxV - 1.0) * 0.5;
    
    // film hue
    vec3 hue = 
    		// fade in higher frequency at the right end
        	mix(
                hue(thickness * interf0 + dp, thickness * phase0),
    			hue(thickness * interf1 + 0.1 + dp, thickness * phase1),
                f);
    
    vec3 film = hue * lum + vec3(0.49639,0.78252,0.88723) * luma;
    
    return gamma2linear( (film * 5.0 + pow(f, 6.0)) * tint );
    // return gamma2linear((film * 3.0 + pow(f, 16.0)) * tint);
    // return gamma2linear(film * 5.);
}

vec3 iridescence(vec3 V, vec3 N, vec3 L, float d) {
    return saturate( gamma2linear( w2rgb( abs(dot(N, -L) - dot(N, V)) * d) ) );
}

#endif