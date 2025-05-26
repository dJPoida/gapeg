declare module '@ruffle-rs/ruffle' {
    export interface RufflePlayerInstance extends HTMLElement {
        load(swfUrl: string | object): void;
        play(): void;
        pause(): void;
        // Add other methods and properties as needed based on Ruffle's API
    }

    export interface RufflePublicAPI {
        createPlayer(): RufflePlayerInstance;
        newest(): RufflePublicAPI; // Assuming newest() returns the API object itself for chaining or access
        // Add other API methods if any
    }

    export const RufflePlayer: RufflePublicAPI;
}

// Extend the Window interface to include RufflePlayer
interface Window {
    RufflePlayer?: RufflePublicAPI; // Changed from any to RufflePublicAPI
} 