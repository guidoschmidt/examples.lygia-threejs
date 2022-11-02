import {
  PerspectiveCamera,
  Scene,
  DirectionalLight,
  WebGLRenderer,
  Mesh,
  Vector3,
  PlaneGeometry,
  SphereGeometry,
  BoxGeometry,
  RawShaderMaterial,
  GLSL3,
  DepthTexture,
  WebGLRenderTarget,
  Color,
  PCFShadowMap,
  Matrix4,
} from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import Stats from "three/examples/jsm/libs/stats.module";
// GLSL
import vertexShader from "./glsl/forward.vert.glsl";
import fragmentShader from "./glsl/forward.frag.glsl";
import shadowVertexShader from "./glsl/shadow.vert.glsl";
import shadowFragmentShader from "./glsl/shadow.frag.glsl";
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

const fov = 50;
const aspect = canvas.width / canvas.height;
const near = 0.1;
const far = 100;
const camera = new PerspectiveCamera(fov, aspect, near, far);
camera.position.set(5, 5, -5);
camera.lookAt(new Vector3(0, 1, 0));

const controls = new OrbitControls(camera, renderer.domElement);
controls.target.set(0, 1, 0);
controls.update();

const scene = new Scene();

// Would be nice, if we could re-use the shadow map of
// THREEs native lights. However, it looks like there
// are some incosistensies.
// const light = new DirectionalLight(0xffffff, 1);
// light.position.set(3, 3, 3);
// light.lookAt(0, 0, 0);
// light.castShadow = true;
// scene.add(light);
// light.shadow.mapSize.width = 1024;
// light.shadow.mapSize.height = 1024;
// light.shadow.camera.near = 0.1;
// light.shadow.camera.far = 100;

const shadowCamera = new PerspectiveCamera(60, 1.0, 0.1, 100.0);
scene.add(shadowCamera);
shadowCamera.position.set(3, 3, 3);
shadowCamera.lookAt(0, 0, 0);

const shadowMaterial = new RawShaderMaterial({
  vertexShader: shadowVertexShader,
  fragmentShader: shadowFragmentShader,
  glslVersion: GLSL3,
});
const shadowMap: DepthTexture = new DepthTexture(1024, 1024);
const shadowTarget: WebGLRenderTarget = new WebGLRenderTarget(1024, 1024, {
  depthTexture: shadowMap,
});

const lygiaMaterial = new RawShaderMaterial({
  uniforms: {
    u_diffuseColor: { value: new Vector3() },
    u_lightPosition: { value: shadowCamera.position },
    u_cameraPosition: { value: camera.position },
    u_light_modelViewMatrix: { value: new Matrix4() },
    u_light_projectionMatrix: { value: shadowCamera.projectionMatrix },
    u_shadowMap: { value: shadowMap },
  },
  vertexShader,
  fragmentShader,
  glslVersion: GLSL3,
});

const ground = new PlaneGeometry(5, 5);
ground.rotateX(-Math.PI * 0.5);
const groundMesh = new Mesh(ground, lygiaMaterial.clone());
groundMesh.receiveShadow = true;
groundMesh.material.uniforms.u_diffuseColor.value = new Color(0xffffff);
scene.add(groundMesh);

const sphere = new SphereGeometry(0.5);
sphere.translate(0.75, 0.5, 0);
const sphereMesh = new Mesh(sphere, lygiaMaterial.clone());
sphereMesh.castShadow = true;
sphereMesh.material.uniforms.u_diffuseColor.value = new Color(0xff0000);
scene.add(sphereMesh);

const box = new BoxGeometry(0.5, 2.0, 0.5);
box.translate(-0.75, 1.01, 0);
const boxMesh = new Mesh(box, lygiaMaterial.clone());
boxMesh.castShadow = true;
boxMesh.material.uniforms.u_diffuseColor.value = new Color(0x0000ff);
scene.add(boxMesh);

const stats = Stats();
document.body.appendChild(stats.dom);

function resize(camera: PerspectiveCamera, renderer: WebGLRenderer) {
  const { innerWidth: width, innerHeight: height } = window;
  const aspect = width / height;
  camera.aspect = aspect;
  camera.updateProjectionMatrix();
  renderer.setSize(width, height);
  renderer.setPixelRatio(window.devicePixelRatio);
}

function render() {
  // Render shadow map
  renderer.setRenderTarget(shadowTarget);
  scene.overrideMaterial = shadowMaterial;
  renderer.render(scene, shadowCamera);
  scene.overrideMaterial = null;
  renderer.setRenderTarget(null);

  // Render scene
  const shadowModelViewMatrix = shadowCamera.matrixWorldInverse.multiply(
    shadowCamera.matrixWorld
  );
  scene.traverse((child) => {
    if (child.type === "Mesh") {
      const material = (child as Mesh).material as RawShaderMaterial;
      material.uniforms.u_shadowMap.value = shadowMap;
      material.uniforms.u_light_modelViewMatrix.value = shadowModelViewMatrix;
    }
  });
  renderer.render(scene, camera);

  stats.update();
}

resize(camera, renderer);
renderer.setAnimationLoop(render);

window.addEventListener("resize", () => resize(camera, renderer));
