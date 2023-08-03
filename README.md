# Lygia Examples
These are examples of how to use [LYGIA Shader Library](https://lygia.xyz/) with
[three.js](https://threejs.org/)

Live examples: [lygia.guidoschmidt.cc](https://lygia.guidoschmidt.cc)

---

| Example                                           | Preveiw                                                                                 |
|---------------------------------------------------|-----------------------------------------------------------------------------------------|
| marching squares [2D]                             | ![Marching Squares [2D]]( ./2d-marching-squares/screenshot.png )       |
| forward rendering [basic]                         | ![Forward rendering [basic]]( ./3d-forward-rendering-basic/screenshot.png )       |
| forward rendering [advanced], 5 x 5 PBR Materials | ![Forward rendering [advanced]]( ./3d-forward-rendering-advanced/screenshot.png ) |

---

### How to start?
Clone this repository including its submodules. [LYGIA](https://github.com/patriciogonzalezvivo/lygia) is used as
git submodule in this repository.

```bash
git clone --recurse-submodules git@github.com:guidoschmidt/lygia_threejs_examples.git
```

---

### Run the examples
The repository contains several examples in. Each example is its own sub-project. You can start each example as following:

```bash
cd 3d-forward-rendering-basic
npm | yarn | pnpm install
npm | yarn | pnpm dev
```

You can also start an overview HTML page by running just:
```bash
npm | yarn | pnpm dev
```

---

### Open Issues & Ideas
- Use THREE.js internal light shadow map. Currently it looks like there's an
  incosistency when using `light.shadow.map.texture` as the shadow map texture.
- Create a custom `LygiaMaterial` in order to integrate into THREE.js render
  pipeline
- Pass all PBR material parameters to the Lygia shaders/materials
