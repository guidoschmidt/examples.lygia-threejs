/*
original_author: Patricio Gonzalez Vivo 
description: Convert camera depth to view depth. based on https://github.com/mrdoob/three.js/blob/master/src/renderers/shaders/ShaderChunk/packing.glsl.js
use: <float> viewZ2depth( <float> viewZ, [, <float> near, <float> far] ) 
options: 
    - CAMERA_NEAR_CLIP
    - CAMERA_FAR_CLIP
    - CAMERA_ORTHOGRAPHIC_PROJECTION, if it's not present is consider a PERECPECTIVE camera
*/

#ifndef FNC_VIEWZ2DEPTH
#define FNC_VIEWZ2DEPTH
float viewZ2depth( const in float viewZ, const in float near, const in float far ) {
    #if defined(CAMERA_ORTHOGRAPHIC_PROJECTION)
    return ( viewZ + near ) / ( near - far );
    #else
    return ( ( near + viewZ ) * far ) / ( ( far - near ) * viewZ );
    #endif
}

#if defined(CAMERA_NEAR_CLIP) && defined(CAMERA_FAR_CLIP)
float viewZ2depth( const in float viewZ) {
    return viewZ2depth( viewZ, CAMERA_NEAR_CLIP, CAMERA_FAR_CLIP); 
}
#endif

#endif