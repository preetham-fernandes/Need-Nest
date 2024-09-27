import { defineConfig } from 'vite';
import path from "path"
import react from '@vitejs/plugin-react';
import NodePolyfillPlugin from 'node-polyfill-webpack-plugin';
import { resolve } from 'path'; // <-- Add this line


export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
      'Atharwa-Hack': resolve(__dirname, 'src'),  
    },
  },
  build: {
    rollupOptions: {
      plugins: [new NodePolyfillPlugin()],
    },
  },
});
