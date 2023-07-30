out vec2 v_uv;

void main() {
  v_uv = uv;
  vec4 mvPosition = vec4( position, 1.0 );
  mvPosition = modelViewMatrix * mvPosition;
  gl_Position = projectionMatrix * mvPosition;
}
