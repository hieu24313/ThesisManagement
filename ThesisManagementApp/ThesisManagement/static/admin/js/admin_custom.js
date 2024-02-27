document.addEventListener("DOMContentLoaded", function() {
    var header = document.querySelector("#header");

    if (header) {
        var newButton = document.createElement("a");
        newButton.className = "new-button";
        newButton.href = "./stats-major/";
        newButton.textContent = "Xem Thống Kê";

        header.appendChild(newButton);
    }
});