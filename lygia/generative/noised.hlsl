#include "srandom.hlsl"
#include "srandom.hlsl"

/*
original_author: Inigo Quilez
description: returns 2D/3D value noise in the first channel and in the rest the derivatives. For more details read this nice article http://www.iquilezles.org/www/articles/gradientnoise/gradientnoise.htm
use: noised(<float2|float3> space)
options:
    NOISED_QUINTIC_INTERPOLATION: Quintic interpolation on/off. Default is off.
*/

#ifndef NOISED_RANDOM2_FNC
#define NOISED_RANDOM2_FNC srandom2
#endif

#ifndef NOISED_RANDOM3_FNC
#define NOISED_RANDOM3_FNC srandom3
#endif

#ifndef FNC_NOISED
#define FNC_NOISED

float3 noised(in float2 p) {
    // grid
    float2 i = floor( p );
    float2 f = frac( p );

    // quintic interpolation
    float2 u = f * f * f * (f * (f * 6. - 15.) + 10.);
    float2 du = 30. * f * f * (f * (f - 2.) + 1.);

    float2 ga = NOISED_RANDOM2_FNC(i + float2(0., 0.));
    float2 gb = NOISED_RANDOM2_FNC(i + float2(1., 0.));
    float2 gc = NOISED_RANDOM2_FNC(i + float2(0., 1.));
    float2 gd = NOISED_RANDOM2_FNC(i + float2(1., 1.));

    float va = dot(ga, f - float2(0., 0.));
    float vb = dot(gb, f - float2(1., 0.));
    float vc = dot(gc, f - float2(0., 1.));
    float vd = dot(gd, f - float2(1., 1.));

    return float3(va + u.x*(vb-va) + u.y*(vc-va) + u.x*u.y*(va-vb-vc+vd),   // value
                    ga + u.x*(gb-ga) + u.y*(gc-ga) + u.x*u.y*(ga-gb-gc+gd) +  // derivatives
                    du * (u.yx*(va-vb-vc+vd) + float2(vb,vc) - va));
}

float4 noised(in float3 pos) {
    // grid
    float3 p = floor(pos);
    float3 w = frac(pos);

    // quintic interpolant
    float3 u = w * w * w * ( w * (w * 6. - 15.) + 10. );
    float3 du = 30.0 * w * w * ( w * (w - 2.) + 1.);

    // gradients
    float3 ga = NOISED_RANDOM3_FNC(p + float3(0., 0., 0.));
    float3 gb = NOISED_RANDOM3_FNC(p + float3(1., 0., 0.));
    float3 gc = NOISED_RANDOM3_FNC(p + float3(0., 1., 0.));
    float3 gd = NOISED_RANDOM3_FNC(p + float3(1., 1., 0.));
    float3 ge = NOISED_RANDOM3_FNC(p + float3(0., 0., 1.));
    float3 gf = NOISED_RANDOM3_FNC(p + float3(1., 0., 1.));
    float3 gg = NOISED_RANDOM3_FNC(p + float3(0., 1., 1.));
    float3 gh = NOISED_RANDOM3_FNC(p + float3(1., 1., 1.));

    // projections
    float va = dot(ga, w - float3(0., 0., 0.));
    float vb = dot(gb, w - float3(1., 0., 0.));
    float vc = dot(gc, w - float3(0., 1., 0.));
    float vd = dot(gd, w - float3(1., 1., 0.));
    float ve = dot(ge, w - float3(0., 0., 1.));
    float vf = dot(gf, w - float3(1., 0., 1.));
    float vg = dot(gg, w - float3(0., 1., 1.));
    float vh = dot(gh, w - float3(1., 1., 1.));

    // interpolations
    return float4( va + u.x*(vb-va) + u.y*(vc-va) + u.z*(ve-va) + u.x*u.y*(va-vb-vc+vd) + u.y*u.z*(va-vc-ve+vg) + u.z*u.x*(va-vb-ve+vf) + (-va+vb+vc-vd+ve-vf-vg+vh)*u.x*u.y*u.z,    // value
                ga + u.x*(gb-ga) + u.y*(gc-ga) + u.z*(ge-ga) + u.x*u.y*(ga-gb-gc+gd) + u.y*u.z*(ga-gc-ge+gg) + u.z*u.x*(ga-gb-ge+gf) + (-ga+gb+gc-gd+ge-gf-gg+gh)*u.x*u.y*u.z +   // derivatives
                du * (float3(vb,vc,ve) - va + u.yzx*float3(va-vb-vc+vd,va-vc-ve+vg,va-vb-ve+vf) + u.zxy*float3(va-vb-ve+vf,va-vb-vc+vd,va-vc-ve+vg) + u.yzx*u.zxy*(-va+vb+vc-vd+ve-vf-vg+vh) ));
}

#endif
