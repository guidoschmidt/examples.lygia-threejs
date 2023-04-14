precision highp float;

uniform vec3 u_cameraPosition;
uniform vec3 u_lightPosition;
uniform vec3 u_diffuseColor;
uniform vec3 u_noise[9];
uniform vec3 u_samples[9];
uniform sampler2D u_shadowMap;
uniform mat4 u_projection;

uniform float u_metallic;
uniform float u_roughness;
uniform float u_reflectance;

out vec4 fragColor;

in vec2 v_uv;
in vec3 v_normal;
in vec3 v_position;
in vec4 v_shadowPosition;

#define FNC_SAMPLE(TEX, UV) texture(TEX, UV)
#define LIGHT_POSITION u_lightPosition
#define CAMERA_POSITION u_cameraPosition
#define ATMOSPHERE_LIGHT_SAMPLES 8
#define TONEMAP_FNC tonemapACES

#include "../../../lygia/generative/random.glsl"
#include "../../../lygia/lighting/envMap.glsl";
#include "../../../lygia/lighting/pbr.glsl";
#include "../../../lygia/lighting/shadow.glsl";
#include "../../../lygia/lighting/material/new.glsl"
#include "../../../lygia/lighting/atmosphere.glsl"
#include "../../../lygia/lighting/ssao.glsl"
#include "../../../lygia/color/dither.glsl"
#include "../../../lygia/color/tonemap.glsl"

void main() {
  vec4 final = vec4(0.0, 0.0, 0.0, 1.0);

  vec3 lightPos = u_lightPosition;
  vec3 normal = normalize(v_normal);
  vec3 lightColor = vec3(1.0);
  vec3 lightDir = normalize(lightPos - v_position);
  vec3 viewDir = normalize(u_cameraPosition - v_position);

  Material material = materialNew();
  material.albedo.rgb = u_diffuseColor;
  material.emissive.rgb = u_diffuseColor * 0.0;
  material.normal = normalize(v_normal);
  material.metallic = u_metallic;
  material.roughness = u_roughness;
  material.ambientOcclusion = 0.6;

  final = pbr(material);

  vec3 shadowProjCoords = v_shadowPosition.xyz / v_shadowPosition.w;
  shadowProjCoords = shadowProjCoords * 0.5 + 0.5;

  float shadowing = shadow(u_shadowMap,
                           vec2(2048.0),
                           shadowProjCoords.xy,
                           shadowProjCoords.z + 0.0047);

  final.rgb = tonemap(final.rgb);
  final.rgb *= shadowing;

  fragColor = final;
}
