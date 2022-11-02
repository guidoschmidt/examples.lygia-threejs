precision highp float;

uniform vec3 u_cameraPosition;
uniform vec3 u_lightPosition;
uniform vec3 u_diffuseColor;
uniform sampler2D u_shadowMap;

out vec4 fragColor;

in vec2 v_uv;
in vec3 v_normal;
in vec3 v_position;
in vec4 v_shadowPosition;

#define SAMPLER_FNC(TEX, UV) texture(TEX, UV)
#define LIGHT_POSITION       u_lightPosition
#define LIGHT_COLOR          vec3(1.0)
#define LIGHT_SHADOWMAP      u_shadowMap
#define LIGHT_DIRECTION      u_lightPosition
#define LIGHT_SHADOWMAP_SIZE 1024.0

#include "../../../lygia/lighting/diffuse.glsl";
#include "../../../lygia/lighting/shadow.glsl";

void main() {
  vec4 final = vec4(0.0, 0.0, 0.0, 1.0);

  vec3 lightPos = u_lightPosition;
  vec3 normal = normalize(v_normal);
  vec3 lightColor = vec3(1.0);
  vec3 lightDir = normalize(lightPos - v_position);
  vec3 viewDir = normalize(u_cameraPosition - v_position);

  float diffuseTerm = diffuse(lightDir, v_normal, viewDir, 0.0);
  final.rgb = diffuseTerm * u_diffuseColor;


  vec3 shadowProjCoords = v_shadowPosition.xyz / v_shadowPosition.w;
  shadowProjCoords = shadowProjCoords * 0.5 + 0.5;

  float shadowing = shadow(u_shadowMap,
                           vec2(1024.0),
                           shadowProjCoords.xy,
                           shadowProjCoords.z + 0.0048);
  final.rgb *= shadowing * 0.8 + 0.2;

  fragColor = final;
}
