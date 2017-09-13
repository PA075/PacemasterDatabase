(function (PHARMAACE) {
    (function (FORECASTAPP) {
        (function (RENDERER) {
            PHARMAACE.FORECASTAPP.RENDERER.disableShortcuts = function (objRenderer) {
                objRenderer.OnKey("^c", "");
                objRenderer.OnKey("^c", "");
            }
        }(window.PHARMAACE.FORECASTAPP.RENDERER = window.PHARMAACE.FORECASTAPP.RENDERER || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));
