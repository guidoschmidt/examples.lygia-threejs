/*
original_author: Ivan Dianov
description: polar to cartesian conversion.
use: polar2cart(<float2> polar)
*/

#ifndef FNC_POLAR2CART
#define FNC_POLAR2CART
float2 polar2cart(in float2 polar) {
    return float2(cos(polar.x), sin(polar.x)) * polar.y;
}
#endif