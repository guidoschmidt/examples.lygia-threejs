#include "../sdf/lineSDF.glsl"
#include "../math/saturate.glsl"

/*
original_author: Morgan McGuire, @morgan3d, http://casual-effects.com
description: Draw arrows for vector fields from https://www.shadertoy.com/view/4s23DG
use: <float> arrows(<vec2> position, <vec2> velocity [, <vec2> resolution] )
options:
    - ARROWS_LINE_STYLE
    - ARROWS_TILE_SIZE
    - ARROWS_HEAD_ANGLE
    - ARROWS_HEAD_LENGTH
    - ARROWS_SHAFT_THICKNESS
*/

// #ifndef ARROWS_LINE_STYLE
// #define ARROWS_LINE_STYLE
// #endif

#ifndef ARROWS_TILE_SIZE
#define ARROWS_TILE_SIZE 32.0
#endif

#ifndef ARROWS_HEAD_ANGLE 
#define ARROWS_HEAD_ANGLE 0.5
#endif

// Used for ARROWS_LINE_STYLE
#ifndef ARROWS_HEAD_LENGTH
#define ARROWS_HEAD_LENGTH ARROWS_TILE_SIZE/5.0
#endif

#ifndef ARROWS_SHAFT_THICKNESS
#define ARROWS_SHAFT_THICKNESS 2.0
#endif

#ifndef FNC_ARROWS
#define FNC_ARROWS

// Computes the center pixel of the tile containing pixel pos
vec2 arrowsTileCenterCoord(vec2 pos) {
    return (floor(pos / ARROWS_TILE_SIZE) + 0.5) * ARROWS_TILE_SIZE;
}

// v = field sampled at tileCenterCoord(p), scaled by the length
// desired in pixels for arrows
// Returns 1.0 where there is an arrow pixel.
float arrows(vec2 p, vec2 v, vec2 resolution) {
    p *= resolution;

    // Make everything relative to the center, which may be fractional
    p -= arrowsTileCenterCoord(p);
        
    float mag_v = length(v);
    float mag_p = length(p);
        
    if (mag_v > 0.0) {
        // Non-zero velocity case
        vec2 dir_v = v / mag_v;
        
        // We can't draw arrows larger than the tile radius, so clamp magnitude.
        // Enforce a minimum length to help see direction
        mag_v = clamp(mag_v, 5.0, ARROWS_TILE_SIZE / 2.0);

        // Arrow tip location
        v = dir_v * mag_v;
        
        #if defined(ARROWS_STYLE_LINE)

            // Signed distance from shaft
            float shaft = lineSDF(p, v, -v);

            // Signed distance from head
            float head = min(   lineSDF(p, v, 0.4*v + 0.2*vec2(-v.y, v.x)),
                                lineSDF(p, v, 0.4*v + 0.2*vec2(v.y, -v.x)));

            return step(min(shaft, head), 1.);

        #elif defined(ARROWS_STYLE_LINE_TRIANGLE)
            // Signed distance from a line segment based on https://www.shadertoy.com/view/ls2GWG by 
            // Matthias Reitinger, @mreitinger

            // Line arrow style
            return saturate(1.0 + 
                    max( ARROWS_SHAFT_THICKNESS / 4.0 - 
                        max(abs(dot(p, vec2(dir_v.y, -dir_v.x))), // Width
                            abs(dot(p, dir_v)) - mag_v + ARROWS_HEAD_LENGTH / 2.0), // Length

                        // Arrow head
                        min(0.0, 
                            dot(v - p, dir_v) - cos(ARROWS_HEAD_ANGLE / 2.0) * length(v - p)) * 2.0 + // Front sides
                        min(0.0, 
                            dot(p, dir_v) + ARROWS_HEAD_LENGTH - mag_v) ) ); // Back
        #else
            // V arrow style
            return saturate(1.0 + 
                            // min(0.0, mag_v - mag_p) * 2.0 + // length
                            min(0.0, dot(normalize(v - p), dir_v) - cos(ARROWS_HEAD_ANGLE / 2.0)) * 2.0 * length(v - p) + // head sides
                            min(0.0, dot(p, dir_v) + 1.0) + // head back
                            min(0.0, cos(ARROWS_HEAD_ANGLE / 2.0) - dot(normalize(v * 0.33 - p), dir_v)) * mag_v * 0.8 ); // cutout
        #endif
    } 
    return 0.0;
}

float arrows(vec2 p, vec2 v) { return arrows(p, v, vec2(1.0)); }

#endif