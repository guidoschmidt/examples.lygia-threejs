precision highp float;

uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 u_resolution;

in vec2 v_uv;

out vec4 fragColor;

#include "../../../lygia/space/ratio.glsl"
#include "../../../lygia/generative/pnoise.glsl"
#include "../../../lygia/sample/marchingSquares.glsl";

void main() {
  vec4 final = vec4(1.0, 0.0, 0.0, 1.0);

  vec2 st = ratio(v_uv, u_resolution);

  vec2 ms = marchinSquares(st, u_mouse.x * 60.0, u_mouse.y, u_resolution);
  final.rgb = vec3(ms.r, ms.g, 0.0);

  fragColor = final;
}
