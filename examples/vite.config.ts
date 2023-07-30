// vite.config.js
import { readdirSync } from "fs";
import { resolve } from "path";
import type { Directory } from "fs";
import { defineConfig } from "vite";
import glsl from "vite-plugin-glsl";

const exampleEntries = {};

const filter = ["lygia", "node_modules", "dist"];
const exclude = [
  "raycasting",
  "raycasting.sdf",
  "deferred-rendering",
  "forward-rendering.todo",
];

readdirSync("./", { withFileTypes: true })
  .filter((e) => e.isDirectory())
  .filter(
    (dir: Directory) =>
      !dir.name.includes("nobuild") &&
      !filter.includes(dir.name) &&
      !exclude.includes(dir.name)
  )
  .forEach((dir: Directory) => {
    exampleEntries[dir.name] = resolve(__dirname, `${dir.name}/index.html`);
  });

export default defineConfig({
  plugins: [
    glsl({
      warnDuplicatedImports: false,
      compress: true,
    }),
  ],
  build: {
    target: "esnext",
    rollupOptions: {
      input: {
        main: resolve(__dirname, "index.html"),
        ...exampleEntries,
      },
    },
  },
});
