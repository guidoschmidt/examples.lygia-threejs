#include "../../math/const.glsl"

/*
original_author: Hugh Kennedy (https://github.com/hughsk)
description: sine easing. From https://github.com/stackgl/glsl-easings
use: sine<In|Out|InOut>(<float> x)
examples:
    - https://raw.githubusercontent.com/patriciogonzalezvivo/lygia_examples/main/animation_easing.frag
*/

#ifndef FNC_SINEIN
#define FNC_SINEIN
float sineIn(in float t) {
    return sin((t - 1.0) * HALF_PI) + 1.0;
}
#endif

#ifndef FNC_SINEOUT
#define FNC_SINEOUT
float sineOut(in float t) {
    return sin(t * HALF_PI);
}
#endif

#ifndef FNC_SINEINOUT
#define FNC_SINEINOUT
float sineInOut(in float t) {
    return -0.5 * (cos(PI * t) - 1.0);
}
#endif
