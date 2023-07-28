import {
  Clock, GLSL3, Mesh, OrthographicCamera, PCFShadowMap, PlaneGeometry, RawShaderMaterial, Scene,
  Vector2,
  WebGLRenderer
} from "three";
import Stats from "three/examples/jsm/libs/stats.module";
// GLSL
import fragmentShader from "./glsl/frag.glsl";
import vertexShader from "./glsl/vert.glsl";
// Style
import "./index.scss";

const canvas = document.createElement("canvas");
document.body.appendChild(canvas);
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const renderer = new WebGLRenderer({
  antialias: true,
  canvas,
});
renderer.shadowMap.enabled = true;
renderer.shadowMap.type = PCFShadowMap;

const clock = new Clock();
clock.start();


const scene = new Scene();

const camera = new OrthographicCamera(-0.5, 0.5, 0.5, -0.5, -1, 1);

const plane = new PlaneGeometry(1, 1);
const lygiaMaterial = new RawShaderMaterial({
  uniforms: {
    u_time: {value: 0},
    u_resolution: {value: new Vector2(canvas.width, canvas.height)},
    u_mouse: {value: new Vector2(0, 0) }
  },
  vertexShader,
  fragmentShader,
  glslVersion: GLSL3,
});
const fullscreenQuad = new Mesh(plane, lygiaMaterial);
scene.add(fullscreenQuad)

const stats = Stats();
document.body.appendChild(stats.dom);

function updateUniform(name: string, value: any) {
  lygiaMaterial.uniforms[name].value = value;
}

function resize(_camera: OrthographicCamera, renderer: WebGLRenderer) {
  const { innerWidth: width, innerHeight: height } = window;
  updateUniform("u_resolution", new Vector2(width, height));
  renderer.setSize(width, height);
  renderer.setPixelRatio(window.devicePixelRatio);
}

function render() {
  updateUniform("u_time", clock.getElapsedTime());
  renderer.render(scene, camera);
  stats.update();
}

resize(camera, renderer);
renderer.setAnimationLoop(render);

window.addEventListener("resize", () => resize(camera, renderer));
window.addEventListener("pointermove", (ev) => {
  const { clientX, clientY } = ev;
  const { innerWidth, innerHeight } = window;
  lygiaMaterial.uniforms.u_mouse.value.x = clientX / innerWidth
  lygiaMaterial.uniforms.u_mouse.value.y = clientY / innerHeight
})
