precision highp float;

uniform vec2 u_mouse;
uniform float u_time;
uniform vec2 u_resolution;

out vec4 fragColor;

#include "../../../lygia/generative/voronoi.glsl"
#include "../../../lygia/generative/curl.glsl"
#include "../../../lygia/generative/worley.glsl"
#include "../../../lygia/math/highPass.glsl"
#include "../../../lygia/color/palette.glsl"

#include "./marching_squares.glsl"

void main() {
  vec4 final = vec4(1.0, 0.0, 0.0, 1.0);

  vec2 uv = gl_FragCoord.xy / u_resolution * vec2(u_resolution.x / u_resolution.y, 1.0);
  float t = u_time * 0.25;

  vec3 ms = marchin_squares(uv + t, u_mouse.x * 60.0, u_mouse.y, u_resolution);
  final.rgb = vec3(ms.r);
  fragColor = final;
}
