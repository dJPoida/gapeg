# GAPEG - Flash Game Web Wrapper

This project is a modern web wrapper for the classic Flash game "GAPEG". It allows the original SWF (Shockwave Flash) file to be played in contemporary web browsers using the [Ruffle.rs](https://ruffle.rs/) Flash Player emulator.

The original game was developed some time ago and this project aims to preserve its playability by packaging it within a modern JavaScript-based application structure.

## Project Status

This project is currently under development and will be hosted at:
[gapeg.maddyemmylabs.dev](https://gapeg.maddyemmylabs.dev)

## Development

This project uses Node.js, TypeScript, and Rollup for its build process.

### Prerequisites

*   Node.js (which includes npm)

### Setup

1.  Clone the repository (if applicable).
2.  Navigate to the project directory.
3.  Install dependencies:
    ```bash
    npm install
    ```

### Running in Development Mode

To run the game locally with a development server and live reloading:

```bash
npm run dev
```

This will typically open the game in your default browser at `http://localhost:3000`.

### Building for Production

To create a production-ready build in the `dist` folder:

```bash
npm run build
```

The contents of the `dist` folder can then be deployed to a web server.

## Project Structure

*   `src/`: Contains the source files:
    *   `index.html`: The main HTML page.
    *   `main.ts`: TypeScript file to initialize the Ruffle player.
    *   `GAPEG.swf`: The original Flash game file (or its new location if moved).
    *   `assets/`: Game-specific assets (sounds, images, etc.).
    *   `img/`: Website assets like favicons and manifest.
*   `dist/`: Contains the built project, ready for deployment.
*   `rollup.config.mjs`: Rollup bundler configuration.
*   `tsconfig.json`: TypeScript compiler configuration.
*   `package.json`: Project metadata and dependencies. 