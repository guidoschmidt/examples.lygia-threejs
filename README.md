# Lygia Examples
These are examples of how to use [LYGIA Shader Library](https://lygia.xyz/) with [three.js](https://threejs.org/)

---

| Example                                           | Preveiw                                                                                 |
|---------------------------------------------------|-----------------------------------------------------------------------------------------|
| forward rendering [basic]                         | ![Forward rendering [basic]]( ./examples/forward-rendering.basic/screenshot.png )       |
| forward rendering [advanced], 5 x 5 PBR Materials | ![Forward rendering [advanced]]( ./examples/forward-rendering.advanced/screenshot.png ) |

---

### How to start?
Clone this repository recursivelly

```bash
git clone --recursive git@github.com:guidoschmidt/lygia_threejs_examples.git
```

---

### Run the examples
The repository contains several examples in the [`./examples`](./examples)
folder. Each example is its own sub-project. You can start each example as following:

Using [yarn](https://yarnpkg.com/)
```bash
cd examples/forward-rendering.basic
yarn install
yarn dev
```

Using [npm](https://docs.npmjs.com/cli/v6/using-npm)
```bash
cd examples/forward-rendering.basic
npm install
npm run dev
```

---

### Open Issues & Ideas
- Use THREE.js internal light shadow map. Currently it looks like there's an
  incosistency when using `light.shadow.map.texture` as the shadow map texture.
- Create a custom `LygiaMaterial` in order to integrate into THREE.js render
  pipeline
- Pass all PBR material parameters to the Lygia shaders/materials
