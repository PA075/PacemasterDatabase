
$(document).ready(function () {
    localStorage.removeItem('selectedolditem');
    $("#btnprofile").attr("title", name);
    $('.img-zoom').hover(function () {
        $(this).addClass('transition');
    }, function () {
        $(this).removeClass('transition');
    });
    $('.rmore').bind("click", function () {
        if (typeof (chrome) !== 'undefined') {
            event.preventDefault();
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Utilities are supported only on IE", '');
            //detectChromeExtension('hehijbfgiekmjfkfjpbkbammjbdenadd', 'js/ietabapi_wp.js', chromeExtensionCallback);
        }
    });
});
detectChromeExtension = function (extensionId, accesibleResource, callback) {
    var testUrl = 'chrome-extension://' + extensionId + '/' + accesibleResource;
    $.ajax({
        url: testUrl,
        timeout: 1000,
        type: 'HEAD',
        success: function () {
            if (typeof (callback) == 'function')
                callback.call(this, true);
        },
        error: function () {
            if (typeof (callback) == 'function')
                callback.call(this, false);
        }
    });
};
function chromeExtensionCallback(extensionExists) {
    if (extensionExists) {
        var res = window.confirm("Please make sure the url " + window.location.protocol + "//" + window.location.host + "/Forecast* is added in the Auto URLs section of IETab options. Visit IETab options?");
        if (res) {
            window.open("http://www.ietab.net/options", "_blank");
        }
        else {
            var url = $('#generic_tool').attr("href");
            window.open(window.location.protocol + "//" + window.location.host + url);
        }
    } else {
        $('#generic_tool').attr("href", "");
        var res = window.confirm("Do you want to install IETab extension for chrome?")
        if (res) {
            window.open("https://chrome.google.com/webstore/detail/ie-tab/hehijbfgiekmjfkfjpbkbammjbdenadd/related?hl=en", "_blank");
        }
    }
}
function installIETab() {
    chrome.webstore.install("https://chrome.google.com/webstore/detail/hehijbfgiekmjfkfjpbkbammjbdenadd",
                function () {
                    window.alert("You have successfully installed IETab! Please make sure the url " + window.location.protocol + "//" + window.location.host + "/Forecast* is added in the Auto URLs section of IETab options.");
                    window.open("chrome-extension://hehijbfgiekmjfkfjpbkbammjbdenadd/options.html");
                },
                function () {
                    window.alert("Could not install IETab!");
                });
}

$(function () {
    Grid.init();
});

$("#menu-toggle").click(function (e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
    $("#wrapper").toggleClass("w1dispnone");
});
$("#menu-toggle1").click(function (e) {
    e.preventDefault();
    $("#wrapper1").toggleClass("toggled");
    $("#wrapper1").toggleClass("w1dispblock");
    $("#wrapper").toggleClass("toggled1");
});