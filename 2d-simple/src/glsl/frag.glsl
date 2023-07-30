precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

out vec4 fragColor;

// #include "../../../lygia/generative/voronoi.glsl"
// #include "../../../lygia/generative/curl.glsl"
// #include "../../../lygia/generative/worley.glsl"
// #include "../../../lygia/math/highPass.glsl"
// #include "../../../lygia/color/palette.glsl"

void main() {
  vec4 final = vec4(1.0, 0.0, 0.0, 1.0);

  vec2 uv = gl_FragCoord.xy / u_resolution * vec2(u_resolution.x / u_resolution.y, 1.0);
  float t = u_time * 0.25;

  final.rgb = uv;
  fragColor = final;
}
