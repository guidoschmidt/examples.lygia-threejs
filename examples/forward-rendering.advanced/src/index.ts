import {
  PerspectiveCamera,
  Scene,
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
  Clock,
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

const clock = new Clock();
clock.start();

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

let lightPosition = new Vector3(3, 3, 3);
const shadowCamera = new PerspectiveCamera(90, 1.0, 0.1, 100.0);
scene.add(shadowCamera);
shadowCamera.position.copy(lightPosition);
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
    u_roughness: { value: 0.0 },
    u_metallic: { value: 0.0 },
    u_reflectance: { value: 0.0 },
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

const count = 2;
for (var x = -count; x <= count; x++) {
  for (var y = -count; y <= count; y++) {
    const i = 0.1 + (x + count) / (2 * count + 0.2);
    const j = 0.1 + (x + count) / (2 * count + 0.2);
    console.log(i, j);
    const sphere = new SphereGeometry(0.5, 100, 100);
    sphere.translate(x * 1.5, 0.5, y * 1.5);
    const sphereMesh = new Mesh(sphere, lygiaMaterial.clone());
    sphereMesh.castShadow = true;
    const hue = Math.round(Math.random() * 360);
    sphereMesh.material.uniforms.u_diffuseColor.value = new Color(
      `hsl(${hue}, 100%, 50%)`
    );
    sphereMesh.material.uniforms.u_roughness.value = i;
    sphereMesh.material.uniforms.u_metallic.value = j;
    sphereMesh.material.uniforms.u_reflectance.value = 0.2;
    scene.add(sphereMesh);
  }
}

const ground = new PlaneGeometry(count * 4.0, count * 4.0);
ground.rotateX(-Math.PI * 0.5);
ground.translate(0, -0.2, 0);
const groundMesh = new Mesh(ground, lygiaMaterial.clone());
groundMesh.receiveShadow = true;
groundMesh.material.uniforms.u_diffuseColor.value = new Color(0xffffff);
groundMesh.material.uniforms.u_roughness.value = 0.99;
groundMesh.material.uniforms.u_metallic.value = 0.9;
groundMesh.material.uniforms.u_reflectance.value = 0.1;
scene.add(groundMesh);

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
  lightPosition.set(
    2 * Math.sin(clock.getElapsedTime()),
    5 + 2 * (Math.sin(clock.getElapsedTime() * 0.5) + 2.0),
    2 * Math.cos(clock.getElapsedTime())
  );
  shadowCamera.lookAt(0, 0, 0);
  shadowCamera.position.copy(lightPosition);
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
      material.uniforms.u_lightPosition.value = lightPosition;
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
