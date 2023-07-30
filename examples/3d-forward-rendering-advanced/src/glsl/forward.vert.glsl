uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 u_light_modelViewMatrix;
uniform mat4 u_light_projectionMatrix;

in vec3 position;
in vec3 normal;
in vec2 uv;

out vec2 v_uv;
out vec3 v_normal;
out vec3 v_position;
out vec4 v_shadowPosition;

void main() {
  v_uv = uv;
  v_position = position;
  v_normal = normal;
  v_shadowPosition = u_light_projectionMatrix * u_light_modelViewMatrix * vec4(position, 1.0);
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
