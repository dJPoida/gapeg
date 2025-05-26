// Ruffle is now loaded globally via script tag in index.html

window.addEventListener("DOMContentLoaded", () => {
    if (window.RufflePlayer) {
        const ruffle = window.RufflePlayer.newest();
        const player = ruffle.createPlayer();
        const container = document.getElementById("flash-container");

        if (container && player) {
            container.appendChild(player);
            player.load("GAPEG.swf"); // Assumes GAPEG.swf is in the same directory (dist/ after build)
        } else {
            console.error("Ruffle container element not found or player could not be created.");
        }
    } else {
        console.error("RufflePlayer API not found on window object. Ensure Ruffle is loaded correctly.");
    }
}); 