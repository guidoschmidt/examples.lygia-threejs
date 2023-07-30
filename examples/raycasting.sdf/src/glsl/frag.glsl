precision highp isampler2D;
precision highp usampler2D;

uniform vec2 u_resolution;
uniform vec3 u_camera;
uniform mat4 cameraWorldMatrix;
uniform mat4 invProjectionMatrix;
uniform mat4 invModelMatrix;
uniform sampler2D normalAttribute;

in vec2 v_uv;

out vec4 fragColor;


#define RESOLUTION vec2(800.0, 600.0);
#define RAYMARCH_SAMPLES 20
#define RAYMARCH_MULTISAMPLE 1

#define RAYMARCH_BACKGROUND (vec3(0.7, 0.9, 1.0) + ray.y * 0.8)
#define RAYMARCH_AMBIENT    vec3(0.9, 0.9, 0.9)

#include "../../../lygia/lighting/raymarch.glsl"
#include "../../../lygia/sdf.glsl"
#include "../../../lygia/space/ratio.glsl"

vec4 raymarchMap( in vec3 pos ) {
    vec4 res = vec4(1.0);
    res = opUnion(res, vec4(vec3(0.5), planeSDF(pos)));
    res = opUnion(res, vec4(0.1, 0.3, 0.6, pyramidSDF(pos - vec3(0.0, 0.10, 0.0), 1.0)));
    return res;
}

void main() {

  vec4 color = vec4(0.0);
  vec2 st = v_uv;
  vec2 uv = ratio(st, u_resolution);

  color.rgb = raymarch(u_camera, uv).rgb;
  color.a = 1.0;
  fragColor = color;
}
