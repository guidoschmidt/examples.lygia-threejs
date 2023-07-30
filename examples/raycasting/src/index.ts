import "./index.scss";
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import { FullScreenQuad } from "three/examples/jsm/postprocessing/Pass.js";
import Stats from "three/examples/jsm/libs/stats.module";
import { GLTF, GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader";
import {
  MeshBVH,
  MeshBVHUniformStruct,
  FloatVertexAttributeTexture,
  SAH,
} from "three-mesh-bvh";
// GLSL
import vertexShader from "./glsl/vert.glsl";
import fragmentShader from "./glsl/frag.glsl";
import { GLSL3, Vector2 } from "three";

const params = {
  enableRaytracing: true,
  animate: true,
  resolutionScale: 0.3 / window.devicePixelRatio,
  smoothNormals: true,
};

let renderer, camera, scene, stats;
let rtQuad, mesh, clock;

const geometry = await prepare();
init(geometry);
render();

async function prepare() {
  const gltfLoader = new GLTFLoader();
  const gltf: GLTF = await gltfLoader.loadAsync("/dragon.glb");
  const mesh: Mesh = gltf.scene.children[0] as Mesh;
  mesh.geometry.scale(0.01, 0.01, 0.01);
  return mesh.geometry;
}

function init(geometry) {
  // renderer setup
  renderer = new THREE.WebGLRenderer({ antialias: false });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setClearColor(0x09141a);
  renderer.setSize(window.innerWidth, window.innerHeight);
  renderer.outputEncoding = THREE.sRGBEncoding;
  document.body.appendChild(renderer.domElement);

  // scene setup
  scene = new THREE.Scene();

  const light = new THREE.DirectionalLight(0xffffff, 1);
  light.position.set(1, 1, 1);
  scene.add(light);
  scene.add(new THREE.AmbientLight(0xb0bec5, 0.5));

  // camera setup
  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    0.1,
    50
  );
  camera.position.set(0, 0, 4);
  camera.far = 100;
  camera.updateProjectionMatrix();

  // stats setup
  stats = new Stats();
  document.body.appendChild(stats.dom);

  //const geometry = new THREE.SphereGeometry();
  const bvh = new MeshBVH(geometry, { maxLeafTris: 1, strategy: SAH });
  mesh = new THREE.Mesh(geometry, new THREE.MeshStandardMaterial());
  scene.add(mesh);

  clock = new THREE.Clock();

  const rtMaterial = new THREE.ShaderMaterial({
    defines: {
      SMOOTH_NORMALS: 1,
    },
    uniforms: {
      u_resolution: {
        value: new Vector2(window.innerWidth, window.innerHeight),
      },
      u_camera: {
        value: camera.position,
      },
      bvh: { value: new MeshBVHUniformStruct() },
      normalAttribute: { value: new FloatVertexAttributeTexture() },
      cameraWorldMatrix: { value: new THREE.Matrix4() },
      invProjectionMatrix: { value: new THREE.Matrix4() },
      invModelMatrix: { value: new THREE.Matrix4() },
    },
    vertexShader,
    fragmentShader,
    glslVersion: GLSL3,
  });

  rtQuad = new FullScreenQuad(rtMaterial);
  rtMaterial.uniforms.bvh.value.updateFrom(bvh);
  rtMaterial.uniforms.normalAttribute.value.updateFrom(
    geometry.attributes.normal
  );

  new OrbitControls(camera, renderer.domElement);

  window.addEventListener("resize", resize, false);
  resize();
}

function resize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

  const w = window.innerWidth;
  const h = window.innerHeight;
  const dpr = window.devicePixelRatio * params.resolutionScale;
  renderer.setSize(w, h);
  renderer.setPixelRatio(dpr);
}

function render() {
  stats.update();
  requestAnimationFrame(render);

  const delta = clock.getDelta();
  if (params.animate) {
    // mesh.rotation.y += delta;
  }

  if (params.enableRaytracing) {
    camera.updateMatrixWorld();
    mesh.updateMatrixWorld();

    // update material
    const uniforms = rtQuad.material.uniforms;
    uniforms.cameraWorldMatrix.value.copy(camera.matrixWorld);
    uniforms.invProjectionMatrix.value.copy(camera.projectionMatrixInverse);
    uniforms.invModelMatrix.value.copy(mesh.matrixWorld).invert();

    // render float target
    rtQuad.render(renderer);
  } else {
    renderer.render(scene, camera);
  }
}
