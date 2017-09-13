(function (PHARMAACE) {
    (function (FORECASTAPP) {
        (function (SERVICE) {
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData = function (controllerUrl, json, successCallback, failureCallback) {
                $.ajax({
                    type: 'get',
                    url: controllerUrl,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'html',
                    cache: false,
                    data: json,
                })
                .success(function (result) {
                    if (successCallback)
                        successCallback(result);
                })
                .error(function (xhr, status) {
                    if (failureCallback)
                        failureCallback(status);
                })             
            }
            PHARMAACE.FORECASTAPP.SERVICE.postHtmlData = function (controllerUrl, json, successCallback, failureCallback) {
                $.ajax({
                    type: 'post',
                    url: controllerUrl,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'html',
                    cache: false,
                    data: json,
                })
                .success(function (result) {
                    if (successCallback)
                        successCallback(result);
                })
                .error(function (xhr, status) {
                    if (failureCallback)
                        failureCallback(status);
                })
            }
            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostHtmlData = function (controllerUrl, json, successCallback, failureCallback) {
                $.ajax({
                    type: 'post',
                    url: controllerUrl,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'html',
                    cache: false,
                    traditional: true, //only relevant when json needs deep copy
                    data: json,                    
                })
                .success(function (result) {
                    if (successCallback)
                        successCallback(result);
                })
                .error(function (xhr, status) {
                    if (failureCallback)
                        failureCallback(status);
                })
            }
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData = function (controllerUrl, json, successCallback, failureCallback) {
                $.ajax({
                    type: 'get',
                    url: controllerUrl,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    //traditional: true, //only relevant when json needs deep copy
                    data: json,
                })
                .success(function (result) {
                    successCallback(result);
                })
                .error(function (xhr, status) {
                    failureCallback(status);
                })
            }
            PHARMAACE.FORECASTAPP.SERVICE.postJsonData = function (controllerUrl, json, successCallback, failureCallback) {
                $.ajax({
                    type: 'post',
                    url: controllerUrl,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    //traditional: true, //only relevant when json needs deep copy
                    data: json,
                })
                .success(function (result) {
                    successCallback(result);
                })
                .error(function (xhr, status) {
                    failureCallback(status);
                })
            }
            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData = function (controllerUrl, json, successCallback, failureCallback) {
                $.ajax({
                    type: 'post',
                    url: controllerUrl,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    cache: false,
                    traditional: true, //only relevant when json needs deep copy
                    data: json,
                })
                .success(function (result) {
                    successCallback(result);
                })
                .error(function (xhr, status) {
                    failureCallback(status);
                })
            }
            PHARMAACE.FORECASTAPP.SERVICE.postFormData = function (controllerUrl, formData, successCallback, failureCallback) {
                $.ajax({
                    type: 'post',
                    url: controllerUrl,
                    processData: false,
                    contentType: false,
                    cache: false,
                    data: formData,
                })
                .success(function (result) {
                    if (successCallback)
                        successCallback(result);
                })
                .error(function (xhr, status) {
                    if (failureCallback)
                        failureCallback(status);
                })
            }
        }(window.PHARMAACE.FORECASTAPP.SERVICE = window.PHARMAACE.FORECASTAPP.SERVICE || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));