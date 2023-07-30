/*
original_author: Patricio Gonzalez Vivo 
description: Convert camera depth to view depth. based on https://github.com/mrdoob/three.js/blob/master/src/renderers/shaders/ShaderChunk/packing.glsl.js
use: <float> depth2viewZ( <float> depth [, <float> near, <float> far] ) 
options: 
    - CAMERA_NEAR_CLIP
    - CAMERA_FAR_CLIP
    - CAMERA_ORTHOGRAPHIC_PROJECTION, if it's not present is consider a PERECPECTIVE camera
*/

#ifndef FNC_DEPTH2VIEWZ
#define FNC_DEPTH2VIEWZ
float depth2viewZ( const in float depth, const in float near, const in float far ) {
    #if defined(CAMERA_ORTHOGRAPHIC_PROJECTION) 
    // ORTHOGRAPHIC
    return depth * ( near - far ) - near;
    #else 
    // PERSPECCTIVE
    return ( near * far ) / ( ( far - near ) * depth - far );
    #endif
}

#if defined(CAMERA_NEAR_CLIP) && defined(CAMERA_FAR_CLIP)
float depth2viewZ( const in float depth) {
    return depth2viewZ( depth, CAMERA_NEAR_CLIP, CAMERA_FAR_CLIP); 
}
#endif

#endif