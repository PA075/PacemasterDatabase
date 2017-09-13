(function (PHARMAACE) {
    (function (FORECASTAPP) {
        (function (VALIDATOR) {
            (function (exports) {
                function valOrFunction(val, ctx, args) {
                    if (typeof val == "function") {
                        return val.apply(ctx, args);
                    } else {
                        return val;
                    }
                }
                function InvalidInputHelper(element, options) {
                    element.setCustomValidity(valOrFunction(options.defaultText, window, [element]));
                    function changeOrInput() {
                        if (element.value == "" && options.emptyText) {
                            element.setCustomValidity(options.emptyText);
                        }
                        else if (options.comparerId != undefined && options.comparerId != null) {
                            var compareEle = document.getElementById(options.comparerId);
                            if ((compareEle != null) && (compareEle.value != element.value) && (options.comparerText)) {
                                element.setCustomValidity(options.comparerText);
                            }
                            else {
                                element.setCustomValidity("");
                            }
                        }
                        else if (options.condition != undefined && options.condition() == false) {
                            element.setCustomValidity(options.invalidText);
                        }
                        else {
                            element.setCustomValidity("");
                        }
                    }
                    function invalid() {
                        if (options.condition != undefined) {
                            if (options.condition() == false)
                                element.setCustomValidity(options.invalidText);
                            else
                                element.setCustomValidity("");
                        }
                        else if (element.value == "" && options.emptyText) {
                            element.setCustomValidity(options.emptyText);
                        }
                        else {
                            if (options.invalidText)
                                element.setCustomValidity(options.invalidText);
                            else
                                element.setCustomValidity("");
                        }
                    }
                    if (element.nodeName == "SELECT") {
                        element.removeEventListener("select", changeOrInput);
                        element.addEventListener("select", changeOrInput);
                    }
                    else {
                        element.removeEventListener("change", changeOrInput);
                        element.addEventListener("change", changeOrInput);
                    }
                    // element.addEventListener("element", changeOrInput);
                    if (options.invalidText) {
                        element.removeEventListener("invalid", invalid);
                        element.addEventListener("invalid", invalid);
                    }
                    //else {
                    //    element.removeEventListener("element", invalid);
                    //    element.addEventListener("element", invalid);
                    //}
                }
                exports.InvalidInputHelper = InvalidInputHelper;
            })(window);
            PHARMAACE.FORECASTAPP.VALIDATOR.validateControls = function (elementList) {
                for (var i = 0; i < elementList.length; i++) {
                    var elementDetails = elementList[i];
                    if (elementDetails) {
                        var element = document.getElementById(elementDetails.id);
                        InvalidInputHelper(element, {
                            defaultText: elementDetails.defaultText,
                            emptyText: elementDetails.emptyText,
                            invalidText: elementDetails.invalidText,
                            comparerId: elementDetails.comparerId,
                            comparerText: elementDetails.comparerText,
                            condition: elementDetails.condition
                        });
                    }
                }
            }
            //(function (exports) {
            //    function valOrFunction(val, ctx, args) {
            //        if (typeof val == "function") {
            //            return val.apply(ctx, args);
            //        } else {
            //            return val;
            //        }
            //    }
            //    function InvalidInputHelper(select, options) {
            //        select.setCustomValidity(valOrFunction(options.defaultText, window, [select]));
            //        function changeOrInput() {
            //            if (select.value == "--Select--") {
            //                select.setCustomValidity(valOrFunction(options.emptyText, window, [select]));
            //            } else {
            //                select.setCustomValidity("");
            //            }
            //        }
            //        function invalid() {
            //            if (select.value == "--Select--") {
            //                select.setCustomValidity(valOrFunction(options.emptyText, window, [select]));
            //            } else {
            //                select.setCustomValidity(valOrFunction(options.invalidText, window, [select]));
            //            }
            //        }
            //        select.addEventListener("change", changeOrInput);
            //        select.addEventListener("select", changeOrInput);
            //        select.addEventListener("invalid", invalid);
            //    }
            //    exports.InvalidInputHelper = InvalidInputHelper;
            //})(window);
            //InvalidInputHelper(document.getElementById("subscription"), {
            //    defaultText: "Please enter a subscription!",
            //    emptyText: "Please enter a subscription!",
            //});
        }(window.PHARMAACE.FORECASTAPP.VALIDATOR = window.PHARMAACE.FORECASTAPP.VALIDATOR || {}));
    }(window.PHARMAACE.FORECASTAPP = window.PHARMAACE.FORECASTAPP || {}));
}(window.PHARMAACE = window.PHARMAACE || {}));


