
/*
original_author: Johan Ismael
description: |
  Color gamma correction similar to Levels adjusment in Photoshop
  Adapted from Romain Dura (http://mouaif.wordpress.com/?p=94)
use: levelsGamma(<float3|float4> color, <float|float3> gamma)
*/

#ifndef FNC_GAMMA
#define FNC_GAMMA
float3 levelsGamma(in float3 color, in float3 gammaAmount) {
  return pow(color, 1. / gammaAmount);
}

float3 levelsGamma(in float3 color, in float gammaAmount) {
  return levelsGamma(color, float3(gammaAmount, gammaAmount, gammaAmount));
}

float4 levelsGamma(in float4 color, in float3 gammaAmount) {
  return float4(levelsGamma(color.rgb, gammaAmount), color.a);
}

float4 levelsGamma(in float4 color, in float gammaAmount) {
  return float4(levelsGamma(color.rgb, gammaAmount), color.a);
}
#endif