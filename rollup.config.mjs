import typescript from '@rollup/plugin-typescript';
import { nodeResolve } from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import serve from 'rollup-plugin-serve';
import livereload from 'rollup-plugin-livereload';
import copy from 'rollup-plugin-copy';

const isProduction = process.env.NODE_ENV === 'production';

export default {
  input: 'src/main.ts',
  output: {
    file: 'dist/bundle.js',
    format: 'iife', // Immediately Invoked Function Expression — suitable for <script> tags
    sourcemap: !isProduction,
  },
  plugins: [
    nodeResolve(),
    commonjs(),
    typescript({ tsconfig: './tsconfig.json', sourceMap: !isProduction, inlineSources: !isProduction }),
    copy({
      targets: [
        { src: 'src/index.html', dest: 'dist' },
        { src: 'src/GAPEG.swf', dest: 'dist' },
        { src: 'src/assets', dest: 'dist/assets' },
        { src: 'src/img', dest: 'dist' },
        { src: 'node_modules/@ruffle-rs/ruffle/*', dest: 'dist/ruffle' }
      ],
      copyOnce: true, // Avoids issues with watch mode re-copying unnecessarily
    }),
    !isProduction && serve({
      contentBase: 'dist',
      port: 3000,
      open: true, // Automatically open in browser
    }),
    !isProduction && livereload('dist'),
  ],
  external: ['@ruffle-rs/ruffle']
}; 