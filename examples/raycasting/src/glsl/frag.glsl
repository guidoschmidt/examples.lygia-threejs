precision highp isampler2D;
precision highp usampler2D;

#include "./shaderStrucst.glsl"
#include "./shaderIntersectionFunction.glsl"

uniform vec2 u_resolution;
uniform vec3 u_camera;
uniform mat4 cameraWorldMatrix;
uniform mat4 invProjectionMatrix;
uniform mat4 invModelMatrix;
uniform sampler2D normalAttribute;
uniform BVH bvh;

in vec2 v_uv;

out vec4 fragColor;



#define RAYMARCH_SAMPLES 100
#define RAYMARCH_MULTISAMPLE 4

#define RAYMARCH_BACKGROUND (vec3(0.7, 0.9, 1.0) + ray.y * 0.8)
#define RAYMARCH_AMBIENT    vec3(0.7, 0.9, 1.0)

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

  // get [-1, 1] normalized device coordinates
  // vec2 ndc = 2.0 * vUv - vec2( 1.0 );
  // vec3 rayOrigin, rayDirection;
  // ndcToCameraRay(ndc, invModelMatrix * cameraWorldMatrix, invProjectionMatrix,
  //                rayOrigin, rayDirection);

  // hit results
  // uvec4 faceIndices = uvec4( 0u );
  // vec3 faceNormal = vec3( 0.0, 0.0, 1.0 );
  // vec3 barycoord = vec3( 0.0 );
  // float side = 1.0;
  // float dist = 0.0;

  // get intersection
  // bool didHit = bvhIntersectFirstHit( bvh, rayOrigin, rayDirection, faceIndices, faceNormal, barycoord, side, dist );

  // #if SMOOTH_NORMALS
  // vec3 normal = textureSampleBarycoord(normalAttribute,
  //                                      barycoord,
  //                                      faceIndices.xyz).xyz;
  // #else
  // vec3 normal = face.normal;
  // #endif

  // set the color
  //gl_FragColor = ! didHit ? vec4(0.0366, 0.0813, 0.1057, 1.0) : vec4(normal, 1.0);
}
