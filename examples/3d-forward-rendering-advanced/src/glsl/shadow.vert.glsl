precision highp float;

in vec3 position;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec4 v_position;

void main() {
  v_position = vec4(position, 1.0);
  v_position = projectionMatrix * modelViewMatrix * v_position;
  gl_Position = v_position;
}
