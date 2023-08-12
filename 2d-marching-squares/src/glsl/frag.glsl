precision highp float;

uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 u_resolution;
uniform sampler2D u_texture;

in vec2 v_uv;

out vec4 fragColor;

#include "../../../lygia/space/ratio.glsl"
#include "../../../lygia/generative/pnoise.glsl"

float sampleNoise(in vec2 uv) {
    return pnoise(uv * 5.0, vec2(0.0));
}

// #define FNC_SAMPLEMARCHINGSQUARES(TEX, UV) sampleNoise(UV)


#include "../../../lygia/sample/marchingSquares.glsl";

void main() {
  vec4 final = vec4(1.0, 0.0, 0.0, 1.0);

  vec2 st = ratio(v_uv, u_resolution);

  vec2 ms = sampleMarchinSquares(u_texture, st, u_resolution, u_mouse.x * 60.0, u_mouse.y);
  final.rgb = vec3(ms.r);

  fragColor = final;
}
