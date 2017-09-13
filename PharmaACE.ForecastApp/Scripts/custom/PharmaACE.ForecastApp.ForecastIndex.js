

$(document).ready(function () {
        localStorage.removeItem('selectedolditem');
        
        if (generictoolAccess == true) {
           // $("#generic_tool").children().off('click');
           // $("#generic_tool").addClass("disabledbutton");
            $("#genericBox").removeClass("opac");
            $("#generic_tool").removeAttribute("onclick");
        }
        else if (generictoolAccess == false)
        {
            $("#genericBox").addClass("opac");
        }
            
        if (BDLToolAccess == true) {
           // $("#bdl_tool").attr("disabled", "disabled").off('click');
            // $("#bdl_tool").addClass("disabledbutton");
            $("#bdlBox").removeClass("opac");
            $("#bdl_tool").removeAttribute("onclick");
}
        else if (BDLToolAccess == false)
        {
            $("#bdlBox").addClass("opac");
        }
            
        if (PatientFlowAccess == true) {
            $("#patientBox").removeClass("opac");
            $("#acthar_tool").removeAttribute("onclick");
        }
        else if (PatientFlowAccess == false)
        {
            $("#patientBox").addClass("opac");
        }
            
        $("#btnprofile").html(firstname + "" + lastname);
        
        $("#btnprofile").attr("title", tooltiptitle);
        $('.img-zoom').hover(function () {
            $(this).addClass('transition');
        }, function () {
            $(this).removeClass('transition');
        });
        $('.forecast_model').bind("click", function () {
            if (typeof (chrome) !== 'undefined') {
                event.preventDefault();
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Forecasting is supported only on IE", '');
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
function getGuidFromDb(userDetails) {
    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetSessionForBrowser", { "uniqueId": userDetails.MessageId },
                  function (result) {
                      if (result.success) {
                          var url = $('.forecast_model').attr("href");
                          window.open(window.location.protocol + "//" + window.location.host + url + "?");
                      }
                      else {
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("fail.....", '');
                          window.open("http://www.ietab.net/options", "_blank");
                      }
                  },
                  function (result) {
                  }
                  );
}
function chromeExtensionCallback(extensionExists) {
    if (extensionExists) {
        bootbox.confirm({
            title: '',
            message: "Please make sure the url " + window.location.protocol + "//" + window.location.host + "/Forecast* is added in the Auto URLs section of IETab options. Visit IETab options?",
            buttons: {
                'cancel': {
                    label: 'I already have it',
                    className: 'btn-default pull-left'
                },
                'confirm': {
                    label: 'Take me to IEtab',
                    className: 'btn-danger pull-right'
                }
            },
            callback: function (results1) {
                if (results1 == false) {
                    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/SaveSessionForBrowser", null,
                   function (result) {
                       if (result.success) {
                           window.open(window.location.protocol + "//" + window.location.host + "/Forecast/ForecastModel?type=0");
                       }
                       else {
                           PHARMAACE.FORECASTAPP.UTILITY.popalert("fail.....", '');
                       }
                   },
                   function (result) {
                   }
                   );
                } else {
                    window.open("http://www.ietab.net/options", "_blank");
                }
            }
        });
    } else {
        $('.forecast_model').attr("href", "");
        bootbox.confirm("Do you want to install IETab extension for chrome?", function (result1) {
            if (result1 == false) {
                Example.show("Prompt Closed");
            } else {
                window.open("https://chrome.google.com/webstore/detail/ie-tab/hehijbfgiekmjfkfjpbkbammjbdenadd/related?hl=en", "_blank");
            }
        });
    }
}
function installIETab() {
    chrome.webstore.install("https://chrome.google.com/webstore/detail/hehijbfgiekmjfkfjpbkbammjbdenadd",
                         function () {
                             bootbox.alert("You have successfully installed IETab! Please make sure the url " + window.location.protocol + "//" + window.location.host + "/Forecast* is added in the Auto URLs section of IETab options.");
                             window.open("chrome-extension://hehijbfgiekmjfkfjpbkbammjbdenadd/options.html");
                         },
                         function () {
                             bootbox.alert("Could not install IETab!");
                         });
}
function UploadExcel() {
    $('#loading-indicator').show();
    var formdata = new FormData();
    var fileInput = $('#file')[0];
    if (fileInput.files != null && fileInput.files.length > 0) {
        var fileStream = fileInput.files[0];
        formdata.append(fileInput.files[0].name, fileInput.files[0]);
    }
    var modelPath;
    var controllerUrl = "/Forecast/UploadExcelFile?FileData=" + fileStream;
    var xhr = new XMLHttpRequest();
    xhr.open('POST', controllerUrl);
    xhr.send(formdata);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            $('#loading-indicator').hide();
            alert("File saved...");
        }
    }
    return false;
}