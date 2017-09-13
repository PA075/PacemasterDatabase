
//*****************************************************ForecastMenu.ascx********************************************************************

var counter = 0;
var pageNumber = 1;
var start1;
var liLength;
var showListItems;
var linext = 0;
var itemperpage = 20;

function openModal() {
    hideEDraw();
    $('#creatNewForecast .modal-body').empty();
    PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.smartWizard.js", function () {

        PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/bootstrap/bootstrap-tagsinput.min.js", function () {
            $('input[rel="skus"]').tagsinput();
        });
        //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/calendar_zebra_datepicker.js");
        $('#wizard').smartWizard(null, createNewForecast);
        var numrow = 1;
        var numrowinline = 1;
        var numrowpipeline = 1;
        var numrowbdlmodel = 1;

        $("#add_scenario").click(function () {
            $('#addscenario' + numScenario).html("<div class=''><label class='control-label col-md-12 col-sm-12 col-xs-12 no-padding-left'>Scenario " + (numScenario) + "</label> </div><div class='col-md-12 col-sm-12 col-xs-12 no-padding-left'><div class='col-md-6 col-sm-6 col-xs-6 no-padding-left'><input type='text' id='scenario" + (numScenario + 1) + "' required='required' class='form-control col-md-7 col-xs-12'></div></div>");
            $('#step-2 form').append("<div class='form-group' id='addscenario" + (numScenario + 1) + "'></div>");
            numScenario++;
        });
        var numScenario = 6;

        $("#add_product").click(function () {
            $('#addproduct' + numrow).html("<td>" + (numrow + 1) + "</td>" +
                "<td><input name='products" + numrow + "' type='text' placeholder='Products' class='form-control input-md'  /> </td>" +
                "<td><div class='checkbox'><input type='checkbox' class='flats' name='brand" + numrow + "'></div></td>" +
                "<td> <div class='table  table-hover' style='margin-bottom:0px;'><div class='radchek'><input type='radio' class='flats' name='prodInPipeline" + numrow + "' id='prodInline" + numrow + "' value='Inline'  /></div><div class='radchek'><input type='radio' class='flats' name='prodInPipeline" + numrow + "' id='prodPipeline" + numrow + "' value='Pipeline' /></div></div> </td>" +
                "<td><div class='checkbox'> <input type='checkbox' class='flats' name='skuLevel" + numrow + "'></div></td>" +
                "<td> <div class='table  table-hover' style='margin-bottom:0px;'><div class='radchek'><input type='radio' class='flats' name='proj_mar_comp" + numrow + "' id='projection_market" + numrow + "' value='Projection Market" + numrow + "'  /></div><div class='radchek'><input type='radio' class='flats' name='proj_mar_comp" + numrow + "' id='projection_compititors" + numrow + "' value='Projection Compititors' /></div></div> </td>" +
                "<td><select class='selectpickerNew form-control search-filter select-dropdown selectBox' id='no-of-compititors" + numrow + "' ><option selected='selected' value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select></td>" +
                "<td><div class='tooltiproshan'><a class='inherit-colour'><div class='sleeve'><i class='fa fa-plus'></i>&nbsp;SKU<p  class='tollp'><input name ='sku" + numrow + "' rel='skuNew' id='txtallwords" + numrow + "' class='form-control' type='text' value='' data-role='tagsinput'></p></div></a></div></td>" +
                "<td><a class='' href='#' onclick='delCurrentRow(" + '"' + 'addproduct' + numrow + '"' + ")' style='color:red'><i class='fa fa-times'></i>  </a></td>");
            $('#tab_product tbody').append('<tr id="addproduct' + (numrow + 1) + '"></tr>');
            numrow++;
            $('input[rel="skuNew"]').tagsinput({
                //allowDuplicates: true
            });

            $("#delete_product").click(function () {
                if (numrow > 1) {
                    $("#addproduct" + (numrow - 1)).html('');
                    numrow--;
                }
            });
            $('.selectpickerNew').selectpicker({
                style: 'btn-default',
                size: 2
            });
            $('input.flats').iCheck({
                checkboxClass: 'icheckbox_flat-aero',
                radioClass: 'iradio_flat-aero'
            });

        });


        $('[id*=bdl_country]').multiselect({
            includeSelectAllOption: true
        });

        $('#wizard').smartWizard(null, createNewForecast);
        
        $('#datetimepicker').Zebra_DatePicker({
            view: 'years'
        });
        $('#datetimepicker1').Zebra_DatePicker({
            view: 'years'
        });
        $('#datetimepicker3').Zebra_DatePicker({
            format: 'Y',
            view: 'years',
        });
            
    });


    $('#cloneid #wizard').clone().appendTo("#creatNewForecast .modal-body");
    $('#addproduct0').html('');
    $('#addproduct0').html("<td>1</td>" +
               "<td><input name='products0' type='text' placeholder='Products' class='form-control input-md'  /> </td>" +
               "<td><div class='checkbox'><input type='checkbox' class='flat' name='brand0'></div></td>" +
               "<td> <div class='table  table-hover' style='margin-bottom:0px;'><div class='radchek'><input type='radio' class='flat' name='prodInPipeline0' id='prodInline0' value='Inline'  /></div><div class='radchek'><input type='radio' class='flat' name='prodInPipeline0' id='prodPipeline0' value='Pipeline' /></div></div> </td>" +
               "<td><div class='checkbox'> <input type='checkbox' class='flat' name='skuLevel0'></div></td>" +
               "<td> <div class='table  table-hover' style='margin-bottom:0px;'><div class='radchek'><input type='radio' class='flat' name='proj_mar_comp0' id='projection_market0' value='Projection Market0'  /></div><div class='radchek'><input type='radio' class='flat' name='proj_mar_comp0' id='projection_compititors0' value='Projection Compititors' /></div></div> </td>" +
               "<td><select class='selectpickerNew form-control search-filter select-dropdown selectBox' id='no-of-compititors0' ><option selected='selected' value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select></td>" +
               "<td><div class='tooltiproshan'><a class='inherit-colour'><div class='sleeve'><i class='fa fa-plus'></i>&nbsp;SKU<p  class='tollp'><input name ='sku0' rel='skuNew' id='txtallwords0' class='form-control' type='text' value='' data-role='tagsinput'></p></div></a></div></td>" +
               "<td><a class='' href='#' onclick='delCurrentRow(" + '"' + 'addproduct' + "0" + '"' + ")' style='color:red'><i class='fa fa-times'></i>  </a></td>");
    $('input.flat').iCheck({
        checkboxClass: 'icheckbox_flat-aero',
        radioClass: 'iradio_flat-aero'
    });

    $('#creatNewForecast').modal();

    counter++
}

function showPage(page) {
    start1 = (20 * page) - itemperpage;
    showListItems = $(".secondlevel li.secondli").splice(start1, itemperpage);
    $(".secondlevel li.secondli").hide();
    $(showListItems).show();
    linext = liLength - itemperpage * page;
}

$(document).ready(function () {
    var maxHeight = 500;
    /* For the Second level Dropdown menu, highlight the parent	*/

    $(function () {

        $(".dropdown-menu .dropdown-submenu .dropdown-menu .dropdown-submenu").on('mouseenter mouseleave', function (e) {
            $('ul.submenuFromBottom').removeAttr('style');
            $('ul').removeClass('submenuFromBottom');
            if ($('ul', this).length) {
                var elm = $('ul:first', this);
                var off = elm.offset();
                var l = off.top - 50;
                var w = elm.height();
                var docH = $(".page-content-wrapper-left").height();
                //var docW = $(".page-content-wrapper-left").width();

                var fromTop = w - (docH - l) - 29
                var isEntirelyVisible = (l + w <= docH);
                if (!isEntirelyVisible) {
                    $('ul:first', this).addClass('submenuFromBottom');
                    $('.submenuFromBottom').css("top", -fromTop);
                } else {
                    $(this).removeClass('submenuFromBottom');
                }
            }
        });

    });

    $('.navbar-nav .dropdown').hover(function (ev) {
        hideEDraw();
        $(this).find('.dropdown-menu').first().stop(true, true).delay(450).slideDown(600);


    }, function () {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(200).slideUp(600);
        pageNumber = 1;

    });


});


//*****************************************************ForecastMenu.ascx********************************************************************

//*****************************************************ForecastControl.ascx********************************************************************
    
function OA1_IESecurityReminder() {
        isTrusted = false;
        var choppedBaseUrl = baseUrl;
        if (baseUrl.endsWith('/'))
            choppedBaseUrl = baseUrl.slice(0, -1);
        bootbox.dialog({
            message: 'Please add ' + choppedBaseUrl + ' to your trusted sites and refresh the page.'
        });
        hideOverlay();
    }
function OA1_NotifyCtrlReady() {
    if (document.OA1) {
        document.OA1.Toolbars = false;
        if (document.OA1.DisableViewRightClickMenu)
            document.OA1.DisableViewRightClickMenu(true);
        document.OA1.LicenseName = "Halseeon6800972102";
        document.OA1.LicenseCode = "EDE8-555D-1202-ABF3";
        document.OA1.codebase = window.location.protocol + "//" + window.location.host + "/redist/x86/edexcel.cab#version=8,0,0,651";
        document.OA1.SetValue("AutomationSecurity", "msoAutomationSecurityLow");
    }
}
function populateInteropWorksheet() {
    if (objExcel == null) {
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not open forecast model", '');
        return;
    }
    clearTempFiles(document.all.OA1, objExcel);
    try {
        var worksheet = objExcel.Workbooks(1).Worksheets("SPDocLib");
        worksheet.UsedRange.Clear();
        worksheet.cells(1, 2).value = serverurl + "/sites/PharmaDocs/Shared Documents/PharmaACE Forecast Tool";
        worksheet.cells(1, 4).value = getTempDirectory();
        var sheetRow = 1;
        for (var i = 1; i < model.ForecastDetails.length; i++) {
            worksheet.cells(sheetRow + 1, 1).value = model.ForecastDetails[i].name;
            worksheet.cells(sheetRow + 1, 2).value = serverurl + model.ForecastDetails[i].url;
            if (model.ForecastDetails[i].treeNodeType == 1) {
                var versionValue = model.ForecastDetails[i].MajorVersion + "." + model.ForecastDetails[i].MinorVersion;
                if (model.ForecastDetails[i].versions && model.ForecastDetails[i].versions.length > 0) {
                    model.ForecastDetails[i].versions.slice().reverse().forEach(function (v) {
                        versionValue = versionValue + "," + v.MajorVersion + "." + v.MinorVersion;
                    });
                }
                worksheet.cells(sheetRow + 1, 3).value = versionValue;
            }
            sheetRow++;
        }
    }
    catch (e) {
        //eat exception
    }
}
function isEDrawInstalled() {        
    try {
        var checkForEDrawInstalled = new ActiveXObject("EDEXCEL.EDExcelCtrl.1");
        return true;
    }
    catch (ex) {
        return false;
    }
}

$(document).ready(function () {
    var checkEDrawInstalled = isEDrawInstalled();
    if (checkEDrawInstalled == true) {
        $('#loading-indicatorForEdraw').css("display", "none");
        OA1_NotifyCtrlReady();
        $('#OA1').ready(function () {
            //showOverlay("Loading Forecast Tool...", '', '15', '');
            hideEDraw();
            //setTimeout(function () {
            if (model.IsUtil) {
                onDocReady(1, "", "", "");
                showEDraw();
            }
            //}, 500);
        });
    }
    else {
        $('#init_label').text("Checking for required components.");
    }
});

var baseUrl = window.location.protocol + "//" + window.location.host + "/";
var IsSaveOrRetrieve = false;
//function showOverlay(loadmessage) {
//    if ($("body").overlay)
//        $("body").overlay(loadmessage);
//    $('#versionmsg').css("display", "none");
//}

function showOverlay(loadmessage, divid, loaderSize, fromTop)
{
    $('#versionmsg').css("display", "none");
    if ($("body").overlay)
        $("body").overlay(loadmessage, divid, loaderSize, fromTop);
       
}

//function hideOverlay(keepEDrawHidden) {
//    if ($.overlayout)
//        $.overlayout();
//    if (!keepEDrawHidden)
//        showEDraw();
//}

function hideOverlay(keepEDrawHidden, divid) {
    if ($("body").overlayout)
        $("body").overlayout(divid);
    if (!keepEDrawHidden)
        showEDraw();
}
    

function centerContent() {
    if (IsSaveOrRetrieve) {
        $('#versionmsg').css("display", "block");
    }
    var container = $('#page-content-wrapper');
    var content = $('#versionmsg');
    content.css("left", (container.width() - content.width()) / 2);
    content.css("top", (container.height() - content.height()) / 2);
}

function hideEDraw(addClassTo) {
    BgScreen = true;
    // alert('in hidedraw');
    if ($('#page-content-wrapper').not(".imgclickenable")) {
        $('#page-content-wrapper').addClass("imgclickenable");
    }
    $('.eDraw').css("display", "none");
    $('#dropdown1').css('height', "480px");
    $('#page-content-wrapper').removeClass('isForecastFullVisualisation');
    $('#page-content-wrapper').removeClass('isFullVisualisation');
    $('#divNotes').removeClass('isFullVisualisation');
    $('#divNotes').removeClass('isForecastFullVisualisation');
    $('#page-content-wrapper').removeClass('isForecastFullVisualisation');
    $('#page-content-wrapper').removeClass('isFullVisualisation');
    //$('#divNotes').removeClass('iswithoutForecastProductVisualisation');
    // $('#divNotes').removeClass('iswithoutProductVisualisation');
    //$('#divNotes').removeClass('hideprodfeed');
    $('#page-content-wrapper').addClass('bg2');
    $('#page-content-wrapper').css('background-image', "url('{0}')".replace("{0}", model.BackgroundImage));
    $('.visualizationPane').css("width", "0px");
    $('.visualizationPane').css("display", "none");
    setInterval(function () {
        if ($('#selectForecast option:selected').val() != -2 && $(".jqueryOverlayLoad").attr('class') != 'jqueryOverlayLoad') {
            centerContent();
        }
    }, 2000);
    if (addClassTo && addClassTo !== "")
        $(addClassTo).addClass("tempClass");
}

function showEDraw() {
    BgScreen = false;
    $('#page-content-wrapper').removeAttr("style");

    $('#page-content-wrapper').removeClass('bg2');
    $('#page-content-wrapper').css('background-image', '');
    $('#dropdown1').css('height', "0px");
    $('.eDraw').css("display", "block");
    $('#dropdown1').removeAttr("style");
    if ($('#selectedassumption').val() == 1) {
        $('.visualizationPane').css("display", "block");

        $('.visualizationPane').css("width", "330px");
    }
    else {
        $('.visualizationPane').removeAttr("style");
    }
    //OA1.focus();
    //OA1.click();
    //updateScreen();
    $('#importSerach').css("width", "140px");
    $('#importSerach').css("background-color", "#222 ");
    $('#importSerach').css("border", "1px solid #adadad");
    //objExcel.ScreenUpdating = true;
}

function downloadFileNew(name, versionLabel, onSuccess) {
    var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetForecastData", { projectName: name, versionLabel: versionLabel },
    function (result) {
        if (result.success) {
            PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv = result.forecastData.fv;
            PHARMAACE.FORECASTAPP.GENERICS.fioKey = "0_0_0";
            PHARMAACE.FORECASTAPP.GENERICS.forecastData.fio[PHARMAACE.FORECASTAPP.GENERICS.fioKey] = result.forecastData.fio;
            if (PHARMAACE.FORECASTAPP.GENERICS.forecastData)
                PHARMAACE.FORECASTAPP.GENERICS.populateForecastView();
            onSuccess(name, versionLabel);
        }
        else
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load forecast. Please try again." + result.errors.join(), '');
        hideOverlay();
    },
    function (result) {
        hideOverlay();
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load forecast! ", '');
    });
}

function onDocReadyForOfflineOpen(fileName , localPath)
{
    var returnValue;
    OA1.SetValue("AutomationSecurity", "msoAutomationSecurityLow");
    OA1.open(localPath);
    objExcel = OA1.GetApplication();
    returnValue =  checkSheetsCountofTemplate(fileName);
    if (!objExcel) {
        hideOverlay(true, '');
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load the forecast tool. Please try again.", "");
        hideEDraw();
    }
    else {
        try {
            try {
                PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast = objExcel.Workbooks(1).Worksheets("Generic_Forecast");
                PHARMAACE.FORECASTAPP.GENERICS.wks_Trending = objExcel.Workbooks(1).Worksheets("Trending");
                PHARMAACE.FORECASTAPP.GENERICS.wks_Price = objExcel.Workbooks(1).Worksheets("Pricing");
                PHARMAACE.FORECASTAPP.GENERICS.forecastData = { fio: {} };
                PHARMAACE.FORECASTAPP.GENERICS.fioKey = null;
            }
            catch (ex) {
                //
            }
            populateInteropWorksheet();
            setupSpreadsheet();
            //hideOverlay(!model.DisplayInitialModel);
        }
        catch (ex) {
            hideOverlay(!model.DisplayInitialModel);
        }
        try {
            if (objExcel.ActiveWindow)
                objExcel.ActiveWindow.DisplayHeadings = false;
            if (objExcel.ActiveWindow)
                objExcel.ActiveWindow.DisplayWorkbookTabs = false;
        }
        catch (ex) {
            //eat exception
        }
    }
    return returnValue;
}

function setupSpreadsheet() {
    if (document.OA1 && objExcel) {
        document.OA1.DisableViewRightClickMenu(true);
        document.OA1.ShowRibbonTitlebar(false);
        document.OA1.ShowMenubar(false);
        objExcel.EnableEvents = false;
        //objExcel.IgnoreRemoteRequests = true;
        objExcel.FlashFill = false;
        objExcel.DisplayStatusBar = false;
        objExcel.DisplayPasteOptions = false;
        objExcel.DisplayFormulaBar = false;
        if (objExcel.Workbooks) {
            for (var i = 0; i < objExcel.Workbooks.Count; i++) {
                objExcel.Workbooks[i].EnableAutoRecover = false;
            }
        }
    }
}

function onDocReady(isDownloadTool, name, versionLabel, pathforVba) {
    var toolName = "";
    if (isDownloadTool == 1)
    {
        toolName = model.ModelName;
    }
    else
    {
        toolName = name;
    }
    downloadFile(document.all.OA1, toolName, versionLabel, false,pathforVba,
        function (modelUrl) {
            OA1.SetValue("AutomationSecurity", "msoAutomationSecurityLow");
            OA1.open(modelUrl);
            objExcel = OA1.GetApplication();
            if (!objExcel) {
                hideOverlay(true,'');
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load the forecast tool. Please try again.", "");
                hideEDraw();
            }
            else {
                try {                    
                    if (!model.IsUtil) {
                        try {
                            PHARMAACE.FORECASTAPP.GENERICS.wks_Forecast = objExcel.Workbooks(1).Worksheets("Generic_Forecast");
                            PHARMAACE.FORECASTAPP.GENERICS.wks_Trending = objExcel.Workbooks(1).Worksheets("Trending");
                            PHARMAACE.FORECASTAPP.GENERICS.wks_Price = objExcel.Workbooks(1).Worksheets("Pricing");
                            PHARMAACE.FORECASTAPP.GENERICS.forecastData = { fio: {} };
                            PHARMAACE.FORECASTAPP.GENERICS.fioKey = null;
                        }
                        catch (ex) {
                            // hideOverlay();
                            //
                        }
                        populateInteropWorksheet();
                    }
                    else {
                        try {
                            //objExcel.ExecuteExcel4Macro('SHOW.TOOLBAR("Ribbon",False)');
                            updateScreen();
                        }
                        catch (e) {
                            //eat exception
                        }
                    }
                    setupSpreadsheet();
                    hideOverlay(!model.DisplayInitialModel);
                }
                catch (ex) {
                    //Isinmiddleofretrieve = false;
                    //hideOverlay(!model.DisplayInitialModel);
                }
                try{
                    if (objExcel.ActiveWindow)
                        objExcel.ActiveWindow.DisplayHeadings = false;
                    if (objExcel.ActiveWindow)
                        objExcel.ActiveWindow.DisplayWorkbookTabs = false;
                }
                catch (ex) {
                    //eat exception
                    // hideOverlay();
                }
            }
        },
        isDownloadTool);
}

//*****************************************************ForecastControl.ascx********************************************************************

//*****************************************************ForecastRightPane.ascx********************************************************************

var isRetrieving = false;

function toggle() {
    updateScreen(true);
    if ($('#divNotes').hasClass('isForecastFullVisualisation')) {
        $('#eDraw').css('display', 'block');
    }
    //if ($('#divNotes').hasClass('isForecastFullVisualisation')) {
    //    $('#eDraw').css('display', 'block');
    //}

    $('#page-content-wrapper').removeClass('isForecastFullVisualisation');
    $('#page-content-wrapper').removeClass('isFullVisualisation');
    $('#divNotes').removeClass('isFullVisualisation');
    $('#divNotes').removeClass('isForecastFullVisualisation');
    $('.visualizationPane .toggleBtn').toggleClass("isCollapsed", 800);
    $('.visualizationPane').toggleClass("isCollapsed");
    if ($('.visualizationPane').hasClass('isCollapsed')) {
        $('.visualizationPane').css("width", "30px");
        $('#selectedassumption').val('0');
        //$('#selectedassumption').val('0');

    }
    else {
        if (($('.taskPane').hasClass('isCollapsed')) || ($('#selectedassumption').val() == 1)) {

            $('.visualizationPane').css("width", "330px");
        }
        else {
            $('.visualizationPane').css("width", "180px");
        }
    }
}
function toggleTaskPane() {
    updateScreen(true);
    $('.taskPane .toggleBtn').toggleClass("isCollapsed", 800);
    $('.taskPane').toggleClass("isCollapsed");
    if ($('.taskPane').hasClass('isCollapsed')) {
        if ($('.visualizationPane').hasClass('isCollapsed')) {
            $('.visualizationPane').css("width", "30px");
        }
        else {
            $('.visualizationPane').css("width", "330px");
        }
        $('#divNotes').addClass('hideprodfeed');
    }
    else {
        $('#divNotes').removeClass('hideprodfeed');
        if ($('.visualizationPane').hasClass('isCollapsed')) {
            $('.visualizationPane').css("width", "30px");
        }
        else {

            $('.visualizationPane').css("width", "180px");
        }

    }

}
function onNewsLoaded() {
    if (isRetrieving == true) {
        isRetrieving = false;
        if (currentForecast.version != "V0.0")
            PHARMAACE.FORECASTAPP.UTILITY.popalert("{0} {1} retrieved successfully".replace("{0}", currentForecast.name).replace("{1}", currentForecast.version));            
        else
            PHARMAACE.FORECASTAPP.UTILITY.popalert("{0} retrieved successfully".replace("{0}", currentForecast.name));

        hideOverlay();
        //updateScreen(true);
    }
}
function updateFeed() {
    updateFeedUrl(null);
    //PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetProductNewsParams", { product: getProduct() },
    //    function (result) {
    //        if (result.success) {
    //            updateFeedUrl(result.data);
    //        }
    //        else
    //            updateFeedUrl();
    //    },
    //    function (result) {
    //        updateFeedUrl();
    //    });
}
function updateFeedUrl(data) {    
    var product = getProduct();
    if (product && product.length > 0)
        basicNews = $.trim(product); //'"' + $.trim(product) + '"';
    //replace all spaces with +
    var flattenedParams = basicNews.replace(/\s+/g, '%2B');
    var relatedParams = "";
    if (data) {
        if (data.Indications != null) {
            for (var i = 0; i < data.Indications.length; i++) {
                if (relatedParams.length > 0)
                    relatedParams += '%20';
                relatedParams += $.trim(data.Indications[i]).replace(/\s+/g, '%20');
            }
        }
        if (data.DiseaseAreas != null) {
            for (var i = 0; i < data.DiseaseAreas.length; i++) {
                if (relatedParams.length > 0)
                    relatedParams += '%20';
                relatedParams += $.trim(data.DiseaseAreas[i]).replace(/\s+/g, '%20');
            }
        }
    }
    var updatedFeedUrl = updateFeedTerms(document.getElementById('product_news').children[1].src, flattenedParams, relatedParams);
    if (document.getElementById('product_news').children[1].src != updatedFeedUrl)
        document.getElementById('product_news').children[1].src = updatedFeedUrl;
    else
        hideOverlay();
}
function updateFeedTerms(feedUrl, flattenedParams, relatedParams) {
    var url = updateFeedParams(feedUrl, flattenedParams, "q%3D", "%26output%3Drss", relatedParams);
    return updateFeedParams(url, flattenedParams, "term%3D", "%26count%3D", relatedParams);
}


//function updateFeedTerms(feedUrl, flattenedParams, relatedParams) {
//    return updateFeedParams(feedUrl, flattenedParams, "q%3D", "%26output%3Drss", relatedParams);
//}
function updateFeedParams(feedUrl, params, splitter1, splitter2, relatedParams) {
    if (!feedUrl)
        return feedUrl;
    var arr = feedUrl.split(splitter1);
    if (arr.length <= 1)
        return feedUrl;
    var arr2 = arr[1].split(splitter2);
    if (arr2.length == 1)
        arr2[1] = '';
    if (relatedParams && relatedParams.length > 0)
        params += "%26oq%3D" + relatedParams;
    return arr[0] + splitter1 + params + splitter2 + arr2[1];
}






//function updateFeedParams(feedUrl, params, splitter1, splitter2, relatedParams) {
//    if (!feedUrl)
//        return feedUrl;
//    var arr = feedUrl.split(splitter1);
//    if (arr.length <= 1)
//        return feedUrl;
//    var arr2 = arr[1].split(splitter2);
//    if (arr2.length == 1)
//        arr2[1] = '';
//    //var arr3 = arr2[1].split(splitter3);
//    //if (arr3.length == 1)
//    //    arr3[1] = '';
//    if (params && params.length > 0)
//        params += "%26oq%3D" + params;
//    return arr[0] + splitter1 + params + splitter2 + arr3[0] + splitter3 + params + arr3[1];
//}

//*****************************************************ForecastRightPane.ascx********************************************************************

//*****************************************************ForecastModel.aspx********************************************************************

var templatePath = "";
var consolidatorTemplatePath = "";
var objExcel;
var assumptionSet;
var attachmentMap = [];
var urlArr = [];
var unshareArray = [];
var userArrayShared = [];
var userForecastMappingForShare = [];
var saveNewForecast = false;
var currentForecast = { name: "", version: "", item: {} };
var isRetrieving = false;
var isCreatedOrRetrieved = false;
var userId;
var isTrusted = true;
var BgScreen;
var setUnsaveCreateForecastName;
var chartConfig = { ProductIndex: "", SkuIndex: "" };
var chartConfigBdl = { countryIndex: "", productIndexBdl: "" };
var rememberChartValue;
var attachForecastNames = [];
var isSaveAsForecast = false;
var isCountryChanged = false, isProductChanged = false, isSKUChanged = false, isScenarioChanged = false;
var checkedVersionminorIndex = 0;
var checkedVersionIndex = 0;
var isTotalIndication = false, isIndication = false;
var offlineSave = false;
var projectOkCheck = false;
var isImportImsData = false;
var IsCreated = false;
var IsSaveOrRetrieve = false;
var Isinmiddleofretrieve = false;
var isDownloadonlyflatFile = false;
var versionArrayForCopy = [];
var isRefreshedModel = false;
var autocompleteListData;
var usersInformation;
var isOfflineFlatFile = false;
var shareType = "Forecast";
var arrofPermissions = listOfPermissions();
var autocompleteFlagForSelectedVal = true;
var isDragDropEvent = false;
var hideInProgress = false;
var showModalId = '';
var forecastVar = "";//send to forecast reference
var versionVar = "";//send to forecast reference
var fileCheckedFlag = [];
var backgroundExcelKilled = false;
var selectedProduct = "";

function addDisabledctrnew() {
        $('#ctrnew').addClass('disabled onclk');
        $('#ctrnew').removeAttr('onclick');
    }

function addDisabledopen() {
    $('#openforcst').addClass('disabled onclk');
    $('#openforcst').off('click');
}

function removeDisable() {
    $('#ctrnew').attr('onclick', 'createNewForecast();');
    $('#openforcst').attr('onclick', 'editForecast();');
    $('#conso').attr('onclick', 'clidator();');
    $('#conso').removeClass('disabled onclk');
    $('#ctrnew').removeClass('disabled onclk');
    $('#openforcst').removeClass('disabled onclk');
    $('#chartbox a.enbdisbl').removeClass('disabled');
    $('#formulabox a.enbdisbl').removeClass('disabled');
}

function disableButton() {
    $("#tabmenu .navbar-nav li a.enbdisbl").addClass("disabled");
    $('#tabmenu .navbar-nav li a.enbdisbl').removeAttr('onclick');
    $('#tabmenu .navbar-nav li a.enbdisbl').removeAttr('data-toggle');
    removeDisable();
}

function enableButton()
{
    if (accessTypeGT == 3) {

        $('#createid').addClass('disabled');
        $('#createid').removeAttr('onclick');
        $('#openofflinebox').removeAttr('onclick');
        $('#openofflinebox').addClass('disabled');
        $('#openofflinefortemplate').removeAttr('onclick');
        $('#openofflinefortemplate').addClass('disabled');
        $('#syncid').removeAttr('onclick');
        $('#syncid').addClass('disabled');

        $('#editbox a').removeAttr('onclick');
        $('#editbox a').addClass('disabled');
        $('#savebox a').removeAttr('onclick');
        $('#savebox a').addClass('disabled');
        $('#attdoc a').removeAttr('onclick');
        $('#attdoc a').addClass('disabled');
        $('#sharebox a').removeAttr('onclick');
        $('#sharebox a').addClass('disabled');
        $('#unsharebox a').removeAttr('onclick');
        $('#unsharebox a').addClass('disabled');
        $('#npvbox a').removeAttr('onclick');
        $('#npvbox a').addClass('disabled');
        $('#assumptionsheetid a').removeAttr('onclick');
        $('#assumptionsheetid a').addClass('disabled');
            
        $('#chartbox a.enbdisbl').attr('data-toggle', 'modal');
        $('#chartbox a.enbdisbl').attr('onclick', 'openChart();hideEDraw();');
        $('#formulabox a.enbdisbl').attr('onclick', 'toggleFormulaBar(this);');

    }
    else {

        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        $("#tabmenu .navbar-nav li a.enbdisbl").removeClass("disabled");
        //$('#editbox a.enbdisbl').attr('onclick', 'Edit();');
        $('#savebox a.enbdisbl').attr('data-toggle', 'modal');
        $('#savebox a.enbdisbl').attr('onclick', 'hideEDraw();');
        $('#attdoc a.enbdisbl').attr('onclick', 'cleanFileList();hideEDraw();');
        $('#chartbox a.enbdisbl').attr('onclick', 'openChart();hideEDraw();');
        $('#chartid').attr('onclick', 'openChartPopup();hideEDraw();');
        $('#formulabox a.enbdisbl').attr('onclick', 'toggleFormulaBar(this);');
        $('#sharebox a.enbdisbl').attr('onclick', 'hideEDraw();');
        $('#sharebox a.enbdisbl').attr('data-toggle', 'modal');
        //$('#openofflinefortemplate a.enbdisbl').attr('onclick', 'hideEDraw();');
        //$('#openofflinefortemplate a.enbdisbl').attr('data-toggle', 'modal');
        $('#closebutton a.enbdisbl').attr('onclick', 'hideEDraw();');
        $('#chartbox a.enbdisbl').attr('data-toggle', 'modal');
        $('#unsharebox a.enbdisbl').attr('data-toggle', 'modal');
        $('#attdoc a.enbdisbl').attr('data-toggle', 'modal');
        $('#conso a.enbdisbl').attr('onclick', 'clidator();');
        $('#syncid a.enbdisbl').attr('onclick', 'hideEDraw();');
        $('#syncid a.enbdisbl').attr('data-toggle', 'modal');
        if (modelType == 0) {
            $('#npvbox a.enbdisbl').attr('onclick', 'hideEDraw();');
            $('#assumptionsheetid a.enbdisbl').attr('onclick', 'hideEDraw();');
        }
        else if(modelType == 1)
        {
            $('#npvbox a.enbdisbl').addClass("disabled");
            $('#assumptionsheetid a.enbdisbl').addClass("disabled");
            $('#syncid a.enbdisbl').addClass("disabled");
            //$('#help a.enbdisbl').addClass("disabled");
            $('#importimsdataid a.enbdisbl').addClass("disabled");
            $('#helpid a.enbdisbl').addClass("disabled");
            $('#editbox a.enbdisbl').addClass("disabled");
            $('#compareversionid a.enbdisbl').addClass("disabled");
                    
        }
                
        //if (modelType == 0 || modelType == 1) { 
        //    $('#npvbox').css("display", "block");
        //    $('#npvbox a.enbdisbl').attr('onclick', 'hideEDraw();');
        //}
    }
        
        
    removeDisable();
}
    
function checkJSNetConnection() {
    var xhr = new XMLHttpRequest();
    var file = "../../Content/img/call.jpg";
    var r = Math.round(Math.random() * 10000);
    xhr.open('HEAD', file + "?subins=" + r, false);
    try {
        xhr.send();
        if (xhr.status >= 200 && xhr.status < 304) {
            return true;
        } else {
            return false;
        }
    } catch (e) {
        return false;
    }
}

function onJSButtonclick(status) {
    if (!objExcel)
        return;

    if (status == 0) {
        //var ttl = status == 0 ? "You are offline" : "You are logged out";
        //var msgl = status == 0 ? "Do you want to save your work locally?" : "Do you want to save your work";
        var ttl = "You are offline";
        var msgl =  "Do you want to save your work locally?";
        bootbox.dialog({
            message: msgl,
            title: ttl,
            closeButton: true,
            size: 'small',
            className: "custom-dialogue",
            buttons: {
                success: {
                    label: "Yes",
                    className: "btn-diabox",
                    callback: function (result) {
                        if (result) {
                            var vbaMethod = "'{0}'!Save_in_Local_Drive".replace("{0}", objExcel.Workbooks(1).Name);
                            if (runMacro(vbaMethod)) {
                                hideOverlay();
                            }
                        }
                    }
                },
                danger: {
                    label: "No",
                    className: "btn-default",
                    callback: function () {
                        hideOverlay();
                    }
                },
                main: {
                    label: "Cancel",
                    className: "btn-dacancel",
                    callback: function () {
                        bootbox.hideAll();
                    }
                }
            }
        });
        hideEDraw();
    }

    else {
        var formLable = "You are logged out please sign in to continue";
        PHARMAACE.FORECASTAPP.UTILITY.createSignInForm(formLable);
        $('#loginform').modal('show');
        hideEDraw();
        $('#signinid').submit(function () {
            var email = $('#recipient-name').val();
            var password = $('#message-text').val();
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/SignInTest", { email: email, password: password },
                    function (result) {
                        $('#loginform').modal('hide');
                        showEDraw();
                        $('#recipient-name').val('');
                        $('#message-text').val('');
                           
                    },
                     function (status) {
                         $('#loginform').modal('hide');
                         showEDraw();
                         $('#recipient-name').val('');
                         $('#message-text').val('');
                         PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not log in.", '');
                     });
            return false;
        });
    }
}

function saveOfflineByUser()
{
    if (!objExcel)
        return;

    showOverlay("Saving forecast offline ");
    setTimeout(function () { 
        var vbaMethod = "'{0}'!Save_Forecast_Offline".replace("{0}", objExcel.Workbooks(1).Name);
        if(runMacro(vbaMethod)){
            hideEDraw();
            hideOverlay();
        }
    }, 500);
}

function toggleSliderSidebar() {
    $('#droppable').toggleClass("isCollapsed", 2000);
    $('.referenceSlider').toggleClass("isCollapsed", 2000);
}

(function ($) {
        $(window).load(function () {
            $(function () {
                $("input[name='ChkInternet']").click(function () {
                    if ($("#offlineYes").is(":checked")) {
                        $("#OfflineFile label").removeClass('disabled');
                        $("#OfflineFile #OfflineText").prop("disabled", false);
                    } else {
                        $("#OfflineFile label").addClass('disabled');
                        $("#OfflineFile #OfflineText").attr('disabled', 'disabled');
                    }
                });
            });
            
            
            $("#tab-scroller #botbar").niceScroll({
                cursorfixedheight: 70
            });
        });
})(jQuery);

function toggleFullVisualisation() {
//hideEDraw();
    // $('#divNotes2').removeClass('isCollapsed');
    //$('#divNotes2 .toggleBtn').removeClass('isCollapsed');
    if ($('.expandSpan i').attr('title') == "Maximize") {
        //$('#eDraw').css('display','none');
        $('#eDraw').css('display', 'none');
        if ($('#page-content-wrapper').not(".imgclickenable")) {
            $('#page-content-wrapper').addClass("imgclickenable");
        }
        $('.expandSpan i').removeClass('fa-expand').addClass('fa-compress');
        $('.expandSpan i').attr('title', 'Minimize');
    }
    else {
		//$('#eDraw').css('display','block');
        $('#page-content-wrapper').removeAttr("style");
        $('#page-content-wrapper').removeClass('bg2');
        $('#page-content-wrapper').css('background-image', '');
        $('#eDraw').css('display', 'block');
        $('.expandSpan i').removeClass('fa-compress').addClass('fa-expand');
        $('.expandSpan i').attr('title', 'Maximize');
        updateScreen(true);
    }
    if ($('body').hasClass('nav-sm')) {
        if ($('#divNotes').hasClass('isFullVisualisation')) {
            $('#divNotes').removeClass("isFullVisualisation");
            $('#page-content-wrapper').removeClass("isFullVisualisation");

        }
        $('#divNotes').toggleClass("isForecastFullVisualisation");
        $('#page-content-wrapper').toggleClass("isForecastFullVisualisation");
    }
    else {
        if ($('#divNotes').hasClass('isForecastFullVisualisation'))
        {
            $('#divNotes').removeClass("isForecastFullVisualisation");
            $('#page-content-wrapper').removeClass("isForecastFullVisualisation");
        }

        $('#divNotes').toggleClass("isFullVisualisation");
        $('#page-content-wrapper').toggleClass("isFullVisualisation");
    }

    if($('#divNotes').not('.isFullVisualisation') || $('#divNotes').not('.isForecastFullVisualisation'))
    {
        //    $('#page-content-wrapper').removeClass("isFullVisualisation");

    }
}   
    
function showModal(elementId) {
        if (hideInProgress) {
            showModalId = elementId;
        } else {
            $("#" + elementId).modal("show");
        }
}

function hideModal(elementId) {
        hideInProgress = true;
        $("#" + elementId).on('hidden.bs.modal', hideCompleted);
        $("#" + elementId).modal("hide");
}

function hideCompleted(elementId) {
        hideInProgress = false;
        if (showModalId) {
            showModal(showModalId);
        }
        showModalId = '';
        $(elementId).off('hidden.bs.modal');
}

function hideModalShowOverlay()
    {
        hideModal('chartModal');
        showOverlay("Creating chart. This may take a few moments...");
}

function hideToolsForUserId()
    {
        $('#createid').addClass('disabled');
        $('#createid').removeAttr('onclick');
        $('#openofflinebox').removeAttr('onclick');
        $('#openofflinebox a').addClass('disabled');     
        $('#syncid a').removeAttr('onclick');
        $('#syncid a').addClass('disabled');
        $('#syncid a').removeAttr('data-toggle');
       
    }

function inactiveFunction(e, current) {
        e.preventDefault();
        e.stopPropagation();
        var cloneBeforeDelete = current.parentNode.parentNode.cloneNode(current.parentNode.parentNode)
        var cloneDelete = current.parentNode.parentNode;
        if (current.parentNode.parentNode.parentNode.id == 'droppable') {
            $('#nestable .sidebar-nav-left').append(cloneBeforeDelete);
            $('#nestable i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
            $('#nestable i').attr('title', "Click to remove");
        }
        else {
            $('#droppable').append(cloneBeforeDelete);
            $('#droppable i').removeClass('fa-chevron-down').addClass('fa-chevron-up');
            $('#droppable i').attr('title', "Click to add");
        }

        cloneDelete.removeNode(current.parentNode.parentNode);
        isDragDropEvent = true;
    }

function listOfPermissions()
    {
        var permissionsArr = [];
        permissionsArr.push("Full");
        permissionsArr.push("Edit");
        permissionsArr.push("ReadOnly");
        return permissionsArr;
    }

function autocompleteClick(current)
    {
        var selectedEmail = undefined;
        var flagforShare = false;
        PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
        PHARMAACE.FORECASTAPP.SHARE.listofPermissions(arrofPermissions);
        //if ($('#prdverid tr[class="ShareUsers"]').length > 0) {
        //$('#prdverid tr[class="ShareUsers"]').each(function () {
        if ($('#prdverid tr.innerTrShareForcast').length > 0) {
            $('#prdverid tr.innerTrShareForcast').each(function () {
                var email = ($(this).find('td:nth-child(2)').text()).toLowerCase().trim();
                selectedEmail = (current.innerText).toString();
                var currentEmail = (selectedEmail).toLowerCase().trim();
                var rtrn = email.localeCompare(currentEmail);
                if (rtrn == 0) {
                    flagforShare = true;
                }
            });
        }
        else
            selectedEmail = (current.innerText).toString();
        if (flagforShare == false)
            PHARMAACE.FORECASTAPP.SHARE.validate(undefined, selectedEmail);
    }

function pressed() {
        PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
        PHARMAACE.FORECASTAPP.SHARE.listofPermissions(arrofPermissions);
        PHARMAACE.FORECASTAPP.SHARE.generalizedPressedFun(event);
        /*setTimeout(function () {
        if ($('.ui-autocomplete').last().css("display", "block"))
             $('.ui-autocomplete li').attr('onclick', 'autocompleteClick(this)')
        }, 1000);
        if (event != undefined) {
            if (event.keyCode === 13) {
                event.preventDefault();
                var flagforShare = false;
                $('#prdverid tr.innerTrShareForcast').each(function () {
                    var email = ($(this).find('td:nth-child(2)').text()).toLowerCase().trim();
                    var currentEmail = (event.target.value).toLowerCase().trim();
                    var rtrn = email.localeCompare(currentEmail);
                    if (rtrn == 0) {
                        flagforShare = true;
                    }
                });
                if (flagforShare == false)
                    PHARMAACE.FORECASTAPP.SHARE.validate(event, "");
            }
        }*/
    }

function deleteRemainingIntermediateFiles()
    {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/DeleteIntermediateContainer",  null,
                function (deleteResult) {
                    //be silent
                    var deleteSuccess = deleteResult.success;
                },
                function (deleteResult) {
                    //be silent
                    var deleteFailure = deleteResult;
                });
    }

//$(function () {
    //    $("#inputPassword").keypress(function (e) {
    //        if (e.keyCode == 13) {
    //            alert('You pressed enter!');
    //            return false;
    //        }
    //    });
    //});

$(document).ready(function () {
        // $(document).bind('keypress', pressed);
        $('#waitMessageId').hide();
        deleteRemainingIntermediateFiles();
        $('#menu_toggle').click(function () {
            if ($('body').hasClass('nav-md')) {
                if ($('#divNotes').hasClass('isFullVisualisation'))
                {
                    $('#divNotes').removeClass("isFullVisualisation");
                    $('#page-content-wrapper').removeClass("isFullVisualisation");
                    $('#divNotes').addClass("isForecastFullVisualisation");
                    $('#page-content-wrapper').addClass("isForecastFullVisualisation");
                }
                $('body').removeClass('nav-md').addClass('nav-sm');
                $('.scrollRegion').removeClass('scroll-view');
            } else {
                if ($('#divNotes').hasClass('isForecastFullVisualisation')) {
                    $('#divNotes').removeClass("isForecastFullVisualisation");
                    $('#page-content-wrapper').removeClass("isForecastFullVisualisation");
                    $('#divNotes').addClass("isFullVisualisation");
                    $('#page-content-wrapper').addClass("isFullVisualisation");
                }
                $('body').removeClass('nav-sm').addClass('nav-md');
                $('.scrollRegion').addClass('scroll-view');
            }
        });

        $('#sharebox a.enbdisbl').removeClass("disabled");
        $('#sharebox a.enbdisbl').attr('onclick', 'hideEDraw();');    //enable share on doc ready
        $('#sharebox a.enbdisbl').attr('data-toggle', 'modal');
        $('#syncid a.enbdisbl').removeAttr('data-toggle', 'modal');
        $('#editbox a.enbdisbl').removeAttr('data-toggle', 'modal');
        $('#compareversionid a.enbdisbl').removeAttr('data-toggle', 'modal');
        
        if (accessTypeGT == 3) {
            hideToolsForUserId();
        }

        $('#btnprofile').unbind('click');
        $('#notificationid').unbind('click');
        $('#btnprofile').click(function () {
            hideEDraw();
        })
        $('#notificationid').click(function () {
            hideEDraw();
        })
        if (!loginEmail)
            loginEmail = model.NewsDetails.UserEmail;
        var tooltiptitle = loginEmail;
        
        if (loginEmail) {
            $("#btnprofile").text(firstname + "" + lastname);
            $("#btnprofile").attr("title", tooltiptitle);
        }
        if (!isTrusted)
            return;
        populateControls(true);
        

        populateAttachmentSections();
        PHARMAACE.FORECASTAPP.SHARE.loadAutocompleteData();
        PHARMAACE.FORECASTAPP.SHARE.loadUsers();
       // PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
     
        $(window).on('beforeunload', function (e) {
            if (isCreatedOrRetrieved) {
                //return "This will take you out of the forecast window. Are you sure?";
            if (objExcel != null) {
                try {
                    hideOverlay(true);
                        //kill others
                    if (objExcel.Version > 14.0) {
                            var vbaMethod = "'{0}'!Kill_Background_Excels".replace("{0}", objExcel.Workbooks(1).Name);
                            runMacro(vbaMethod);
                            //kill self
                            if (document.all.OA1.IsOpened && document.all.OA1.IsOpened())
                                document.all.OA1.CloseDoc(false);
                    }
                }
                catch (ex) {
                }
                objExcel = null;
            }
            model = null;
        }
        });

        //$(window).unload(function () {
        //    if (objExcel != null) {
        //        if (document.all.OA1.IsOpened && document.all.OA1.IsOpened())
        //            document.all.OA1.CloseDoc(false);
        //        try {
        //            if (objExcel.Version > 14.0) {
        //                var vbaMethod = "'{0}'!Kill_Background_Excels".replace("{0}", objExcel.Workbooks(1).Name);
        //                objExcel.Run(vbaMethod);
        //            }
        //        }
        //        catch (ex) {
        //            console.log(ex);
        //        }
        //        objExcel = null;
        //    }
        //    model = null;
        //});

        $("#liImages").click(function (e) {
            hideEDraw();
        });
  
        //$("#importimsdataid").click(function (e) {
        //    isImportImsData = true;
        //    var vbaMethod = "'{0}'!Import_IMSData".replace("{0}", objExcel.Workbooks(1).Name);
        //    runMacro(vbaMethod);
        //});

  

        $("#openofflinebox").click(function (e) {
           // hideEDraw();           
            if (objExcel != null) {
                hideEDraw();
                bootbox.dialog({
                    message: "Your existing work will be lost do you want to continue?",
                    title: "",
                    closeButton: true,
                    size: 'small',
                    className: "custom-dialogue",
                    buttons: {
                        success: {
                            label: "Yes",
                            className: "btn-diabox",
                            callback: function (result) {
                                if (result) {
                                    offlineSave = true;
                                    isOfflineFlatFile = true;
                                    setTimeout(function () {
                                        onDocReady(1, "", "", "");
                                    }, 500);
                                }
                            }
                        },
                        main: {
                            label: "No",
                            className: "btn-dacancel",
                            callback: function () {
                                bootbox.hideAll();
                                showEDraw();
                            }
                        }
                    }
                })
            }
            else
            {
                offlineSave = true;
                isOfflineFlatFile = true;
                setTimeout(function () {
                    onDocReady(1, "", "", "");
                }, 500);
            }
        });

      
        $("#closebutton").click(function (e) {
            if (!objExcel)
                return;

            hideEDraw();
            bootbox.dialog({
                message: "Do you want to clear data ?",
                title: "",
                closeButton: true,
                size: 'small',
                className: "custom-dialogue",
                buttons: {
                    success: {
                        label: "Yes",
                        className: "btn-diabox",
                        callback: function (result) {
                            if (result) {
                                var vbaMethod = "'{0}'!Clear_All_Code".replace("{0}", objExcel.Workbooks(1).Name);
                                runMacro(vbaMethod);
                                $('.tollp').text("Version notes not available");
                                $('#version_desc').attr('title', "Version notes not available");
                                $('.vcoment').html('version Comment');
                                removeOptions(document.getElementById('selectProduct'));
                                removeOptions(document.getElementById('selectSKU'));
                                removeOptions(document.getElementById('selectScenario'));
                                createSetAssumptionSections(getSectionDetails());
                                currentForecast = { name: "", version: "", item: {} };
                                disableButton();
                            }
                        }
                    },
                    danger: {
                        label: "No",
                        className: "btn-default",
                        callback: function () {
                            }
                    },
                    main: {
                        label: "Cancel",
                        className: "btn-dacancel",
                        callback: function () {
                            bootbox.hideAll();
                        }
                    }
                }
            });
        });
        if ($('#page-content-wrapper').hasClass("imgclickenable")) {
            $("#page-content-wrapper.imgclickenable").click(function (e) {
                try{
                if (e.target.id == "dropdown1") {
                    e.preventDefault();
                    $('#page-content-wrapper').removeClass("imgclickenable");                    
                    $('#page-content-wrapper').removeClass("imgclickenable");
                    if (isCreatedOrRetrieved)
                    {
                        showEDraw();
                        objExcel.ScreenUpdating = true;
                    }
                }
                }
                catch (e) {
                    //eat exception; this is to keep away automation errors if any (e.g. automation server call error)
                }
            });
        }
    
        $("#saveModal").on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);  // Button that triggered the modal
            var username = loginEmail;
            var dt = new Date();
            dt = dt.toString().replace(/:\d{2} GMT/, " GMT");
            var dateStr = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(dt));
            var html = "Saved By " + username + " on " + dateStr;

            $("#vDesc").attr("placeholder", html);
            $('#vDesc').attr("title", html);
            $('#vDesc').text(html);
        });
        $('input.flat').iCheck({



            checkboxClass: 'icheckbox_flat-aero',
            radioClass: 'iradio_flat-aero'


        });
        $("#shareModal").on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);  
            var titleData = button.data('title'); 
            $(this).find('.modal-title').text(titleData + ' Forecast');
        });
        $("#openModal").on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);  
            var titleData = button.data('title'); 
            $(this).find('.modal-title').text(titleData + ' Form');
        });

        $("#file_attachmentSync").change(function () {
            var fileInputs = document.getElementsByClassName('file_writeSync');
            var tableRef = document.getElementById('sync_users_table').getElementsByTagName('tbody')[0];
            var str = '';
            for (var j = 0; j < fileInputs.length; j++) {
                if (fileInputs[j].files.length == 0)
                    continue;
                if (fileInputs[j].files) {
                    for (i = 0; i < fileInputs[j].files.length; i++) {
                        var path = fileInputs[j].files[i].name;

                        str += '<tr data-index="0" class="">';
                        str += '<td style=""><input type="radio" name="version' + i + '" value="Default" checked="checked" id="defaultVersion"/>' + 'UseMajorVersion' + '</td>';
                        str += '<td style=""><input type="radio" name="version' + i + '" value="Custom" class="minorVersion" />' + 'UseMinorVersion' + '</td>';
                        str += '<td class="bs-checkbox"> ' + path + ' </td>';
                        attachForecastNames[i] = { name: path, file: fileInputs[j].files[i] }

                    }
                }
            }


            tableRef.innerHTML = str;
        });


        $('#btnsync').click(function (e)
        {
            showOverlay("Uploading file...");
            try {
                    isSaveAsForecast = false;
                    var enableMinorVersionSync = false;
                    var minorVersion = [];

                    var username = loginEmail;
                    var dt = new Date();
                    dt = dt.toString().replace(/:\d{2} GMT/, " GMT");
                    descr = "Saved By " + username + " at " + dt;

                    var formdata = new FormData(); //FormData object
                    var isFormDataPopulated = false;
                    var fileInputs = document.getElementsByClassName('file_writeSync');
                    for (var j = 0; j < attachForecastNames.length; j++) {
                        if (!attachForecastNames[j] || attachForecastNames[j].length == 0)
                            continue;
                        formdata.append("modelLocation", model.ModelLocation);
                        formdata.append("Description", descr);
                        formdata.append(attachForecastNames[j].name, attachForecastNames[j].file);
                        var ele = document.getElementsByClassName('minorVersion');
                        if (ele[j].checked) {
                            enableMinorVersionSync = true;
                            minorVersion.push(enableMinorVersionSync);
                        }
                        else {
                            enableMinorVersionSync = false;
                            minorVersion.push(enableMinorVersionSync);
                        }
                        isFormDataPopulated = true;
                    }
                    var MinorString = minorVersion.join(", ");
                    formdata.append("EnableMinorVersionSync", MinorString);
                    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
                    var url = "";
                    if (type == 0)
                    {
                        formdata.append("typeOfTool", type);
                    }
                    else
                    {
                        formdata.append("typeOfTool", type);
                    }

                    if (isFormDataPopulated) {
                        var modelPath;
                        var controllerUrl = "/Forecast/UploadForecastFile";
                        var xhr = new XMLHttpRequest();
                        xhr.open('POST', controllerUrl);
                        xhr.send(formdata);
                        xhr.onreadystatechange = function () {
                            // if (xhr.readyState == 4 && xhr.status == 200) {
                            if (xhr.status == 200) {
                                RefreshModelForSync(false);
                                hideOverlay();
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("File uploaded successfully", '');
                            }
                                //}
                            else {
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not upload ", '');
                            }
                        };
                    }
                    $('table#sync_users_table td').remove();
               
            }
            catch (e) {
                hideOverlay();
            }
        });

        
        $("#TemplateUpload").change(function () {
            var returnValue;
            var val = $(this).val().toLowerCase();
            var fileNamewithExt = val.replace(/^.*[\\\/]/, '');
            var fileNamewithoutExt = fileNamewithExt.split(".");
            var fileName = fileNamewithoutExt[0];
            var fileInputs = document.getElementsByClassName('file_writeforTemplate');
            var localFullPaths = this.value;
            if (localFullPaths) {
                localFullPaths = localFullPaths.split(',');
                $('#Template_local_path').val(localFullPaths);
                $('#Template_local_path').attr("title", localFullPaths);
            }
            localFullPaths = localFullPaths.replaceAll(localFullPaths, "\\", "\\\\");
            localFullPaths = localFullPaths.split("\\");
            localFullPaths = localFullPaths[0].join("\\\\");
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            returnValue = onDocReadyForOfflineOpen(fileName, localFullPaths);
            if (returnValue == true)
            {
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/OpenOfflineForTemplate", { projectName: fileName, type: modelType },
                                   function (result) {
                                       if (result.success) {
                                           output = result.returnVal;
                                          if (output == 0) {
                                               saveNewForecast = true;
                                               createForecastToServer(localFullPaths, fileName);
                                          }
                                             // $('#Prdbox').css("display", "block");
                                              currentForecast.name = fileName;
                                              $('#saveasdesc').attr("placeholder", " ");
                                              $('#saveasdesc').attr("placeholder", currentForecast.name);
                                              $('#saveasdesc').attr("title", currentForecast.name);
                                              createSetAssumptionSections(getSectionDetails());
                                              if (type == 0 || type == 1) {
                                                  populateSelectedList();
                                              }
                                              enableButton();
                                              hideOverlay();
                                         
                                       }
                                       else {
                                           hideOverlay();
                                       }
                                   },
                    function (result) {
                        hideOverlay();
                    });

            }
            else if(returnValue == false)
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Selected file is not a template ", '');
                hideEDraw();
                hideOverlay();
            }

        });
        $('#savebox').click(function () {
            $('#rbCustonVersion').siblings()[0].click();
            document.getElementById('vDesc').value = '';
        });

        $('#sharebox').click(function ()//each time selecting new project gives empty share popup 
        {
            //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery-ui.js", function () {
            populateSharePopup();

            $('#VersionList').selectpicker('deselectAll');
            // $('#shareAllProject').checked = false;
            // $('#prdverid tr').remove();
            $('#prdverid tr.innerTrShareForcast').each(function () {
                $(this).remove();
            });

            //});

        });

        $("#file_attachment").change(function () {
            fileCheckedFlag = [];
            var val = $(this).val().toLowerCase();
            var ext = val.substr(val.lastIndexOf('.') + 1);
            var lblError = $("#lblError");
            //var validFileType = PHARMAACE.FORECASTAPP.FILETYPE(ext);
            if (PHARMAACE.FORECASTAPP.FILETYPE.indexOf(ext) == -1) {
                $(this).val('');
                lblError.html('Sorry, this file type is not permitted for security reasons.', "");
                return;
            }
            else {
                lblError.html('');
            }
            var sectionIndices = getSelectedSectionIndexForAttachment();
            var fileInputs = document.getElementsByClassName('file_write');
            var localFullPaths = this.value;
            if (localFullPaths) {
                localFullPaths = localFullPaths.split(',');
                $('#attachments_local_path').val(localFullPaths);
                $('#attachments_local_path').attr("title", localFullPaths);
            }
            var prodIndex = getProductIndex(true);
            var sectionCount = $('.section_note_write').length;
            var startIndex = (prodIndex - 1) * sectionCount;
            for (var j = 0; j < fileInputs.length; j++) {
                if (fileInputs[j].files.length == 0)
                    continue;
                for (var k = 0; k < sectionIndices.length; k++) {
                    var sectionIndex = startIndex + sectionIndices[k];
                    var files = attachmentMap[sectionIndex];
                    var existingCount = 0;
                    if (files)
                        existingCount = files.length;
                    else
                        attachmentMap[sectionIndex] = [];
                    if (fileInputs[j].files) {
                        var notValidFileSize = PHARMAACE.FORECASTAPP.UTILITY.checkFileSize(fileInputs[j].files);
                        if (notValidFileSize) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to attach : file size exceeded", "");
                             return;
                        }
                        else {
                            for (i = 0; i < fileInputs[j].files.length; i++) {
                                var path = fileInputs[j].files[i].name;
                                if (k == 0)
                                    attachmentMap[sectionIndex][existingCount + i] = { name: path, file: fileInputs[j].files[i], source: "", localFullPath: $.trim(localFullPaths[i]) };
                                else
                                    attachmentMap[sectionIndex][existingCount + i] = { name: path, repeat: { section: startIndex + sectionIndices[0], file: i }, source: "", localFullPath: attachmentMap[startIndex + sectionIndices[0]][i].localFullPath };
                            }
                        }
                       
                    }
                }
            }
        });
        
        loadAssumptionSections();
    });

function cleanFileList() {
    hideEDraw();
    $("#file_attachment").val('');
    $('#attachments_local_path').val('');
    $('#lblError').text('');
}
function updateAttachmentIcons() {
            var ele = document.getElementsByClassName('attachment_icons');
            var attachmentSectionCount = $('#attachment_sections')[0].options.length;
            var prodIndex = getProductIndex(true);
            var sectionCount = $('.section_note_write').length;
            var startIndex = (prodIndex - 1) * sectionCount;
            for (var i = startIndex; i < startIndex + attachmentSectionCount; i++) {
                var str = "";
                if (attachmentMap[i]) {
                    for (var j = 0; j < attachmentMap[i].length; j++) {
                        var name = attachmentMap[i][j].name;
                        //var url = attachmentMap[i][j].source;
                        var url = attachmentMap[i][j].url;
                        var arr = name.split('.');
                        var ext = arr[arr.length - 1];
                        var imageLink = PHARMAACE.FORECASTAPP.UTILITY.getImageForFileType(ext);
                        if (url && url.length > 0)
                            str += "<li><a href='/Forecast/DownloadAttachmentFromDb?streamId=" + url + "&sink=" + name + "' target='_blank'><img src='" + imageLink + "' class='img-thumbnail' style='height:32px;' title='" + name + "'></a><div style='position:absolute;top:-4.32px;right:-3.9px;'><a href='#' onclick='removeAttachment(" + i + ", " + "$(this));'><span class='tag label label-default' style='background:none;color:red !important; font-size:10px !important;'>X</span></a></div></li>";
                        else
                            str += "<li><a href='" + attachmentMap[i][j].localFullPath + "' target='_blank'><img src='" + imageLink + "' class='img-thumbnail' style='height:32px;' title='" + name + "'></a><div style='position:absolute;top:-4.32px;right:-3.9px;'><a href='#' onclick='removeAttachment(" + i + ", " + "$(this));'><span class='tag label label-default' style='background:none;color:red !important; font-size:10px !important;'>X</span></a></div></li>";
                    }
                    ele[i - startIndex].innerHTML = str;
                }
            }
            //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/bootstrap/bootstrap-multiselect.js", function () {
                $('#attachment_sections').multiselect('deselectAll', false);
                $('#attachment_sections').multiselect('select', []);
            //});
}

function updateAttachmentIconsWithValidation() {
    hideEDraw();
    if ($('.multiselect-selected-text').html() != "None selected") {
        if ($('#attachments_local_path').val() != "" && $('#attachments_local_path').val() != null) {
            var ele = document.getElementsByClassName('attachment_icons');
            var attachmentSectionCount = $('#attachment_sections')[0].options.length;
            var prodIndex = getProductIndex(true);
            var sectionCount = $('.section_note_write').length;
            var startIndex = (prodIndex - 1) * sectionCount;
            for (var i = startIndex; i < startIndex + attachmentSectionCount; i++) {
                var str = "";
                if (attachmentMap[i]) {
                    for (var j = 0; j < attachmentMap[i].length; j++) {
                        var name = attachmentMap[i][j].name;
                        //var url = attachmentMap[i][j].source;
                        var url = attachmentMap[i][j].url;
                        var arr = name.split('.');
                        var ext = arr[arr.length - 1];
                        var imageLink = PHARMAACE.FORECASTAPP.UTILITY.getImageForFileType(ext);
                        if (url && url.length > 0)
                            str += "<li><a href='/Forecast/DownloadAttachmentFromDb?streamId=" + url + "&sink=" + name + "' target='_blank'><img src='" + imageLink + "' class='img-thumbnail' style='height:32px;' title='" + name + "'></a><div style='position:absolute;top:-4.32px;right:-3.9px;'><a href='#' onclick='removeAttachment(" + i + ", " + "$(this));'><span class='tag label label-default' style='background:none;color:red !important; font-size:10px !important;'>X</span></a></div></li>";
                        else
                            str += "<li><a href='" + attachmentMap[i][j].localFullPath + "' target='_blank'><img src='" + imageLink + "' class='img-thumbnail' style='height:32px;' title='" + name + "'></a><div style='position:absolute;top:-4.32px;right:-3.9px;'><a href='#' onclick='removeAttachment(" + i + ", " + "$(this));'><span class='tag label label-default' style='background:none;color:red !important; font-size:10px !important;'>X</span></a></div></li>";
                    }
                    ele[i - startIndex].innerHTML = str;
                }
            }
            //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/bootstrap/bootstrap-multiselect.js", function () {
                $('#attachment_sections').multiselect('deselectAll', false);
                $('#attachment_sections').multiselect('select', []);
            //});
            hideModal('attachmentsModal');
            showEDraw();
        }
        else {

            PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select attachment...", "")
        }
    }
    else {

        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select section...", "")
    }
}

function removeAttachment(i, closingSpan) {
    hideEDraw();
    bootbox.dialog({
        message: "Do you want to remove the attachment?",
        title: "",
        closeButton: true,
        size: 'small',
        className: "custom-dialogue",
        buttons: {
            success: {
                label: "Yes",
                className: "btn-diabox",
                callback: function (result) {
                    if (result) {
                        var j = $('.attachment_icons:eq(' + i + ')>li>div>a').index(closingSpan);
                        closingSpan.parent().parent().remove();
                        if (attachmentMap[i] && attachmentMap[i].length > j)
                            attachmentMap[i].splice(j, 1);
                    }
                    showEDraw();
                }
            },            
            main: {
                label: "No",
                className: "btn-dacancel",
                callback: function () {
                    bootbox.hideAll();
                    showEDraw();
                }
            }
        }
    });
}

function clearAllAttachmentsAndAssumptions() {
    $('.attachment_icons>li').remove();
    $('.editable-div').text('');
}

function uploadAttachments(postKeyValues, callback) {
    var formdata = new FormData(); //FormData object
    if (postKeyValues) {
        for (var i = 0; i < postKeyValues.length; i++)
            formdata.append(postKeyValues[i].key, postKeyValues[i].value);
    }
    var isFormDataPopulated = false;
    var fileInputs = document.getElementsByClassName('file_write');
    var attCount = 0;
    for (var j = 0; j < attachmentMap.length; j++) {
        if (!attachmentMap[j] || attachmentMap[j].length == 0)
            continue;
        for (i = 0; i < attachmentMap[j].length; i++) {
            if (!attachmentMap[j][i].repeat) {
                formdata.append(attachmentMap[j][i].name, attachmentMap[j][i].file);
                if (attachmentMap[j][i].url == undefined)
                    attachmentMap[j][i].url = attCount++;
                isFormDataPopulated = true;
            }
        }
    }

    var projectName = currentForecast.name;
    var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var argumentsArray = [];
    //if (modelType == 0 || modelType == 1) {  //  acthar
    if (offlineSave == false) {
        getAssumptionsForSections();
        mapAttachmentsBeforeSave();
                }
    //}

    formdata.append("assumptions", JSON.stringify({ 'assumptions': assumptionSet }));

    PHARMAACE.FORECASTAPP.SERVICE.postFormData("/Forecast/SaveForecast", formdata, function (result) {
        try {
            //process attachments
            if (result.success == true) {
                getAssumptions(false);

                //process assumptions
                //PHARMAACE.FORECASTAPP.UTILITY.popalert(projectName + " " + result.Version + " saved successfully", ''); 
                if (!saveNewForecast) {
                    argumentsArray.push(projectName, result.Version, " saved successfully");
                    currentForecast.version = result.Version;
                    // argumentsArray.push(result.Version);
                    handleSaveError(13, argumentsArray)
                }
                currentForecast.version = result.Version;
                //currentForecast.item = getItemInModelByNameAndVersion(projectName, currentForecast.version);
                //updateProperties();
                tooltiponHover();
                getAssumptions(false);
                offlineSave = false;
                //callback
                if (callback)
                    callback();
            }
            else {
                handleSaveError(result.error);
            }
            }
        catch (e) { }
        hideOverlay();
    },
    function (error) {
        hideOverlay();
    });

        }

function handleSaveError(errorCode, argumentsArray) {
    var errorMsg = "";
    if (argumentsArray)
    {
        for (var i = 0; i < argumentsArray.length; i++) {
            errorMsg += argumentsArray[i] + " ";
        }
    }
    switch (errorCode) {
        case 0: //unknown error
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save forecast", "");
            break;
        case 1: //success, ideally this case will never hit via this particular function
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Saved forecast successfully", "");
            break;
        case 3: //tried sharing with the creator/own
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Can't share forecast with its creator", "");
            break;
        case 4: //user has higher permission already
            PHARMAACE.FORECASTAPP.UTILITY.popalert("User already has higher permission for the forecast version.", "");
            break;
        case 7: //there was no flat file for caching
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not find cached forecast data", "");
            break;
        case 8: //action method SaveTempFile did not get any forecast file to store temporarily
            PHARMAACE.FORECASTAPP.UTILITY.popalert("There was a problem receiving forecast data", "");
            break;
        case 9: //project already exists
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Project name already exists", "");
            break;
        case 10: //file type unacceptable, invalid file extension
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Invalid data format", "");
            break;
        case 11: //section preferences could not be set
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed setting up section preferences", "");
            break;
        case 12: //attachment type unacceptable, invalid file extension
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Invalid attachment type", "");
            break;
        case 13:
            if (errorMsg)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("{0}".replace("{0}", errorMsg));
            break;
    }
}

function populateAttachmentSections() {
    // var sections = getSectionDetails();
    var sections = getSectionDetailsForAttchment();
    for (var i = 0; i < sections.length; i++) {
        $('#attachment_sections').append("<option value=" + i + ">" + sections[i].name + "</option>");
    }

    //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/bootstrap/bootstrap-multiselect.js", function () {
    $('#attachment_sections').multiselect();
    //});
}

function CloseDoc() {
    if (document.OA1.IsOpened) {
        document.all.OA1.ExitOfficeApp();
    }
}

function clearTempFiles(oa, objEx) {
    objEx.EnableEvents = false;
    for (var i = 1; i <= objEx.Workbooks.Count; i++) {
        var isTempFile = objEx.Workbooks(i).Name.endsWith(".tmp");
        if (!isTempFile)
            isTempFile = objEx.Workbooks(i).Name.indexOf("oatmp") > -1;
        if (isTempFile) {
            objEx.Workbooks(i).Close(false);
        }
    }
    objEx.Workbooks(1).Activate();
}

function killBackgroundExcels() {
    //kill any background process if exists
    try{
        if (!backgroundExcelKilled) {
            var backgroundExcelKiller = "'{0}'!Kill_Selected_Background_Excels".replace("{0}", objExcel.Workbooks(1).Name);
            objExcel.Run(backgroundExcelKiller);
        }
    }
    catch (e) {
        //eat at this point as we want on error resume next kind of behavior here 
    }
    backgroundExcelKilled = true;
}


function runMacro(vbaMethod, oa, objEx) {
    if (!objExcel)
        return;

    if (!oa) {
        oa = document.all.OA1;
        objEx = objExcel;
    }
    oa.focus();
    oa.click();
    var runResult = true;
    try {
        killBackgroundExcels();
        runResult = objEx.Run(vbaMethod);
        //check if excel is responding
        //if (!isExcelResponding())
        //    return false;
        //stopUpdateScreen();
    }
    catch (e) {
        runResult = false;
        hideOverlay(true);
        bootbox.dialog({
            message: "There was some problem in executing the model."
        });
    }
    oa.focus();
    oa.click();
    if (runResult == undefined || runResult == null)
        runResult = true;
    return runResult;
}

function getSelectedSectionIndexForAttachment() {
    var select1 = document.getElementById('attachment_sections');
    var selected1 = [];
    for (var i = 0; i < select1.options.length; i++) {
        if (select1.options[i].selected) selected1.push(select1.options[i].index);
    }
    return selected1;
}

function fillSharePopup()
{    
    //var forecastList = $('#projectList');
    //forecastList.children().remove();
   var selectforecastOptions = '';
    if (model.ForecastDetails && model.ForecastDetails.ItemList) {
        var lst = model.ForecastDetails.ItemList;
        for (var i = 0; i < lst.length; i++) {
            var item = lst[i];
            if (item.LatestVersion.Label == "V0.0")
                continue;
            if (item.Forecast == currentForecast.name) {
                $('#projectList').append('<option selected>' + item.Forecast + '</option>');
            }
            else {
                $('#projectList').append('<option>' + item.Forecast + '</option>');
            }
           
        }
      
    }
    $("#projectList").selectpicker();
    onForecastUpdateForShare();
}

    function onForecastUpdateForShare() {
        updateVersionsForShare();
    }
   
    function unshareForecast(unshareId)
    {
        unshareDocumentWithSelectedUsers(unshareId);
    }
    function unshareDocumentWithSelectedUsers(unShareUserId) {
        var unShareUserArray = [];
        var ele = document.getElementById('projectList');
        var projectName = ele.options[ele.selectedIndex].value;
        var ele1 = document.getElementById('VersionList');
        var version = ele1.options[ele1.selectedIndex].value;
        var unShareUserForecast = { UnShareUserID: unShareUserId, projectName: projectName, Version: version, loggedInUserId: getLoggedInUserId() };
        unShareUserArray.push(unShareUserForecast);
        var currentUserList = PHARMAACE.FORECASTAPP.SHARE.currentAddedUserShareList
        var removedUserFromList = false;
        for (var i = 0; i < currentUserList.length; i++) {
            if (currentUserList[i] == unShareUserId) {
                $('#prdverid tbody tr[unShareId=' + unShareUserId + ']').remove();
                removedUserFromList = true;
                PHARMAACE.FORECASTAPP.SHARE.currentAddedUserShareList.pop(i);
                break;
            }
        }
        if (!removedUserFromList) {
            var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            var url = "";
            url = "/Forecast/UnShareDocument";
            var postData = JSON.stringify({ "UserForecastForUnshare": unShareUserArray, "type": type });
            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData(url, postData,
            function (result) {
                if (result.success) {
                    refreshModelEverytime();
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully unshared " + projectName + " " + version, '');
                    $('#prdverid tbody tr[unShareId=' + unShareUserId + ']').remove();
                    hideEDraw();
                }
                else {
                    if (result.errors == "NOT_FOUND")//if want to unshare currently added contact
                        // $('#prdverid tbody tr[unShareId=' + unShareUserId + ']').remove();
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("You did not have access to unshare", '');
                    else
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Unsharing document failed: " + result.errors.join(), '');
                    hideEDraw();
                }

            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Unsharing document failed! " + result.responseText, '');
            });
        }

    }

    //function populateTooltipForDropDown(i) {
    //    $('#getpermission' + i).selectpicker();
    //    $("#getpermission" + i + " option").each(function (index) {
    //        var fortitle = $(this).attr('data-title');

    //        $('#dropdownOfShare' + i + ' li').eq(index).attr("data-toggle", "tooltip");
    //        //$(this).attr("title", fortitle);
    //        $('#dropdownOfShare' + i + ' li').eq(index).attr("title", fortitle);

    //    });
    //    $('#dropdownOfShare' + i + '  [data-toggle="tooltip"]').tooltip({
    //        placement: 'right'
    //    });
    //}
    function showSharePermissions()
    {
        var str = '';
        // var str1 = "";
        var str1 = $('#prdverid tbody');
        PHARMAACE.FORECASTAPP.SHARE.checkShareType(shareType);
        PHARMAACE.FORECASTAPP.SHARE.listofPermissions(arrofPermissions);
        var ele = document.getElementById('projectList');
        var itemIndexInModel = ele.options[ele.selectedIndex].value;
        var ele1 = document.getElementById('VersionList');
        var tableRef = document.getElementById('prdverid').getElementsByTagName('tbody')[0];
        if (ele1.selectedIndex != -1)
        {
            var version = ele1.options[ele1.selectedIndex].value;
          //  RefreshModel(undefined, undefined);
        var item = getItemInModelByNameAndVersion(itemIndexInModel, version);        
            //tableRef.innerHTML = ""; 
        $('#prdverid tr.innerTrShareForcast').each(function () {
            $(this).remove();
        });
       // str1 += '<tr><td colspan="5" style="padding-left:0px; padding-right:0px; padding-bottom:0px;">';
        //str1 += '<input type="text" class="form-control ui-widget" id="inputPassword"  style="width:100%;">';
        //str1 += '</td></tr>';
        if (item)
        {
                if (item.Access.SharedAccess && item.Access.SharedAccess.length > 0) {
                    var count = PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser;
                    for (var i = 0; i < item.Access.SharedAccess.length; i++) {
                        var flagForLoggedinUser = false;
                        if (item.Access.SharedAccess[i].SharedWith.Email != null) {
                            if (((item.Access.SharedAccess[i].SharedWith.Email).toLowerCase()).localeCompare(loginEmail.toLowerCase()) == 0)
                                flagForLoggedinUser = true;
                        }
                        if(!flagForLoggedinUser){
                            if (item.Access.Creator.UserId != item.Access.SharedAccess[i].SharedWith.UserId) {
                                count = PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser;
                                str += '<tr class="ShareUsers innerTrShareForcast" data-index="0" unShareId=' + item.Access.SharedAccess[i].SharedWith.UserId + ' class="ShareUsers">';
                                str += '<td class="bs-checkbox"> {0} {1} </td>'.replace("{0}", item.Access.SharedAccess[i].SharedWith.FirstName).replace("{1}", item.Access.SharedAccess[i].SharedWith.LastName);
                                str += '<td id="shareuseremail" style = ""> ' + item.Access.SharedAccess[i].SharedWith.Email + '</td>';
                                str += ' <td style="display:none;" highligthId=' + item.Access.SharedAccess[i].SharedWith.UserId + ' class="divOne">' + item.Access.SharedAccess[i].SharedWith.UserId + '</td>';
                                str += '<td><div id="dropdownOfShare' + count + '"><select type="text" id ="getpermission' + count + '" class="selectpicker form-control multiselect multiselect-icon" >';
                                PHARMAACE.FORECASTAPP.SHARE.countForSharePopupRecentUser++;
                                str += PHARMAACE.FORECASTAPP.SHARE.ShowSharePermission(item.Access.SharedAccess[i].AuthorizationLevel, "");
                                str += '</select></div>';
                                str += '</td>';
                                str += '<td class="unshareicon"><i class="fa fa-times" aria-hidden="true" title="Unshare" style="cursor:pointer;" onclick="unshareForecast(' + item.Access.SharedAccess[i].SharedWith.UserId + ');"></i></td>';
                                str += '</tr>';
                            }
                        }
                    }
                }
         }
     }
        str1.append(str);
        for (var p = 0; p <= count; p++) {
           // populateTooltipForDropDown(p);
            PHARMAACE.FORECASTAPP.SHARE.TooltipForTr(p);
            // $('#getpermission' + p + '').selectpicker();
        }
        //tableRef.innerHTML = str + str1;
        //$('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });
        //hideEDraw();
        //hideOverlay();
    }

    function refreshModelEverytime()
    {
        isRefreshedModel = true;
        RefreshModel(null, null);
        hideEDraw();
    }
    function updateVersionsForShare() {
        $('#VersionList').selectpicker('destroy');
       
        // $('#prdverid tr').remove();
        $('#prdverid tr.innerTrShareForcast').each(function () {
            $(this).remove();
        });
        var tableRef = document.getElementById('prdverid').getElementsByTagName('tbody')[0];
        //tableRef.innerHTML = "";
        var item = getSelectedForecastForShare();
        removeOptions(document.getElementById("VersionList"))
        if (item) {
            if (item.Versions) {
                for (var j = 0; j < item.Versions.length ; j++) {
                    var version = "";
                    version = item.Versions[j].Label.split(".")

                    if (version.length > 1)
                    $('#VersionList').append("<option>" + item.Versions[j].Label + "</option>");

                    if (item.Versions[j].PreDrafts) {
                        for (var k = 0; k < item.Versions[j].PreDrafts.length ; k++) {
                            $('#VersionList').append("<option>" + item.Versions[j].PreDrafts[k].Label + "</option>");
                        }
                    }
                }

            }
            $("#VersionList").selectpicker();
            selectVersionPicker();
            updateAutocompleteUsersData(item);
            clearCurrentAddedUserList();
        }
       // dynamicInputTextboxShare();//if not selected version directly select all project to enable input textbox to add new user
    }
    function clearCurrentAddedUserList() {
        for (var i = 0; i < PHARMAACE.FORECASTAPP.SHARE.currentAddedUserShareList.length; i++) {
            PHARMAACE.FORECASTAPP.SHARE.currentAddedUserShareList.pop();
        }
    }
    function updateAutocompleteUsersData(item) {
        var userData = PHARMAACE.FORECASTAPP.SHARE.autocompleteListData;
        var finalUserData = [];
        for(i=0;i<userData.length;i++)//skip logged in user and creator from list
        {
            if (((userData[i].value.toLowerCase()).localeCompare(loginEmail.toLowerCase()) == 0) || ((item.LatestVersion.Access.Creator.Email.toLowerCase()).localeCompare(userData[i].value.toLowerCase()) == 0))
                continue;
            finalUserData.push(userData[i]);
        }
        
        PHARMAACE.FORECASTAPP.SHARE.autocompleteListData = finalUserData;
    }

    function buildUserForecastMappingForShare()
    {
        userForecastMappingForShare = [];
        var isAllProjectShare = false;
        var version = "";
        $('#prdverid tr.innerTrShareForcast').each(function () {
            var userId = $(this).find('td:nth-child(3)').text();
            var name = $(this).find('td:nth-child(1)').text();
            var email = $(this).find('td:nth-child(2)').text();
            var authLevel = $(this).find('select option:selected').val();
            var ele = document.getElementById('projectList');
            var projectName = ele.options[ele.selectedIndex].value;
            /*if ($("#shareAllProject").is(':checked'))
            {
                version = null;
            }*/
            if($('button[data-id="VersionList"]').first()[0].innerText=="Nothing selected ")
            {
                version = null;
            }
            else
            {
                 version = $("#VersionList option:selected").val();
            }
            var shareComment = "";      
            // userForecastMappingForShare.push(buildUserForecastToShare(userId, authLevel, shareComment, projectName, version));
            userForecastMappingForShare.push(buildUserForecastToShare(userId, authLevel, shareComment, projectName, version, email, LoggedFirstname, LoggedLastname));
                //userArrayShared.push(refreshUserForecastShared(userId, authLevel, name, email));

        });
    }

    function selectVersionPicker()
    {
        //$(function () {
        var e = window.event;
        e.stopPropagation();
        e.preventDefault();
            var target = false;
            $('#VersionListid .bs-deselect-all').click(function () {
                $('#VersionListid .inner').removeClass('fornotclick');
            });
            $('#VersionListid .bs-select-all').click(function () {
                $('[data-id=VersionList] .filter-options').remove();
                $('[data-id=VersionList] .filter-option').css("display", "block");
                $('#VersionListid .inner').addClass('fornotclick');
            });
            $('#VersionListid .inner li').bind({
                container: 'body'
            }).click(function (evt) {
                target = $(this);
                if ($('#VersionListid .inner.fornotclick').length == 0) {
                    if ($('#VersionListid .inner li.selected').length == 1) {
                        var selectedText = $(this).find('.text').html();
                        $('[data-id=VersionList] .filter-option').css("display", "none");
                        $('[data-id=VersionList] .filter-options').remove();
                        $('[data-id=VersionList]').prepend('<span class="filter-options pull-left">' + selectedText + '</span>');
                        $(this).siblings().removeClass('selected');  //except clicked li    
                        setTimeout(function () {
                            target.attr('class', 'selected');
                        }, 100);
                    }
                }
                else {
                    return false;
                }
            });
       // });
    }
    
function populateControls(updateFeed) {
    var forecastList = $('#selectForecast');
    forecastList.children().remove();
    $('<input type="text"  class="form-control search" style="z-index:999999;display:none; position:absolute; top:33px; width:140px; left:4px;" id="importSerach"   >').insertBefore('#selectForecast');
     selectforecastOptions = '';
    //selectforecastOptions = '<form id="forecastid"><div class="form-group"><input type="text" class="form-control" id="importSerach" onkeyup="searchFromList(event)" placeholder="Search from below..." ></div></form>';

    if (model.ForecastDetails && model.ForecastDetails.ItemList) {
        var lst = model.ForecastDetails.ItemList;
        //var latestVersion = "";
        for (var i = 0; i < lst.length; i++) {
            var item = lst[i];
            if (!item.Versions || item.Versions.length == 0)
                continue;
            var firstLevelItem = item.Versions[0];
            if (item.Versions[0].IsMock == true)
                firstLevelItem = firstLevelItem.PreDrafts[0];
            selectforecastOptions += addVersionListItem(item.Forecast, firstLevelItem, item.LatestVersion, 1);
            if (item.Versions) {
                if (item.Versions[0].Label != "V0.0")
                selectforecastOptions += '<ul class="dropdown-menu secondlevel">';
                for (var firstLevelVersionIndex = 0; firstLevelVersionIndex < item.Versions.length; firstLevelVersionIndex++) {                    
                    if (item.Versions[firstLevelVersionIndex].PreDrafts) {
                        var preDraftCount = item.Versions[firstLevelVersionIndex].PreDrafts.length;
                        if (preDraftCount > 0) {
                            selectforecastOptions += addVersionListItem(item.Forecast, item.Versions[firstLevelVersionIndex], item.LatestVersion, 2, true)
                            selectforecastOptions += '<ul class="dropdown-menu thirdlevel">';
                            for (var preDraftIndex = 0; preDraftIndex < preDraftCount; preDraftIndex++) {
                                selectforecastOptions += addVersionListItem(item.Forecast, item.Versions[firstLevelVersionIndex].PreDrafts[preDraftIndex], item.LatestVersion, 3, true)
                                selectforecastOptions += '</li>';
                            }
                   
                            selectforecastOptions += '</ul>';
                            selectforecastOptions += '</li>';
                           

                        }
                    }
                    else {
                        //valueLabel will be empty for 0.0
                        if (item.Versions[0].Label != "V0.0") {
                            selectforecastOptions += addVersionListItem(item.Forecast, item.Versions[firstLevelVersionIndex], item.LatestVersion, 2, true);
                            selectforecastOptions += '</li>';
                        }
                        
                    }
                }
                if (item.Versions[0].Label != "V0.0")
                selectforecastOptions += '</ul>';
               
            }
            if (roleId == 3) {
                selectforecastOptions += '<div style="top: 6px; right: 21px; position: absolute; cursor: pointer;"><i class="fa fa-trash fa-1 fa-white" aria-hidden="true" onclick="gFRemoveProjectDetailsMsg(\'' + item.Forecast + '\');" data-toggle="tooltip" title="Delete Forecast"></i>';
                selectforecastOptions += '<a href="#" data-toggle="modal" data-target="#copyModal"><i class="fa fa-files-o fa-1 fa-white" aria-hidden="true" onclick="copySelectedForecast(\'' + item.Forecast + '\');" style="margin-left:6px;"></i></a></div>'

            }
            selectforecastOptions += '</li>';
            selectforecastOptions = selectforecastOptions.replaceAll("{0}", item.Forecast);
            
        }
        forecastList.append(selectforecastOptions);
    }
    tooltiponHover();
    
    adjustLongListScrolling($('#ImportParent'));
    $('.forecast-version').click(function (e) {
        e.stopPropagation();
        if ($(this).attr('mock') == "true")
        {
            //$(this).removeAttr('onclick');
            //$(this).css({ 'cursor': "default" });
            //bootbox.dialog({
            //    message: 'This major version is not published/shared wth you. For drafts please use the minor versions.'
            //});
            editForecast(this);
        }
        else
            editForecast(this);
    });
    //$('#selectForecast').prepend('<form id="forecastid" style=" position:absolute; top:0px; width:100%; "><div class="form-group"><input type="text" class="form-control" id="importSerach" onkeyup="searchFromList(event)" placeholder="Search from below..." ></div></form>');
    var monkeyList = new List('ImportParent', {
        valueNames: ['srch_paging'],
        page: 20,
        pagination: true
    });

    $('.pagination').removeAttr('style');
    keydownFunctioality();
    
}

    function tooltiponHover() {
        $("#selectForecast>li").tooltip({
            html: true,
            placement: 'left',
        });
        $('#selectForecast .secondlevel>li').tooltip({

            html: true,
            placement: 'left',
        });
        $('#selectForecast .thirdlevel>li').tooltip({

            html: true,
            placement: 'left',
        });
        $("#selectForecast>li[data-toggle=tooltip]").hover(function () {
            //PHARMAACE.FORECASTAPP.UTILITY.removejscssfile("../../Scripts/lib/jquery/jquery-ui.js", "js");
            var str = getPropertiesString($(this).attr('name'), $(this).attr('value'));
            $($(this).tooltip({
                html: true,
                placement: 'left',
            })[0]).attr('data-original-title', str);
        });
        $("#selectForecast .secondlevel>li[data-toggle=tooltip]").hover(function () {
           // PHARMAACE.FORECASTAPP.UTILITY.removejscssfile("../../Scripts/lib/jquery/jquery-ui.js", "js");
            $("#selectForecast> .tooltip").remove();
            $("#selectForecast> .tooltip").tooltip('hide');
            var FirstLiWidth = $("#selectForecast>li:first").width();
            var tooltipWidth = $("#selectForecast .secondlevel> .tooltip").width();
            $('#selectForecast .secondlevel .tooltip').css('left', -FirstLiWidth - tooltipWidth - 10 + 'px')
        });
        $("#selectForecast .thirdlevel>li[data-toggle=tooltip]").hover(function () {
            // PHARMAACE.FORECASTAPP.UTILITY.removejscssfile("../../Scripts/lib/jquery/jquery-ui.js", "js");
            //$("#selectForecast .secondlevel>li .tooltip").remove();
            $("#selectForecast> .tooltip").remove();
            $("#selectForecast .secondlevel>li").tooltip('hide');
            var SecondLiWidth = $("#selectForecast .secondlevel>li:first").width();
            var FirstLiWidth = $("#selectForecast>li:first").width();
            //var tooltipWidth = $("#selectForecast .secondlevel> .tooltip").width();
            //var finalwidth = FirstLiWidth + SecondLiWidth + tooltipWidth + 68;
            var finalwidth = FirstLiWidth + SecondLiWidth + 200 + 68;
            $('#selectForecast .thirdlevel .tooltip').css('left', -finalwidth + 'px');
        });
    }

function keydownFunctioality() {
    var keylevel = false;
    var keylevelLast = false;
    var whenkeydown = 1;
    var whenkeylevelLast = 1;
    var el = document.getElementById("ImportParent");
    if (el)
    {
        el.addEventListener("keydown", function (e) {
            if (e.target.id == 'importSerach')
                return;
            e.preventDefault();
            e.stopPropagation();
            if (e.keyCode == 38 || e.keyCode == 40 || e.keyCode == 39 || e.keyCode == 37 || e.keyCode == 13) {
                var key = e.keyCode;
                if (key == 37) {
                    keylevelLast = false;
                    whenkeylevelLast = 1;
                    $("#selectForecast").find('li.hovered').last().parent().removeAttr('style');
                    $("#selectForecast").find('li.hovered').last().parent().hide();
                    $("#selectForecast").find('li.hovered').last().removeClass('hovered');
                    if ($("#selectForecast").find('li.hovered').length == 1) {
                        keylevel = false;
                        keylevelLast = false;
                        whenkeydown = 1;

                    }
                    if ($("#selectForecast").find('li.hovered').length == 2) {
                        keylevelLast = false;
                        keylevel = true;
                        whenkeylevelLast = 1;
                    }
                }
                if (key == 40) {
                    if (keylevel == true) {
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").next('li:eq(0)').addClass('hovered');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").prev().removeClass('hovered');
                        $('.dropdown-submenu .dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").children('.dropdown-menu').first().css('display', 'block');
                    }
                    else if (keylevelLast == true) {
                        $("#selectForecast li.hovered .dropdown-menu li.hovered .dropdown-menu li.hovered").next('li:eq(0)').addClass('hovered');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered .dropdown-menu li.hovered").prev().removeClass('hovered');
                    }
                    else {
                        if (!$("#selectForecast li").hasClass("hovered"))
                            $("#selectForecast").find('li').first().addClass('hovered');
                        else
                            $("#selectForecast li.hovered").next('li:eq(0)').addClass('hovered');
                        $("#selectForecast li.hovered").prev().removeClass('hovered');
                        $('.dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered").children('.dropdown-menu').first().css('display', 'block');
                    }

                    var maxHeight = 500;
                    var $container = $("#selectForecast").find('li.hovered').last().parent().parent();
                    //$container[0].onmouseover();
                    var $list = $container.children('ul').first();
                    var height = $list.height() * 1.1;
                    var multiplier = height / maxHeight;
                    $container.data("origHeight", $container.height());
                    // make sure dropdown appears directly below parent list item    
                    $list
                        .show()
                        .css({
                            // paddingTop: $container.data("origHeight")
                        });
                    // don't do any animation if list shorter than max
                    if (multiplier > 1) {

                        var $container1 = $("#selectForecast").find('li.hovered').last();
                        var offset = $container1.offset();
                        var center = $list.height();
                        var relativeY = (offset.top) - ($container.data("origHeight") * multiplier);
                        //if ($list)

                        if (relativeY > maxHeight / 3) {
                            if (keylevelLast == true) {
                                $list.css("top", -$container.data("origHeight") * whenkeylevelLast);

                            }
                            else {
                                $list.css("top", -$container.data("origHeight") * whenkeydown + maxHeight / 3);
                            }
                        }
                    }
                    //if (!$list.find('li.hovered').last()) {

                    if (keylevelLast == true && $container.data("origHeight") * whenkeylevelLast * 1.07 < center)
                        whenkeylevelLast++;
                    else if ($container.data("origHeight") * whenkeydown < center)
                        whenkeydown++;
                    // }
                }
                else if (key == 38) {
                    if (keylevel == true) {
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").prev('li:eq(0)').addClass('hovered');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").next().removeClass('hovered');
                        $('.dropdown-submenu .dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").children('.dropdown-menu').first().css('display', 'block');
                    }
                    else if (keylevelLast == true) {
                        $("#selectForecast li.hovered .dropdown-menu li.hovered .dropdown-menu li.hovered").prev('li:eq(0)').addClass('hovered');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered .dropdown-menu li.hovered").next().removeClass('hovered');
                    }
                    else {
                        $("#selectForecast li.hovered").prev('li:eq(0)').addClass('hovered');
                        $("#selectForecast li.hovered").next().removeClass('hovered');
                        $('.dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered").children('.dropdown-menu').first().css('display', 'block');
                    }


                    var maxHeight = 500;
                    var $container = $("#selectForecast").find('li.hovered').last().parent().parent();
                    //$container[0].onmouseover();
                    var $list = $container.children('ul').first();
                    var height = $list.height() * 1.1;
                    var multiplier = height / maxHeight;
                    $container.data("origHeight", $container.height());
                    // make sure dropdown appears directly below parent list item    
                    $list
                        .show()
                        .css({
                            // paddingTop: $container.data("origHeight")
                        });
                    // don't do any animation if list shorter than max
                    if (multiplier > 1) {
                        var $container1 = $("#selectForecast").find('li.hovered').last();
                        var offset = $container1.offset();
                        var center = $list.height();
                        var relativeY = (offset.top) - ($container.data("origHeight") * multiplier);
                        if (offset.top < maxHeight / 3) {
                            if (keylevelLast == true) {
                                $list.css("top", -$container.data("origHeight") * whenkeylevelLast + maxHeight / 3);

                            }
                            else {
                                $list.css("top", -$container.data("origHeight") * whenkeydown + maxHeight / 3);
                            }
                        }
                    }

                    if (keylevelLast == true && $container.data("origHeight") * whenkeylevelLast > maxHeight / 3)
                        whenkeylevelLast--;
                    else if (keylevelLast == false && $container.data("origHeight") * whenkeydown > maxHeight / 3) {
                        whenkeydown--;
                    }
                    // }

                }
                else if (key == 39) {
                    whenkeylevelLast = 1;
                    if ($('#selectForecast li.hovered .dropdown-menu li.hovered .dropdown-menu').length > 0) {
                        keylevelLast = true;
                        keylevel = false;
                        whenkeylevelLast = 1;
                        if (!$("#selectForecast li.hovered .dropdown-menu li.hovered .thirdlevel").find('li').hasClass("hovered"))
                            $("#selectForecast li.hovered .dropdown-menu  li.hovered .thirdlevel").find('li').first().addClass('hovered');
                        $('.dropdown-submenu .dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered .thirdlevel").css('display', 'block');
                    }
                    else if ($('#selectForecast li.hovered .dropdown-menu').length > 0 && (keylevel == false) && (keylevelLast == false)) {
                        keylevel = true;
                        if (!$("#selectForecast li.hovered .dropdown-menu").find('li').hasClass("hovered"))
                            $("#selectForecast li.hovered .dropdown-menu").find('li').first().addClass('hovered');
                        $('.dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered").children('.dropdown-menu').first().css('display', 'block');
                    }
                    else if ($('#selectForecast li.hovered .dropdown-menu').length > 0 && (keylevelLast == false) && (keylevel == true)) {


                        keylevel = true;
                        if (!$("#selectForecast li.hovered .dropdown-menu").find('li').hasClass("hovered"))
                            $("#selectForecast li.hovered .dropdown-menu").find('li').first().addClass('hovered');
                        $('.dropdown-submenu .dropdown-submenu .dropdown-menu').css('display', 'none');
                        $("#selectForecast li.hovered .dropdown-menu li.hovered").children('.dropdown-menu').first().css('display', 'block');

                    }



                    else {
                        $("#selectForecast li.hovered").children('.dropdown-menu').first().css('display', 'block');
                    }
                }

                if (e.keyCode == 13 && $("#selectForecast").find('li.hovered').length > 0) {
                    $("#selectForecast").find('li.hovered').last().focus();
                    $("#selectForecast").find('li.hovered').last().click();
                }
            }
            // $("#selectForecast li.hovered a").hover();
            return false;
            return '';

        });

        document.getElementById("selectForecast").addEventListener("mouseleave", function () {
            $(this).find('li').removeClass('hovered');
        });
        document.getElementById("selectForecast").addEventListener("mouseover", function () {
            $(this).find('li').removeClass('hovered');
        });
    }
}

function addVersionListItem(name, version, latestVersion, level, displayLabelAsVersion) {
    var valueLabel = version.Label;
    if (valueLabel == "V0.0") {
        var clsLeaf = '';
       var clsLevel = 'firstlevel';
       return '<li data-toggle="tooltip" name="{0}" value="{1}" title="{4}" class="{2} forecast-version {3}"><a class="srch_paging"title="{0}" href="#">{0}</a>'
           .replace("{0}", name)
           .replace("{1}", valueLabel)
          .replace('{2}', clsLeaf)
         .replace("{3}", clsLevel)
        .replace('{4}', getPropertiesString(name, valueLabel));
    }
    else {
        var latest = false;
        if (latestVersion && valueLabel == latestVersion.Label)
            latest = true;
        var clsLevel = '';
        if (level == 1)
            clsLevel = 'firstlevel';
        else if (level == 2)
            clsLevel = 'secondli';

        var mock = version.IsMock;
        var displayLabelAsVersionTooltip = valueLabel;
        if (displayLabelAsVersion) {
            displayLabelAsVersion = valueLabel;
            if (mock == true) {
                displayLabelAsVersion = " In progress...";
                valueLabel = latestVersion.Label;
            }
            displayLabelAsVersionTooltip = displayLabelAsVersion;
        }
        else
            displayLabelAsVersion = '{0}';
        var isLeaf = false;
        if (level > 1 && (!version.PreDrafts || version.PreDrafts.length == 0))
            isLeaf = true;
        var clsLeaf = '';
        var arrow = '';
        if (!isLeaf) {
            clsLeaf = 'dropdown-submenu';
            arrow = '<i class="fa fa-chevron-right"></i>';
        }

        if (clsLevel == "firstlevel") {
            return '<li data-toggle="tooltip" name="{0}" value="{1}" latest="{2}" mock="{7}" title="{8}" class="{5} forecast-version {3}"><a class="srch_paging" title="{9}" href="#">{4}{6}</a>'
               .replaceAll("{1}", valueLabel)
               .replaceAll("{2}", latest)
               .replaceAll("{3}", clsLevel)
               .replaceAll('{4}', displayLabelAsVersion)
               .replaceAll('{5}', clsLeaf)
               .replaceAll('{6}', arrow)
               .replaceAll('{7}', mock)
               .replaceAll('{8}', getPropertiesString(name, valueLabel))
               .replaceAll('{9}', displayLabelAsVersion + " " + latestVersion.Label);
        }
        else {
            //return '<li name="{0}" value="{1}" latest="{2}" mock="{7}" title="{8}" class="{5} forecast-version {3}"><a href="#">{4}{6}</a>'.replaceAll("{1}", valueLabel).replaceAll("{2}", latest).replaceAll("{3}", clsLevel).replaceAll('{4}', displayLabelAsVersion).replaceAll('{5}', clsLeaf).replaceAll('{6}', arrow).replaceAll('{7}', mock).replaceAll('{8}', displayLabelAsVersionTooltip);
            return '<li data-toggle="tooltip" name="{0}" value="{1}" latest="{2}" mock="{7}" title="{8}" class="{5} forecast-version {3}"><a class="srch_paging" title="{9}" href="#">{4}{6}</a>'
                .replaceAll("{1}", valueLabel)
                .replaceAll("{2}", latest)
                .replaceAll("{3}", clsLevel)
                .replaceAll('{4}', displayLabelAsVersion)
                .replaceAll('{5}', clsLeaf)
                .replaceAll('{6}', arrow)
                .replaceAll('{7}', mock)
                .replaceAll('{8}', getPropertiesString(name, valueLabel))
                .replaceAll('{9}', displayLabelAsVersion);
        }
    }
    
}

function adjustLongListScrolling(li_having_ul) {
    if (!li_having_ul || li_having_ul.length == 0)
        return;
    li_having_ul.hover(function () {
        var maxHeight = 500;
        var $container = $(this);
        var $list = $(this).children('ul');
        var height = $list.height() * 1.1;
        var multiplier = height / maxHeight;
        $container.data("origHeight", $container.height());
        // make sure dropdown appears directly below parent list item    
        $list
            .show()
            .css({
                //paddingTop: $container.data("origHeight")
            });
        // don't do any animation if list shorter than max
        if (multiplier > 1) {
            $container
        .mousemove(function (e) {
            var offset = $container.offset();
            var relativeY = ((e.pageY - offset.top) * multiplier) - ($container.data("origHeight") * multiplier);
            if (relativeY > $container.data("origHeight")) {
                $list.css("top", -relativeY + $container.data("origHeight"));
            };
        });
        }
    }, function () {
        var $el = $(this);

        // put things back to normal
        $el
            .height($(this).data("origHeight"))
            .children('ul')
            .css({ top: 0 })
            .hide()
            .end()
    });

    //recursion
    adjustLongListScrolling(li_having_ul.children())
}

function setSectionOrder(isPopalertDisplay)
{
    var forecast = currentForecast.name;
    var version = currentForecast.version;
    $('#droppable li.sectionslist').length;
    var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var results = [];
    var sectionList = $("#nestable>ol:eq(0)>li");
    for (var i = 0; i < sectionList.length; i++) {
        results.push($(sectionList[i]).attr("data-id"));
    }
    var sectionIDsPipeseperated = results.join("|");
    
    PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/SetSectionPreferences", JSON.stringify({ 'forecast': forecast, 'type': modelType, 'version': version, 'sectionPref': sectionIDsPipeseperated }),
       function (result) {
           if (result.success) {
               hideOverlay();
               showEDraw();
               if (isPopalertDisplay)
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Section preferences updated", '');
           }
           else {
               hideOverlay();
               showEDraw();
               if (isPopalertDisplay)
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not update section preferences", '');
           }
       },
       function (result) {
           hideOverlay();
           showEDraw();
           if (isPopalertDisplay)
           PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not update section preferences", '');
       });

}

function navigateToSection(start, name, paramid) {
    if (!objExcel)
        return;

    if ($('#droppable' + ' #' + paramid).length == 1) {
        //strat.preventDefault();
        return
    }
    else {
        $('.sidebar-nav-left li,.sidebar-nav-left li a').removeClass('activatedAssum');
        $('#' + paramid).addClass('activatedAssum');
        var sectionElement = $('#set_assumptions>div:contains("' + name + '")');
        if (sectionElement.length > 0)
            sectionElement[0].scrollIntoView();
        var worksheet = objExcel.Workbooks(1).Worksheets("SPDocLib");
        worksheet.cells(1, 4).value = start;
        var vbaMethod = "'{0}'!ScrollToSection".replace("{0}", objExcel.Workbooks(1).Name);
        runMacro(vbaMethod);
        OA1.focus();
        OA1.click();
        updateScreen();
    }
}

function updateLeftPaneLabel(){
    if (currentForecast.version == "V0.0" || currentForecast.version =="") {
        $('#NameInfo').html(currentForecast.name);
        $('#VersionInfo').html(" Sections");
        $('#anchorsectionstagid').css("display", "none");
    }
    else
    {
        $('#NameInfo').html(currentForecast.name);
        $('#VersionInfo').html(currentForecast.version + " Sections");
        $('#anchorsectionstagid').css("display", "inline");
    }
}

function updateProperties() {
    updateLeftPaneLabel();
    var name = currentForecast.name;
    var versionLabel = currentForecast.version;    
    var item = currentForecast.item;
    if (!item)
        return;
    var strn = item.Comment;
    if (strn) {
        var rep = strn.replace("Saved By", "</div><br/> Saved By");
        $('#version_desc').html("<div class='replclass'>" + rep);
        $('#version_desc').attr('title', item.Comment);
        $('.tollp').html(rep);
    }
    else {
        strn = GetdefaultComment();
        var rep = strn.replace("Saved By", "</div><br/> Saved By");
        $('#version_desc').html("<div class='replclass'>" + rep);
        $('#version_desc').attr('title', strn);
        $('.tollp').html(rep);

    }
    var version = getVersion();
    if (version == "V0.0")
    {
        $('.vcoment').html("<p>" + name + "  Comment" + "</p>");
    }
    else
    {
        $('.vcoment').html("<p>" + name + "</p><p class='smallFont'>" + " " + getVersion() + " Comment</p>");
    }
    
    $('#version_detail').text(name + " " + getVersion());
    $('#version_detail').attr('title', name + getVersion());
    if (item.Access) {
        if (item.Access.Creator) {
            var creatorName = item.Access.Creator.FirstName + " " + item.Access.Creator.LastName;
            var creatorEmail = item.Access.Creator.Email;
            $('#author_id').text(creatorName);
            $('#author_id').attr('title', creatorEmail);

            $('#modifier_id').text(creatorName);
            $('#modifier_id').attr('title', creatorEmail);
        }
        if (item.Access.CreatedOn) {
            var currDate = item.Access.CreatedOn.substr(6);
            var newCurrDate = new Date(parseInt(currDate));
            var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(newCurrDate));
            var dateStr = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date1));
            $('#created_on').text(dateStr);
            $('#created_on').attr('title', dateStr);

            $('#modified_on').text(dateStr);
            $('#modified_on').attr('title', dateStr);
        }

        //revert collections used for share
        userForecastMappingForShare = [];
        userArrayShared = [];
        if (item.Access.SharedAccess && item.Access.SharedAccess.length > 0) {
            var name = [];
            var email = [];
            var sameName = false;
            var divContent = document.getElementById('shared_with');
            var str = '';
            for (var i = 0; i < item.Access.SharedAccess.length; i++) {
                if (item.Access.SharedAccess[i].SharedWith.Email || item.Access.SharedAccess[i].SharedWith.FirstName || item.Access.SharedAccess[i].SharedWith.LastName)
                    if (item.Access.Creator) {
                        if (item.Access.Creator.Email != item.Access.SharedAccess[i].SharedWith.Email) {
                            str += '<div title = ' + item.Access.SharedAccess[i].SharedWith.Email + '>' + item.Access.SharedAccess[i].SharedWith.FirstName + " " + item.Access.SharedAccess[i].SharedWith.LastName + ',' + '</div>'

                        }
                    }
            }
                    
      
       if (str) {

           divContent.innerHTML = str.slice(0, -7) + "</div>";
       }
       }

        }
}


function searchFromList(e) {   
    if ($("#importSerach").val() != "") {      
        var searchonId = "importSerach";
        var searchById = "selectForecast";
        PHARMAACE.FORECASTAPP.UTILITY.searchFromList(searchonId, searchById);
        $('.dropdown-submenu.firstlevel > a').hover(function () {
            //var abc = '';
            //var xyd = '';
            //xyd=abc.length;
            $(this).next('ul').css('display', 'block');
            $(this).next('ul').children().css('display', 'block');
             $(this).closest('ul li').css('display', 'block');
            $(this).after().find('ul').css('display', 'block');
           // $('.dropdown-submenu.firstlevel > ul').css('display', 'block');
            $('.dropdown-submenu.firstlevel > ul li').css('display', 'block');

        });
    }
    else {
       // populateControls();
        $('.dropdown-submenu.firstlevel > a').hover(function () {
            $(this).next('ul').css('display', 'block');
            $(this).next('ul').children().css('display', 'block');
        });
                if (e.which === 8) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            }
        }


function getPropertiesString(name, versionLabel) {
    var item = getItemInModelByNameAndVersion(name, versionLabel);

    if (!item)
        return;
    var hoverToolTip = "{0} saved on {1}";

    if (item.Access) {
        if (item.Access.Creator) {
            var creatorName = item.Access.Creator.FirstName + " " + item.Access.Creator.LastName;
            var creatorEmail = item.Access.Creator.Email;
            hoverToolTip = hoverToolTip.replace("{0}", creatorName);
        }
        else
        {
            var creatorName = "";
            hoverToolTip = hoverToolTip.replace("{0}", creatorName);
        }
        if (item.Access.CreatedOn) {
            var currDate = item.Access.CreatedOn.substr(6);
            var newCurrDate = new Date(parseInt(currDate));
            var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(newCurrDate));
            var dateStr=PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date1));
            //var dateStr = (PHARMAACE.FORECASTAPP.UTILITY.dayOfWeekAsString(date1.getDay()) + " " + PHARMAACE.FORECASTAPP.UTILITY.monthAsString(date1.getMonth()) + " " + date1.getDate() + " " + date1.getFullYear() + " " + date1.getHours() + ":" + date1.getMinutes());
            hoverToolTip = hoverToolTip.replace("{1}", dateStr);
        }
        if (item.Comment)
            hoverToolTip = hoverToolTip + "</br>" + item.Comment;
        if (item.Access.SharedAccess && item.Access.SharedAccess.length > 0) {
            var str = '';
            var strPrepend = '</br>Access given to:';
            for (var i = 0; i < item.Access.SharedAccess.length; i++) {
                if (item.Access.SharedAccess[i].SharedWith.Email || item.Access.SharedAccess[i].SharedWith.FirstName || item.Access.SharedAccess[i].SharedWith.LastName)
                    if (item.Access.Creator) {
                        if (item.Access.Creator.Email != item.Access.SharedAccess[i].SharedWith.Email) {
                                str += '</br>' + item.Access.SharedAccess[i].SharedWith.FirstName + " " + item.Access.SharedAccess[i].SharedWith.LastName + ',';
                           
                        }
                    }
            }
            if (str) {
                str = strPrepend + str;
                str = str.slice(0, -1);
                hoverToolTip = hoverToolTip + str;
            }
        }        

        return hoverToolTip;        
    }
}


function RefreshModelForDeleteForecast()
{
    var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/ForecastEntity", { type: modelType },
        function (result) {
            if (result.success) {
                model = result.entity;
                populateControls();
                updateProperties();
            }
            else {
                hideOverlay();
            }
        },
            function (result) {
                hideOverlay();
            });
}

function copySelectedForecast(ProjectName)
{
    var e = window.event;
    e.stopPropagation();
    e.preventDefault();
    $('#copyModal').modal('show');
    checkedVersionIndex = 0;
    checkedVersionminorIndex = 0;
    $("#copiedtoname").val('');
    versionArrayForCopy = [];
    var tableRef = document.getElementById('copied_users_table').getElementsByTagName('tbody')[0];
    document.getElementById('ProjNameid').innerHTML=ProjectName;
     ($('#checkallversion').is(':checked') == true)
        $('#checkallversion').attr('checked', false);
       
     ($('.CopyForecast').is(':checked') == true) 
        $('.CopyForecast').attr('checked', false);
    
   
  
    var str = '';
  
    if (model.ForecastDetails && model.ForecastDetails.ItemList) {
        var lst = model.ForecastDetails.ItemList;
        for (var i = 0; i < lst.length; i++) {
            var item = lst[i];
            var dataindexvalue = 0;
            if (item.Forecast == ProjectName) {
                if (!item.Versions || item.Versions.length == 0)
                    continue;
                for (var j = 0; j < item.Versions.length; j++) {

                    
                    if (item.Versions[j].PreDrafts != null) {
                        if (item.Versions[j].Label) {
                            if (item.Versions[j].Label.split(".")[1] == "0") {
                                versionArrayForCopy.push(item.Versions[j].Label);
                                str += '<tr><td id="" style = "">' + item.Versions[j].Label + '</td>';
                                str += '<td style=""><input data-index=' + dataindexvalue + ' class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                                //str += '<td style=""><input data-index=' + j + ' class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style="" class="selectedversionvalue"></td></tr>';
                                dataindexvalue++;
                            }
                        }


                        for (var k = 0 ; k < item.Versions[j].PreDrafts.length ; k++) {
                            if (k == 0) {
                                versionArrayForCopy.push(item.Versions[j].PreDrafts[k].Label);
                                str += '<tr><td id="" style = "">' + item.Versions[j].PreDrafts[k].Label + '</td>';
                                str += '<td style=""><input data-index=' + dataindexvalue + ' class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                                //str += '<td style=""><input data-index=' + j + ' class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style="" class="selectedversionvalue"></td></tr>';
                                dataindexvalue++;
                            }
                            else {
                                versionArrayForCopy.push(item.Versions[j].PreDrafts[k].Label);
                                str += '<tr><td id="" style = "">' + item.Versions[j].PreDrafts[k].Label + '</td>';
                                str += '<td style=""><input data-index=' + dataindexvalue + ' class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                                //str += '<td style=""><input data-index=' + j + ' class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style="" class="selectedversionvalue"></td></tr>';
                                dataindexvalue++;
                            }
                        }
                    }
                    else {
                        versionArrayForCopy.push(item.Versions[j].Label);
                        str += '<tr><td id="" style = "">' + item.Versions[j].Label + '</td>';
                        str += '<td style=""><input data-index=' + dataindexvalue + ' class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                       // str += '<td style=""><input data-index=' + j + ' class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                        str += '<td style="" class="selectedversionvalue"></td></tr>';
                        dataindexvalue++;
                    }
                }
            }
        }
    }
    tableRef.innerHTML = str;
}


$(document).on("change", "input:checkbox[id='checkallversion']", function () {
    if (this.checked) {
        $('.CopyForecast').prop('checked', true);
        //$('.ischeckminor').prop('checked', true);
    }
    else
    {
        $('.CopyForecast').prop('checked', false);
        //$('.ischeckminor').prop('checked', false);
    }
});
$(document).on("change", "input:checkbox[class='CopyForecast']", function () {
    var ischecked = $(this).is(':checked');
        
        if (ischecked) {
           
            checkedVersionminorIndex = 0;
                $(this).parent().parent().find('td.selectedversionvalue').text("V" + ++checkedVersionIndex + ".0");
       
        }
    else
        {
            $(this).parent().parent().find('td.selectedversionvalue').text("");
            checkedVersionIndex--;
        }
});

    function CopyAllVersions() {
    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var modelLocation = model.ModelLocation;
    var projectName = $("#ProjNameid").html().trim();
    var copiedToForecast = $("#copiedtoname").val();
    currentForecast.name = copiedToForecast;
    var versionValue;
    var userArray = [];
    var NoOfVersion = 1;
    var IsEnableMinorVersionCheck = false;
    var attrdataindex;
    var userArray = [];
    var reversedVersionArrayForCopy = versionArrayForCopy.reverse();
   
    if (copiedToForecast != "")
    {

        // var versionArray = $('#copied_users_table tbody tr').find('td').text();
        for (var i = 0; i < reversedVersionArrayForCopy.length ; i++)
        {
            if (reversedVersionArrayForCopy[i].split(".")[1] == "0")
            {
                versionValue = reversedVersionArrayForCopy[i];
                IsEnableMinorVersionCheck = false;
                var versionarrayselected;
                if (i == 0)
                {
                    versionarrayselected = { versionValue: versionValue, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0, Forecast: projectName, CopiedToForecastName: copiedToForecast, modelLocation: modelLocation, type: type }
                }
                else
                 versionarrayselected = { versionValue: versionValue, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0 };
                userArray.push(versionarrayselected);
            }
            else
            {
                versionValue = reversedVersionArrayForCopy[i];
                IsEnableMinorVersionCheck = true;
                var versionarrayselected;
                if (i == 0) {
                    versionarrayselected = { versionValue: versionValue, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0, Forecast: projectName, CopiedToForecastName: copiedToForecast, modelLocation: modelLocation, type: type }
                }
                else
                   versionarrayselected = { versionValue: versionValue , IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0};
                userArray.push(versionarrayselected);
            }
        }

        
        var postData = JSON.stringify({'UserVerisonArray': userArray, });
        
        PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Forecast/CopyForecast",postData,
           function (result) {
               if (result.success) {
                   hideOverlay();
                   RefreshModelForDeleteForecast();
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Copied forecast successfully", '');
    }
    else {
                   hideOverlay();
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping forecast failed", '');
            }
           },
           function (result) {
               hideOverlay();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping forecast failed", '');
           });
    }
    else {
        hideOverlay();
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping Forecast failed", '');
    }
}

function CopyForecast() {
    showOverlay("Copying forecast...");
    var allversion = document.getElementById('checkallversion');
    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var modelLocation = model.ModelLocation;
    var projectName = $("#ProjNameid").html().trim();
    var copiedToForecast = $("#copiedtoname").val();
    currentForecast.name = copiedToForecast;
    var autocompleteListData;
    var usersInformation;
    var versionValue;
    var userArray = [];
    var NoOfVersion = 1;
    var IsEnableMinorVersionCheck = false;
    var attrdataindex;
    if (allversion.checked) {
        CopyAllVersions();
    }
    else {
        if (copiedToForecast != "") {
    var checkboxes = document.getElementsByClassName("CopyForecast");
           // var ele = document.getElementsByClassName("ischeckminor");
    for (i = 0; i < checkboxes.length; i++) {
                

        if (checkboxes[i].checked) {
                
                    attrdataindex = checkboxes[i].getAttribute('data-index');
                    versionValue = $('#copied_users_table tbody tr:eq(' + attrdataindex + ')').find('td:eq(' + attrdataindex + ')').text();
                    if (versionValue.split(".")[1] != "0")
                IsEnableMinorVersionCheck = true;
                    else
                IsEnableMinorVersionCheck = false;
                    var versionarrayselected;
                    if (i == 0) {
                        versionarrayselected = { versionValue: versionValue, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0, Forecast: projectName, CopiedToForecastName: copiedToForecast, modelLocation: modelLocation, type: type }
            }
                    else
                        versionarrayselected = { versionValue: versionValue, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0 };
            userArray.push(versionarrayselected);
        }

    }

              var postData = JSON.stringify({'UserVerisonArray': userArray, });
            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Forecast/CopyForecast", postData,
           function (result) {
               if (result.success) {
                   hideOverlay();
                   RefreshModelForDeleteForecast();
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Copied Forecast Successfully", '');
               }
               else {
                   hideOverlay();
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping Forecast failed", '');
               }
           },
           function (result) {
               hideOverlay();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping Forecast failed", '');
           });
}
        else {
        hideOverlay();
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping Forecast failed", '');
    }
}
}

function gFRemoveProjectDetailsMsg(projectName)
{
    var e = window.event;
    e.stopPropagation();
    e.preventDefault();
    bootbox.dialog({
        message: "Do you want to remove forecast?",
        title: "",
        closeButton: true,
        size: 'large',
        className: "custom-dialogue",
        buttons: {
            success: {
                label: "Yes",
                className: "btn-diabox",
                callback: function (result) {
                    if (result) {
                        gFRemoveProjectDetails(projectName);
                        
                    }
                }
            },
            danger: {
                label: "No",
                className: "btn-default",
                callback: function () {
                    hideOverlay();
                    bootbox.hideAll();
                }
            },
        }
    });
}

function gFRemoveProjectDetails(ProjName) {
    showOverlay("Deleting forecast...");
    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var modelLocation = model.ModelLocation;
    var ProjectName = ProjName;
    PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/GFRemoveProjectDetails", JSON.stringify({ 'ProjectName': ProjectName, 'type': type, 'ModelLocation': modelLocation }),
       function (result) {
           if (result.success) {              
               hideOverlay();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Forecast" + ProjectName + "deleted successfully", '');
               showEDraw();
               RefreshModelForDeleteForecast();
           }
           else {              
               hideOverlay();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not delete forecast.please try again.. ", '');
               showEDraw();
           }
       },
       function (result) {
           hideOverlay();
           PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not delete forecast.please try again.. ", '');
           showEDraw();
       });
}


 function removeSharedWithValuesTocurrentForecast(unShareUserArray)
 {
     var item = currentForecast.item;
    for (var i = 0; i < item.Access.SharedAccess.length; i++) {

         for (var j = 0; j < unShareUserArray.length ; j++) {
             if (item.Access.SharedAccess[i].SharedWith.UserId == unShareUserArray[j].UnShareUserID) {
                 item.Access.SharedAccess.splice(i, 1);
             }
         }
    }
}
function changeButtonBg()
{
    $('#openbutton').removeClass('open-default').addClass('open-inline');
   $('#newbutton').removeClass('open-inline').addClass('open-default');
}
function onForecastUpdate(leaveNewsFeed) {
    updateVersions();
}
function updateVersions() {
    removeOptions(document.getElementById("selectVersion"));
    urlArr = [];
    var ele = document.getElementById('selectForecast');
    if (ele.options[ele.selectedIndex].text == "New Forecast") {
        $('#selectVersion').append("<option value= -1>--Select--</option>");
    }
    else if (ele.options[ele.selectedIndex].text == "Please Select...") {
        $('#selectVersion').append("<option value= -2>--Select--</option>");
    }
    else {
        var item = getSelectedItemInModel();
        var versionValue = "V" + item.MajorVersion + "." + item.MinorVersion;
        var currversion = "V" + currentForecast.version;     
        urlArr[0] = item.url;
        if (versionValue == currversion) {
            $('#selectVersion').append("<option class='selectedhighlight' value=" + serverurl + item.url + ">" + versionValue + "</option>");
        }
        else {
            $('#selectVersion').append("<option value=" + serverurl + item.url + ">" + versionValue + "</option>");
        }
        if (item.versions) {
            var versionIndex = 1;
            item.versions.slice().reverse().forEach(function (v) {
                versionValue = "V" + v.MajorVersion + "." + v.MinorVersion;
                urlArr[versionIndex] = v.Url;
                versionIndex++;
                if (versionValue == currversion) {
                    $('#selectVersion').append("<option class='selectedhighlight'>" + versionValue + "</option>");
                }
                else {
                $('#selectVersion').append("<option>" + versionValue + "</option>");
                }
            });
        }
        updateProperties();
    }
}
function getSelectedItemInModel() {
    var ele = document.getElementById('selectForecast');
    var itemIndexInModel = ele.options[ele.selectedIndex].value;
    if (itemIndexInModel > -1)
        return model.ForecastDetails.ItemList[itemIndexInModel];
}

function getSelectedForecastForShare()
{
    var ele = document.getElementById('projectList');
    if (ele.selectedIndex > -1 )
    var itemIndexInModel = ele.options[ele.selectedIndex].value;
    var itemList = model.ForecastDetails.ItemList;
    for (var i = 0; i < itemList.length; i++) {
        if (itemList[i].Forecast == itemIndexInModel)
            return itemList[i];
    }
}
function getItemInModelByNameAndVersion(name, versionLabel) {
    var itemList = model.ForecastDetails.ItemList;
    for (var i = 0; i < itemList.length; i++) {
        if (itemList[i].Forecast == name) {
            if (!versionLabel)
                versionLabel = currentForecast.version;
            return getItemInModelByVersion(itemList[i], versionLabel);
        }
    }
}

function getItemInModelByVersion(forecastItem, versionLabel) {
    var returnItem = null;
    for (var i = 0; forecastItem.Versions && i < forecastItem.Versions.length; i++) {
        if (forecastItem.Versions[i].Label == versionLabel) {
            returnItem = forecastItem.Versions[i];
            break;
        }
        for (var j = 0; forecastItem.Versions[i].PreDrafts && j < forecastItem.Versions[i].PreDrafts.length; j++) {
            if (forecastItem.Versions[i].PreDrafts[j].Label == versionLabel) {
                returnItem = forecastItem.Versions[i].PreDrafts[j];
                break;
            }
        }
    }

    if (returnItem)
        returnItem.latest = forecastItem.LatestVersion.Label;
    return returnItem;
}
function getMajorMinorFromVersionLabel(label) {
    var majorMinor = { major:0, minor:0 };
    if (label) {
        var splitByV = label.split('V');
        if (splitByV.length == 2) //otherwise version format incorrect
        {
            if (splitByV[1]) //otherwise version format incorrect
            {
                var splitByDot = splitByV[1].split('.');
                
                if (splitByDot && splitByDot.length > 0){
                    majorMinor.major = splitByDot[0];
                }
                if (splitByDot && splitByDot.length > 1) {
                    majorMinor.minor = splitByDot[1];
                }
            }
        }
    }

    return majorMinor;
}

    //Create New Forecast
    function createNewForecast() {
        hideEDraw();
        addDisabledctrnew();
        if (isCreatedOrRetrieved) {
            IssaveForecast(createFreshForecast);
            enableButton();
        }
        else {            
            createFreshForecast();
        }
    }
    function unProtectSheet()
    {
        if (!objExcel)
            return;

        try {
            objExcel.Workbooks(1).Worksheets("Generic_Forecast").Unprotect();
        }
        catch (e) {
            //eat exception
        }
    }

    function createFreshForecast()
    {
        hideEDraw();
        createForecastafterCheck();
    }

    function createForecastafterCheck() {
        if (Isinmiddleofretrieve == false) {
            showOverlay("Creating forecast project. This may take a few moments");
            if (objExcel != null) {
                OA1.CloseDoc();
            }
            unProtectSheet();
            var vbaMethod; 
            selectedProduct = "";
            isSaveAsForecast = false;
            var isDownloadTool = 1;
            IsCreated = true;
            IsSaveOrRetrieve = false;
            offlineSave = false;
            var projName = "";
            saveNewForecast = true;
            // isCreateFlag = true;
            setUnsaveCreateForecastName = true;
            var filePathWithExtension = "";
            var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            setTimeout(function () {
                try {
                    onDocReady(isDownloadTool, "", "", "");                    
                    vbaMethod = "'{0}'!Create_Forecast_Generic".replace("{0}", objExcel.Workbooks(1).Name);
                    if (runMacro(vbaMethod)) {                        
                        var isCancelled;
                        $('#versionmsg').css("display", "none");
                        checkSectionTagEnable(false);
                        if (type == 0 || type == 1) {
                            isCancelled = objExcel.Workbooks(1).Worksheets("Home").Range("A3").Value;
                        }
                        if (!isCancelled) {
                            if (type == 0 || type == 1) {
                                vbaMethod = "'{0}'!InitializeDisplay".replace("{0}", objExcel.Workbooks(1).Name);
                                runMacro(vbaMethod);
                            }
                            var filePathWithExtension = getTempDirectory();
                            //var parts = filePathWithExtension.split('\\');
                            //var output = parts.join('\\\\');
                            var output = filePathWithExtension;
                            var extension = ".xlsb";
                            var projName = objExcel.Workbooks(1).Worksheets("Vars").Range("A2").Value;
                            if (projName) {
                                var ProjectName = projName + "_Template";
                                var filePathWithExtension = output + '\\' + ProjectName + extension;
                                currentForecast.name = projName;
                                currentForecast.version = 'V0.0';
                                currentForecast.item = {};
                                var extension = PHARMAACE.FORECASTAPP.UTILITY.getFileExtension(filePathWithExtension);
                                if (filePathWithExtension && filePathWithExtension.length > 0) {
                                    if (extension == 'xlsb') {
                                        createForecastToServer(filePathWithExtension, projName);
                                    }
                                }
                            }
                            else {
                                hideOverlay();
                                hideEDraw();
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter forecast name", "");
                            }
                        }
                        else {
                            hideOverlay();
                            hideEDraw();
                        }
                    }
                    else {
                        hideOverlay();
                        return;
                    }
                }
                catch (e) {
                    hideOverlay();
                }
            }, 500);
        }
        else {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("You are in middle of retrieving...", "");
            hideOverlay();
        }
        }

    function editForecast(liElement) {
        $('#importSerach').css("width", "0px");
        $('#importSerach').css("background", "none");
        $('#importSerach').css("border", "0px");
        $('#mainheading').focus();
        $('#mainheading').click();
        $('#selectForecast').css("display", "none");
        $('#ImportParent .pagination').css("display", "none");
        var name = $(liElement).attr('name');
        var versionLabel = $(liElement).attr('value');
        $("#selectForecast .tooltip").remove();
        $("#selectForecast .tooltip").tooltip('hide');
        addDisabledopen();
        if (isCreatedOrRetrieved) {
            IssaveForecast(function () { editFreshForecast(name, versionLabel); });
        }
        else {
            editFreshForecast(name, versionLabel);
        }
        $('#newbutton').removeClass('open-default').addClass('open-inline');
        $('#openbutton').removeClass('open-inline').addClass('open-default');
       
    }

    function editFreshForecast(name, versionLabel) {
        try
        {
            Isinmiddleofretrieve = true;
            IsSaveOrRetrieve = true;
            offlineSave = false;
            isOfflineFlatFile = false;
            selectedProduct = "";
            $('.tollp').css("display", "block");
            $('.vcoment').css("display", "block");
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            if (modelType == 0 || modelType == 1) {
                unProtectSheet();
            }
            var isDownloadTemplate;
            setUnsaveCreateForecastName = false;
            // showOverlay("Retrieving {0}...".replace('{0}', name));
            if (versionLabel == "V0.0")
            {
                showOverlay("Retrieving {0}. This may take a few moments...".replace('{0}', name));
            }           
            else
            {
                showOverlay("Retrieving {0} {1}. This may take a few moments...".replace('{0}', name).replace('{1}', versionLabel));
            }
            if (currentForecast.name == name && versionLabel != "V0.0")
            {
                isDownloadonlyflatFile = true;
                isDownloadTemplate = 3;                 // download only flat file
                retriveForecast(name, versionLabel, "", isDownloadTemplate,"");    // parameters : 1. name of forecast , 2. version , 3.model path i.e temp/oa path 4.file is flatfile or template 5. notes i.e assumptions that we got after downloading forecast versions.
            }
            else if (currentForecast.name != name || versionLabel == "V0.0") {
                if (objExcel != null)
                {
                    OA1.CloseDoc();
                }
                isDownloadonlyflatFile = false;
                if (versionLabel == "V0.0")
                    isDownloadTemplate = 2;     // download only template
                else
                    isDownloadTemplate = 4;    // download both template and flat file
                //hideEDraw();
                onDocReady(isDownloadTemplate, name, versionLabel,"");
            }
        }
        catch(e)
        {
            Isinmiddleofretrieve = false;
            hideOverlay();
        }
    }

    function getWorksSheetsArr()
    {
        var workSheetsArr = [];
        workSheetsArr.push("ProjectDetails");
        workSheetsArr.push("ProductDetails");
        workSheetsArr.push("SegmentDetails");
        workSheetsArr.push("Segments");
        workSheetsArr.push("MasterList");
        workSheetsArr.push("EPIData");
        workSheetsArr.push("HistoricalData");
        workSheetsArr.push("ConversionData");
        workSheetsArr.push("AdvancedPricing");
        workSheetsArr.push("Shares");
        workSheetsArr.push("Source");
        workSheetsArr.push("Events");
        workSheetsArr.push("OutputData");
        workSheetsArr.push("CountryDetails");
        workSheetsArr.push("Indication");
        workSheetsArr.push("Assumptions");
        workSheetsArr.push("Generic_Forecast");
        workSheetsArr.push("Home");
        workSheetsArr.push("Trending");
        workSheetsArr.push("Consolidator");
        return workSheetsArr;
    }

    function checkSheetsCountofTemplate(fileName) {
        if (!objExcel)
            return;

        var offlineWorksheetsArr = [];
        var checkWorksheetsArr = [];
        var fileNamewithExt = fileName +".xlsb";
        if (objExcel.Workbooks(1).Name == fileNamewithExt)
        {
            for(var i = 1 ; i <= 20 ; i++)
            {
                if (objExcel.Workbooks(1).Worksheets(i)) {
                    offlineWorksheetsArr.push(objExcel.Workbooks(1).Worksheets(i).Name);
                }
            }
            var sheetsCount = 0;
            checkWorksheetsArr = getWorksSheetsArr();
            for(var j = 0 ;j <= getWorksSheetsArr.length ; j++ )
            {
                for(var k = 0 ; k <= offlineWorksheetsArr.length ; k++)
                {
                    if(getWorksSheetsArr[j] == offlineWorksheetsArr[k])
                    {
                        sheetsCount++;
                    }
                }
            }
            if (sheetsCount == 20)
                return true;
            else
                return false;

        }

    }

    function downloadTemplate(oa, name, versionLabel, isDownloadonlyflatFile, pathforVba, onSuccess, direct) {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/DownloadFileFromdb", { forecast: name, version: versionLabel, type: modelType, isDownloadonlyflatFile: isDownloadonlyflatFile },
        function (result) {
            if (result.success) {
                var modelPath = result.url;
                var splitpath = modelPath.split("|");
                var templatePath = splitpath[0];
                var flatFilePath = splitpath[1];
                var notes = "";
                if (templatePath)
                    var tempPathTemplate = oa.HttpDownloadFileToTempDir(templatePath);
                if (flatFilePath)
                    var tempPathFlatFile = oa.HttpDownloadFileToTempDir(flatFilePath);
                var urlArr = modelPath.split("/");
                var folderName = urlArr[urlArr.length - 2];
                if (onSuccess)
                    onSuccess(tempPathTemplate, modelPath, result.notes);
                notes = result.notes
                //hideEDraw();
                 deleteIntermediate(modelPath);
                if (isOfflineFlatFile) {                //open offline for flat file
                    OpenOfflineFlatfile(pathforVba);
                }
                else {
                    setTimeout(function () {
                        //hideEDraw();
                        if (versionLabel == "V0.0") {
                            showOverlay("Retrieving {0}. This may take a few moments...".replace('{0}', name));
                        }
                        else {
                            showOverlay("Retrieving {0} {1}. This may take a few moments...".replace('{0}', name).replace('{1}', versionLabel));
                        }

                        retriveForecast(name, versionLabel, tempPathFlatFile, "", notes);              //first download template and then retrive forecast by versions on template retrived
                    }, 500);
                }
            }
            else {
                Isinmiddleofretrieve = false;
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load forecast. Please try again." + result.errors.join(), '');
                hideOverlay();
            }
        },
function (result) {
    Isinmiddleofretrieve = false;
    hideOverlay();
    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load forecast! ", '');
});
    }

    function checkIfFlatFile() {
        if (!objExcel)
            return;

        unProtectSheet();
        isCreatedOrRetrieved = true;
        offlineSave = true;
        var offlineProjName;
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var output;
        var isFlatFileName;
        var vbaMethod1 = "'{0}'!Validate_FlatFile".replace("{0}", objExcel.Workbooks(1).Name);
        isFlatFileName = runMacro(vbaMethod1);
        if (isFlatFileName) {
            var pathforVba = objExcel.Workbooks(1).Worksheets("Vars").Range("FA1").Value;
            if (objExcel != null)
            {
                OA1.CloseDoc();
            }
            if (isFlatFileName == "CanceledFlatFile")
            {
                hideOverlay(!isCreatedOrRetrieved); //keep EDraw hidden if nothing is created or retrieved prior to this
                return;
            }
        
            showOverlay("Uploading offline forecast...");
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/OpenOfflineForTemplate", { projectName: isFlatFileName, type: type },     //check if template is present in db or not
                                               function (result) {
                                                   if (result.success) {
                                                       output = result.returnVal;
                                                       if (output == 0) {
                                                           PHARMAACE.FORECASTAPP.UTILITY.popalert("Please upload the template first", '');
                                                           hideEDraw();
                                                           hideOverlay();
                                                       }
                                                       else if (output == 1) {
                                                           onDocReady(2, isFlatFileName, "", pathforVba);
                                                       }
                                                   }
                                                   else {
                                                       Isinmiddleofretrieve = false;
                                                       hideOverlay();
                                                   }
                                               },
                function (result) {
                    Isinmiddleofretrieve = false;
                    hideOverlay();
                });
        }
        else {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Selected file is not flat file", '');
            hideEDraw();
            hideOverlay();
        }

    }

    function checkSectionTagEnable(isVersionPresent)
    {
        if (isVersionPresent == false) {
            if (currentForecast.version == "V0.0" || currentForecast.version == "") {
                $('#sectionstagid').addClass('disabled');
                $('#anchorsectionstagid').css("cursor", "default");
                $('#anchorsectionstagid').removeAttr("onclick");
            }
        }
        else if(isVersionPresent == true)
        {
            $('#sectionstagid').removeClass('disabled');
            $('#anchorsectionstagid').css("cursor", "pointer");
            $('#anchorsectionstagid').attr("onclick", "setSectionOrder(true);");
        }
    }

    function OpenOfflineFlatfile(pathforVba)
    {
        objExcel.Workbooks(1).Worksheets("Vars").Range("FA1").Value = pathforVba;         // called old open offline code here
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        setTimeout(function () {
            var vbaMethod = "'{0}'!Retrieve_Forecast_From_Offline".replace("{0}", objExcel.Workbooks(1).Name);
            if (runMacro(vbaMethod)) {
               // $('#Prdbox').css("display", "block");
                if (type == 0) {
                    offlineProjName = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value;
                }
                else if (type == 1) {
                    offlineProjName = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value;
                }
                else {
                    offlineProjName = objExcel.Workbooks(1).Worksheets("Dates_Available").Range("D2").Value;
                }
                currentForecast.name = offlineProjName;
                $('.navigationPane').css("display", "block");
                $('#saveasdesc').attr("placeholder", " ");
                $('#saveasdesc').attr("placeholder", currentForecast.name);
                $('#saveasdesc').attr("title", currentForecast.name);
                createSetAssumptionSections(getSectionDetails());
                updateProperties();
                if (type == 0 || type == 1) {
                    populateSelectedList();
                }
                else {
                    populateIndicationListInActharModel();
                }
                if (type == 1) {
                    if (currentForecast.version == "V0.0" || currentForecast.version == "") {
                        checkSectionTagEnable(false);
                    }
                    getSectionPreference(currentForecast.name, "");
                }
                enableButton();
                hideOverlay();
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Offline forecast {0} loaded successfully".replace("{0}", offlineProjName), '');
            }
        }, 500);

    }

    function downloadFile(oa, name, versionLabel, isDownloadonlyflatFile, pathforVba, onSuccess, direct) {
        if (direct == 1) {
            var tempPath = oa.HttpDownloadFileToTempDir(baseUrl + "Content/AppDocs/" + name);
            onSuccess(tempPath);
            if (isOfflineFlatFile)
                checkIfFlatFile();
            
        }
        else if (direct == 2 || direct == 4) {
            downloadTemplate(oa, name, versionLabel, isDownloadonlyflatFile, pathforVba, onSuccess, direct);
        }
        else {
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/DownloadFileFromdb", { forecast: name, version: versionLabel, type: modelType, isDownloadonlyflatFile: isDownloadonlyflatFile },
    function (result) {
        if (result.success) {
            var modelPath = result.url;
            var splitpath = modelPath.split("|");
            var flatFilePath = splitpath[1];            
            //download flat file to temp directory
            if (flatFilePath)
                var tempPathFlatFile = oa.HttpDownloadFileToTempDir(flatFilePath);
            var urlArr = modelPath.split("/");
            var folderName = urlArr[urlArr.length - 2];
            if (onSuccess)
                onSuccess(tempPathFlatFile, modelPath, result.notes);
            deleteIntermediate(modelPath);
        }
        else {
            Isinmiddleofretrieve = false;
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load forecast. Please try again." + result.errors.join(), '');
            hideOverlay(!isCreatedOrRetrieved); //keep EDraw hidden if nothing is created or retrieved prior to this
        }
    },
    function (result) {
        Isinmiddleofretrieve = false;
        hideOverlay();
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load forecast! ", '');
    });
        }
    }

    function retriveForecastWithMacro(name, versionLabel, modelType, modelPath, notes)
    {
        objExcel.Workbooks(1).Worksheets("Home").Range("A1").Value = modelPath.replace(getTempDirectory() + "\\", "");//getSelectedItemInModel().name;
        currentForecast.item = getItemInModelByNameAndVersion(name, versionLabel);
        var vbaMethod = "'{0}'!Retrieve_Forecast".replace("{0}", objExcel.Workbooks(1).Name);
        if (runMacro(vbaMethod)) {
           // applyAuthorization();
            retriveForecastAfterMacro(name, versionLabel, modelType, notes);
        }
    }

    function retriveForecast(name, versionLabel, modelPath, isLoadFlatFile, notes)
    {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            try {
                setTimeout(function () {               
                    if (versionLabel == "V0.0") {
                        retriveForecastAfterMacro(name, versionLabel, modelType, notes);
                    }

                    else {
                        if (isLoadFlatFile == 3) {
                            isDownloadTemplate = 3;
                            downloadFile(document.all.OA1, name, versionLabel, true, "",
                                function (sPath, intermediatePath, notes) {
                                    modelPath = sPath;
                                    retriveForecastWithMacro(name, versionLabel, modelType, modelPath, notes);
                                }, isDownloadTemplate);
                        }
                        else {
                            retriveForecastWithMacro(name, versionLabel, modelType, modelPath, notes);
                        }
                    }
                       
                }, 500);
                enableButton();
            }

        catch (e) {
            Isinmiddleofretrieve = false;
                hideOverlay();
            }
    }

    function retriveForecastAfterMacro(name, versionLabel, modelType, notes)
    {
        if (!objExcel)
            return;

        isCreatedOrRetrieved = true;
        currentForecast.name = name;
        forecastVar = currentForecast.name;//for forecast reference
        currentForecast.version = versionLabel;
        versionVar = currentForecast.version;//for forecast reference
        if (modelType == 0 || modelType == 1) {
            try {
                objExcel.Workbooks(1).Worksheets("Generic_Forecast").Activate();
            }

            catch (e) {
                //eat exception
            }
        }
        saveNewForecast = false;
       // isCreateFlag = false;
       
        if (modelType == 0 || modelType == 1) {
            try {
                objExcel.Workbooks(1).Worksheets("Vars").Range("B18").Value = 1;
                objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value = currentForecast.name;
            }
            catch (e) {
                //eat exception
                hideOverlay();
            }
        }
        else {
            try {
                objExcel.Workbooks(1).Worksheets("Vars").Range("M1").Value = 1;
            }
            catch (e) {
                //eat exception
                hideOverlay();
            }
        }
        InitializeAssumptionAttachment();
        createSetAssumptionSections(getSectionDetails());
        if (notes)
            populateAssumptionSet(notes);
        getAssumptions(true);
     
        if (modelType == 1) {
            getSectionPreference(currentForecast.name, currentForecast.version);
        }
        isRetrieving = true;
        if (modelType == 0 || modelType == 1) {
            populateSelectedList();
        }
        else {
            populateIndicationListInActharModel(); //only for acthar model
        }
        updateProperties();
       // $('#Prdbox').css("display", "block");
        //$('#npvbox').css("display", "block");
    $('.navigationPane').css("display", "block");
    $('#saveasdesc').attr("placeholder", currentForecast.name);
    $('#saveasdesc').attr("title", currentForecast.name);
    enableButton();
    //hideOverlay();
    checkSectionTagEnable(true);
    isSharePermissionEnable(currentForecast.item);
    if (modelType == 0 || modelType == 1) {
        objExcel.Workbooks(1).Worksheets("Master_List").Range("B2").Value = currentForecast.name;
    }
    Isinmiddleofretrieve = false;
    updateScreen(true);
    applyAuthorization();
    //delete the temp folder in server -- getting logged out if we do this:please revisit
  	//  deleteIntermediate(intermediateFilePath);
    }

    function isSharePermissionEnable(item)
    {
        if (item && item.Access)
        {
          if(item.Access.SharedAccess)
            {
              for(var i = 0 ; i <item.Access.SharedAccess.length ; i++ )
              {
                  if (item.Access.SharedAccess[i].SharedWith.UserId == $('#btnprofile').attr("value"))
                  {
                      if (item.Access.SharedAccess[i].AuthorizationLevel)
                      {
                          if(item.Access.SharedAccess[i].AuthorizationLevel == 3 || item.Access.SharedAccess[i].AuthorizationLevel == 4)
                          {
                              //$('#sharebox a').addClass('disabled onclk');
                              //$('#sharebox').removeClass('sharepopup');
                             // $('#ShareResult').css("display", "none");
                              //$('#sharebox a').removeAttr('data-toggle');
                              //$('#sharebox a').removeAttr('data-target');
                              //$('#sharebox a').removeAttr('onclick');
                              $('#savebox a.enbdisbl').removeAttr('data-toggle');
                              $('#attdoc a.enbdisbl').removeAttr('data-toggle');
                              $('#savebox a').addClass('disabled onclk');
                              $('#attdoc a').removeAttr('onclick');
                              $('#attdoc a').addClass('disabled');
                              $('#savebox a').removeAttr('onclick');
                          }
                      }
                  }
              }
            }
        }

    }

    function deleteIntermediate(modelPath) {
        if (modelPath) {
            var finalPath = modelPath;
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/DeleteTempFileContainer", { fullFilePath: finalPath },
                function (deleteResult) {
                    //be silent
                    //hideEDraw();
                    var deleteSuccess = deleteResult.success;

                },
                function (deleteResult) {
                    //be silent
                    var deleteFailure = deleteResult;
                });
        }
    }

    function getSectionPreference(forecast , version)
    {
        var sectionsByOrder;
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetSectionPreference", { Forecast: forecast, Version: version, type: modelType },
            function (result) {
                if (result.success) {
                    //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nestable.js", function () {
                        createLeftPanelOfSections(result.SectionsOrderByUserId);
                        $('#nestable').nestable();
                        $('.dd').nestable('collapseAll');
                        $('#nestable .sidebar-nav-left').niceScroll({
                            cursorfixedheight: 70
                        });
                        $('#droppable').niceScroll({
                            cursorfixedheight: 70
                        });
                    //});                    
                }
            },
            function (result) {
               
            });
    }

    function createLeftPanelOfSections(sectionsByOrder)
    {
        var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
        var random = Math.round(Math.round(yoursystemday));
        if (!sectionsByOrder || sectionsByOrder.length == 0)
            return;
        $('.sidebar-nav-left>li.sectionslist').remove();
        $('#droppable>li.sectionslist').remove();

        var draggedFromHtml = '';
        var droppedToHtml = '';
        var draggedFrom = $('.sidebar-nav-left')[0];
        var droppedTo = $('#droppable')[0];
        var clonedSections = model.Sections.slice(0);
        for (var i = 0; i < sectionsByOrder.length; i++) {
            draggedFromHtml += getHtmlForSection(sectionsByOrder[i]);

            var index = clonedSections.inArray([{ property: 'Id', searchFor: sectionsByOrder[i].Id }]);
            if (index >= 0)
                clonedSections.splice(index, 1);
        }

        for (var i = 0; i < clonedSections.length; i++) {
            droppedToHtml += getHtmlForSection(clonedSections[i]);
        }

        draggedFrom.innerHTML += draggedFromHtml;
       droppedTo.innerHTML += droppedToHtml;
       

    }

    function getHtmlForSection(section) {
        var hasSubsections = section.SubSections != null && section.SubSections.length > 0;
        var str = '';
        var collapsedClass = '';
        if (hasSubsections)
            //collapsedClass = 'dd-collapsed';
            collapsedClass = '';

        str += '<li class="dd-item sectionslist {0}" data-id='.replace('{0}', collapsedClass) + section.Id + '>';
        if (hasSubsections) {
            str += '<button style="display: none;" type="button" data-action="collapse">Collapse</button>';
            str += '<button style="display: block;" type="button" data-action="expand">Expand</button>';
        }
        str += '<div class="dd-handle">';
        if (hasSubsections)
        {
            str += '<a href="#" id =' + section.Name.split(" ").join("").toLowerCase() + '   >' + section.Name + '</a>';

        }
        else {
            str += '<a href="#" id =' + section.Name.split(" ").join("").toLowerCase() + ' onmousedown="navigateToSection(' + section.Start
            + "," + "'" + section.Name + "'" + "," + "'" + section.Name.split(" ").join("").toLowerCase() + "'" + ')"  >' + section.Name + '</a>';

        }
        str += '</div>';
        if (hasSubsections) {
            str += '<ol class="dd-list">';
            for (var j = 0; j < section.SubSections.length; j++) {
                str += '<li class="no-dd-item" data-id= ' + section.SubSections[j].Id
                    + '><div class="no-dd-handle"><a href="#" class="ui-sortable-helper" id='
                    + section.SubSections[j].Name.split(" ").join("").toLowerCase()
                    + ' onmousedown="navigateToSection(' + section.SubSections[j].Start + ","
                    + "'" + section.SubSections[j].Name + "'" + "," + "'" + section.SubSections[j].Name.split(" ").join("").toLowerCase() + "'" + ')" >'
                    + section.SubSections[j].Name + '</a></div></li>';
            }
            str += '</ol>';
        }
        str += '<div style="position:absolute; right:10px; top:5px; cursor:pointer;"><a href="#" onclick="return inactiveFunction(event,this)"><i title="Click to remove" class="fa fa-chevron-down" aria-hidden="true"></i></a></div>';

        str += ' </li>';

        return str;
    }

    function applyAuthorization() {
        if (currentForecast.item && currentForecast.item.Access && currentForecast.item.Access.SharedAccess) //read only for the logged in user
            for (var i = 0; i < currentForecast.item.Access.SharedAccess.length; i++) {
                if (currentForecast.item.Access.SharedAccess[i].SharedWith.UserId == getLoggedInUserId() && currentForecast.item.Access.SharedAccess[i].AuthorizationLevel == 4) { //if readOnly
                    try{
                        // objExcel.Workbooks(1).Worksheets("Home").Range("T1").Value = 3;
                        var vbaMethod = "'{0}'!protect_for_readonly".replace("{0}", objExcel.Workbooks(1).Name);
                        runMacro(vbaMethod);
                    }
                    catch (e) {
                        //eat exception
                    }
                    break;
                }
               // break;
            }
    }
        
    function setDefaultValue() {
        if (!objExcel)
            return;

        var sheet1 = objExcel.Workbooks(1).Worksheets("Vars");
        var ele = document.getElementById('selectCountry');
        var ele1 = document.getElementById('selectScenario');
        var previousCountryValue = sheet1.Range("V3").Value;
        ele.selectedIndex = previousCountryValue - 1;
        var previousSenarioValue = sheet1.Range("BK1").Value;
        ele1.selectedIndex = previousSenarioValue - 1;
    }

    function projectOk() {
        if (!objExcel)
            return;

        projectOkCheck = true;
        showOverlay("Setting up the parameters...");
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 0 || modelType == 1) {
            try {

                if (isCountryChanged) {
                    isScenarioChanged = true;
                    try {
                        var countryDropdown = document.getElementById('selectCountry');                      
                        getAssumptionsForSections();
                        var sheet1 = objExcel.Workbooks(1).Worksheets("Vars");
                        sheet1.Range("V3").Value = countryDropdown.selectedIndex + 1;
                        createSetAssumptionSections(getSectionDetails());
                        getAssumptions(true);
                        updateProperties();
                        
                    }
                    catch (e) {
                        //eat exception
                        hideOverlay();
                    }
                   
                }
                if (isProductChanged) {
                    isSKUChanged = true;
                    isScenarioChanged = true;
                    try {
                        //sheet changes for product
                        var sheet = objExcel.Workbooks(1).Worksheets("Vars");
                        var ele = document.getElementById('selectProduct');
                        sheet.Range("N2").Value = ele.selectedIndex + 1;
                        sheet.Range("N3").Value = 1;
                        var sheet = objExcel.Workbooks(1).Worksheets("Vars_1");
                        sheet.Range("N1").Value = ele.selectedIndex + 1;
                        sheet.Range("N2").Value = 1;

                    }
                    catch (e) {
                        //eat exception
                        hideOverlay();
                    }

                    getAssumptionsForSections();
                    createSetAssumptionSections(getSectionDetails());
                    getAssumptions(true);
                    updateProperties();
                }

                if (isSKUChanged) {
                    try {
                        //sheet changes for for sku
                        var sheet = objExcel.Workbooks(1).Worksheets("Vars");
                        var ele = document.getElementById('selectSKU');
                        sheet.Range("N3").Value = ele.selectedIndex + 1;
                        var sheet = objExcel.Workbooks(1).Worksheets("Vars_1");
                        sheet.Range("N2").Value = ele.selectedIndex + 1;
                    }
                    catch (e) {
                        //eat exception
                        hideOverlay();
                    }
                }

                if (isScenarioChanged) {
                    var scenarioDropdown = document.getElementById('selectScenario');
                    if (modelType == 0) {
                        try {
                            //sheet change for scenario                    
                            var sheet1 = objExcel.Workbooks(1).Worksheets("Vars_1");
                            var productIndex = document.getElementById('selectProduct');
                            sheet1.Range("N11").Value = productIndex.selectedIndex + 1;
                            var SkuIndex = document.getElementById('selectSKU');
                            sheet1.Range("N12").Value = SkuIndex.selectedIndex + 1;
                            sheet1.Range("N13").Value = scenarioDropdown.selectedIndex + 1;
                            /** for checking data is present or not **/
                            var sheet = objExcel.Workbooks(1).Worksheets("Vars");
                            var ele = document.getElementById('selectScenario');
                            sheet.Range("N4").Value = ele.selectedIndex + 1;
                            var sheet = objExcel.Workbooks(1).Worksheets("Vars_1");
                            sheet.Range("N3").Value = ele.selectedIndex + 1;
                        }
                        catch (e) {
                            //eat exception
                            hideOverlay();
                        }
                    }
                    else if (modelType == 1) {
                        var sheet1 = objExcel.Workbooks(1).Worksheets("Vars");
                        sheet1.Range("BK1").Value = scenarioDropdown.selectedIndex + 1;
                    }
                    /**  check if data present or not **/
                    var dataIsInExcel = false;
                    var vbaMethod = "'{0}'!Scenario_DropDown_Message".replace("{0}", objExcel.Workbooks(1).Name);
                    var IsDataPresentInExcel = runMacro(vbaMethod);
                    if (IsDataPresentInExcel == 1) {
                        dataIsInExcel = true;
                        //hideOverlay();
                        //hideEDraw();
                    }
                    if (dataIsInExcel) {
                        bootbox.dialog({

                            message: "Do you want to use previous data?",
                            title: "",
                            closeButton: true,
                            size: 'large',
                            className: "custom-dialogue",
                            buttons: {

                                success: {
                                    label: "Yes",
                                    className: "btn-diabox",
                                    callback: function (result) {
                                        bootbox.hideAll();
                                        //hideEdraw();
                                        showOverlay("Setting up the parameters...");
                                       
                                        if (result) {
                                            objExcel.Workbooks(1).Worksheets("Home").Range("O1").Value = 1;
                                            setTimeout(function () {
                                                var vbaMethod = "'{0}'!Drop_Down_Change".replace("{0}", objExcel.Workbooks(1).Name);
                                                if (runMacro(vbaMethod))
                                                    updateFeed();
                                                hideOverlay();
                                                    //showEDraw();
                                                   
                                            }, 200);

                                        }
                                       
                                    }
                                },
                                danger: {
                                    label: "No",
                                    className: "btn-default",
                                    callback: function () {
                                        objExcel.Workbooks(1).Worksheets("Home").Range("O1").Value = 0;
                                        showOverlay("Setting up the parameters...");
                                        setTimeout(function () {
                                            var vbaMethod = "'{0}'!Drop_Down_Change".replace("{0}", objExcel.Workbooks(1).Name);
                                            if (runMacro(vbaMethod))
                                                updateFeed();
                                            hideOverlay();
                                            //showEDraw();
                                        }, 500);

                                    }
                                },
                            }
                        });

                    }
                    else {
                        objExcel.Workbooks(1).Worksheets("Home").Range("O1").Value = 0;
                        setTimeout(function () {
                            var vbaMethod = "'{0}'!Drop_Down_Change".replace("{0}", objExcel.Workbooks(1).Name);
                            //runMacro(vbaMethod)
                            //updateScreen(true);
                            if (runMacro(vbaMethod))
                               updateFeed();
                            hideOverlay();
                           // showEDraw();
                        }, 500);
                    }
                }
                else {
                    setTimeout(function () {
                        var vbaMethod = "'{0}'!Drop_Down_Change".replace("{0}", objExcel.Workbooks(1).Name);
                        if (runMacro(vbaMethod))
                            updateFeed();
                        hideOverlay();
                    }, 500);
                }
            }
            catch (e) {
                hideOverlay();
            }

            isCountryChanged = false;
            isProductChanged = false;
            isSKUChanged = false;
            isScenarioChanged = false;
        }
        else if (modelType == 2) {
            if (isIndication == true) {
                IsTotalIndication = false;
                try {
                    getAssumptionsForSections();
                    createSetAssumptionSections(getSectionDetails());
                    getAssumptions(true);
                    updateProperties();
                    var sheet = objExcel.Workbooks(1).Worksheets("Vars");
                    var indicationIndex = document.getElementById('selectIndication');
                    sheet.Range("M1").Value = indicationIndex.selectedIndex + 1;
                    var vbaMethod = "'{0}'!Dr_Down1_Change".replace("{0}", objExcel.Workbooks(1).Name);
                    runMacro(vbaMethod);
                    hideOverlay();
                }
                catch (e) {
                    hideOverlay();
                }

            }
            else if (IsTotalIndication == true) {
                isIndication = false;
                try {
                    getAssumptionsForSections();
                    createSetAssumptionSections(getSectionDetails());
                    getAssumptions(true);
                    updateProperties();
                    var sheet = objExcel.Workbooks(1).Worksheets("Vars");
                    var indicationIndex = document.getElementById('selectIndication');
                    sheet.Range("R1").Value = indicationIndex.selectedIndex + 1;
                    var vbaMethod = "'{0}'!Drp_Down_Total_Change".replace("{0}", objExcel.Workbooks(1).Name);
                    runMacro(vbaMethod);
                    hideOverlay();
                }
                catch (e) {
                    hideOverlay();
                }
            }

        }
    }

    function onProductUpdate() {
        try {
            loadSKU();
            loadScenario();
            isProductChanged = true;           
        }
        catch (e) {
            hideOverlay();
        }
    }
    function onSKUUpdate() {
        isSKUChanged = true;
    }
    function onScenarioUpdate() {
        isScenarioChanged = true;
    }
    function onCountryUpdate() {
        isCountryChanged = true;
    }
    function Edit() {
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var vbaMethod = "'{0}'!Create_Forecast_Generic_Edit".replace("{0}", objExcel.Workbooks(1).Name)
        if (runMacro(vbaMethod))
            updateScreen();
        populateSelectedList();
        if (type == 1) {
            var sheet = objExcel.Workbooks(1).Worksheets("Indication");
            var indicationValue = sheet.Range("A2").value;
            if (indicationValue) {
                applyBookMark(getSectionDetails());
            }
        }
    }

    //chart
    function openChart() {
        $('#chart_sku').empty();
        $('#selectSKU option').clone().appendTo('#chart_sku');
    }
    function openConsolidator() {
        $('#conso_product').empty();
        $('#selectProduct option').clone().appendTo('#conso_product');
    }
    function updateChartSku() {
        if (!objExcel)
            return;

        rememberChartValue = true;
        try{
            var sheet = objExcel.Workbooks(1).Worksheets("Vars");
            var ele = document.getElementById('chart_type');
            sheet.Range("N21").Value = ele.selectedIndex + 1;
            var ele = document.getElementById('chart_sku');
            sheet.Range("N24").Value = ele.selectedIndex + 1;
            var SkuValue = document.getElementById('chart_sku');
            chartConfig.SkuIndex = SkuValue.selectedIndex;
            var productValue = document.getElementById('chart_product');
            chartConfig.ProductIndex = productValue.selectedIndex;
            var vbaMethod = "'{0}'!Activate_GraphSheet".replace("{0}", objExcel.Workbooks(1).Name)
            if (runMacro(vbaMethod)) {
                objExcel.Workbooks(1).Worksheets("Graphs").Activate();
            }
        }
        catch (e) {
            //eat exception
        }
    }

    function updateChartBdl()
    {
        if (!objExcel)
            return;
       
        $('#waitMessageId').show();
        rememberChartValue = true;
        try {
            setTimeout(function () {
            var sheet = objExcel.Workbooks(1).Worksheets("Vars");
            var ele = document.getElementById('chart_parameter');
            sheet.Range("BV4").Value = ele.options[ele.selectedIndex].text;
            var chartProductVal = document.getElementById('chart_productbdl');
            sheet.Range("BV3").Value = chartProductVal.options[chartProductVal.selectedIndex].text;
            chartConfigBdl.productIndexBdl = chartProductVal.selectedIndex;
            var chartcountryVal = document.getElementById('chart_country');
            sheet.Range("BV2").Value = chartcountryVal.options[chartcountryVal.selectedIndex].text;
            chartConfigBdl.countryIndex = chartcountryVal.selectedIndex;
           
                var vbaMethod = "'{0}'!Activate_GraphSheet".replace("{0}", objExcel.Workbooks(1).Name)
                if (runMacro(vbaMethod)) {
                    objExcel.Workbooks(1).Worksheets("Graphs").Activate();
                    
                    //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("");
                    $('#waitMessageId').hide();
                    hideModal('chartModal');
                    
                    showEDraw();
                }
            }, 500);
        }
        catch (e) {
            //eat exception
        }
    }

    function InitializeAssumptionAttachment() {
        assumptionSet = null;
        attachmentMap = [];
    }
    function clidator() {
        if (!objExcel)
            return;

        showOverlay("Consolidating Forecast...");
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        try {
            setTimeout(function () {
                var vbaMethod = "'{0}'!Activate_Consolidater".replace("{0}", objExcel.Workbooks(1).Name)
                if (runMacro(vbaMethod)) {
                    if (type == 0 || type == 1) {
                        objExcel.Workbooks(1).Worksheets("Consolidator").Activate();
                    }
                    showEDraw();
                    hideOverlay();
                }
            }, 500);
        }
        catch (e) {
            hideOverlay();
        }
    }
    function clidation() {
        if (!objExcel)
            return;

        var vbaMethod = "'{0}'!Prod_Cons_Activate".replace("{0}", objExcel.Workbooks(1).Name)
        if (runMacro(vbaMethod))
            objExcel.Workbooks(1).Worksheets("Pro_Cons").Activate();
    }

    //print
    function printForecast() {
        OA1.PrintDialog();
        OA1.click();
    }
    function toggleFormulaBar(btnFormula) {
        if (!objExcel)
            return;

        $('#toolMenu').css("display", "none");
        var displayFormulaBar = objExcel.DisplayFormulaBar;
        if (displayFormulaBar == true) {
            objExcel.DisplayFormulaBar = false;
            btnFormula.title = "Show Formula Bar";
        }
        else {
            objExcel.DisplayFormulaBar = true;
            btnFormula.title = "Hide Formula Bar";
        }
        $('#mainheading').focus();
        $('#mainheading').click();
       showEDraw();
    }

    function checkSectionValidationInExcel()
    {
        if (!objExcel)
            return;

        var returnString = "";
        returnString = objExcel.Workbooks(1).Worksheets("Home").Range("A4").Value;
        if (returnString == "" || returnString == undefined || returnString == null)
            return;
        if(returnString != "NA")
        {
            bootbox.dialog({
                message: returnString,
                title: "",
                closeButton: true,
                size: 'small',
                className: "custom-dialogue",
                buttons: {
                    main: {
                        label: "OK",
                        className: "btn-dacancel",
                        callback: function () {
                            bootbox.hideAll();
                            showEDraw();
                            return;
                        }
                    }
                }
            });
        }
    }


    //save generic and bdl
    function saveExcel(callback) {
        tooltiponHover();
       checkSectionValidationInExcel();
        IsSaveOrRetrieve = true;
        saveNewForecast = false;
        isOfflineFlatFile = false;
        var nameOnly = getProject();
        var versionLabel = getVersion();
        if (versionLabel == -1)
            versionLabel = "V1";
        saveExcel1(callback);
        enableButton();
        setUnsaveCreateForecastName = false;
        $('.tollp').css("display", "block");
        $('.vcoment').css("display", "block");
        checkSectionTagEnable(true);
    }

    
    function GetdefaultComment() {
        var username = loginEmail;
        var dt = new Date();
         dt = dt.toString().replace(/:\d{2} GMT/, " GMT");
       // var datestring = dt.toString();
        //var date1 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(datestring));
        //var date2 = PHARMAACE.FORECASTAPP.UTILITY.convertUTCDateToLocalDate(new Date(dt));
        

       var dateStr = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(dt));
        //var dateStr1 = PHARMAACE.FORECASTAPP.UTILITY.formatDate(new Date(date2));
       // alert(dateStr);
        //alert(dateStr1);
        var description = "Saved By " + username + " at " + dateStr;
        return description;
    }
    function saveExcel1(callback) {
        var enableMinorVersion = false;
        var descr = document.getElementById('vDesc').value;
        if (document.getElementById('rbCustonVersion').checked) {
            enableMinorVersion = true
        }
            var projName = getProject();
            var projectnameRename = document.getElementById('saveasdesc').value;
            if (projectnameRename == '') {
                projectnameRename = projName;
            }
            else {
                projectnameRename = document.getElementById('saveasdesc').value;
            }

            if (projectnameRename != projName) {
                isSaveAsForecast = true;
                IsSaveAsForecast(enableMinorVersion, descr, projectnameRename);
            }
            else
                saveForecast(enableMinorVersion, descr, callback);

    }
    function isExcelResponding(){
        var vbaMethod = "'{0}'!GetGUID".replace("{0}", objExcel.Workbooks(1).Name);
        var guid = objExcel.Run(vbaMethod);
        var counter = 0;
        while (!guid) {
            setTimeout(function () { guid = objExcel.Run(vbaMethod); }, 3000);
            if (counter == 5) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please try again");
                return false;
            }
            else
                counter++;
        }

        return true;
    }
    function UploadFileToServer(oa, filePathWithExtension, postKeyValues, enableMinorVersion, versionDescription, callback) {
        if (!objExcel)
            return;

        //if (checkJSNetConnection() == false) {
        //   hideOverlay();
        //   onJSButtonclick(0);
        //}
        //else {
        //first, check if you are connected and logged in to the application
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/IsSignedIn", null,
            function (result) {
                if (result.success) {
                    //oa.focus();
                    //oa.click();
                    //updateScreen();
                    oa.HttpInit();
                    oa.HttpAddPostFile(filePathWithExtension);
                    //if (oa && postKeyValues) {
                    //    for (var i = 0; i < postKeyValues.length; i++)
                    //        oa.HttpAddPostString(postKeyValues[i].key, postKeyValues[i].value);
                    //}
                    setTimeout(function () {
                        var res = oa.HttpPost(baseUrl + "/Forecast/SaveTempFile");
                        try {
                            var vbaMethod = "'{0}'!Application_Event_Handler_Script".replace("{0}", objExcel.Workbooks(1).Name);
                            runMacro(vbaMethod);
                        }
                        catch (e) {
                            //eat exception:
                            //even if calculation is not done, not everything is lost, go ahead and retrieve the saved stuff, calculation will happen then anyways
                        }
                        uploadAttachments(postKeyValues, function () {
                            if (enableMinorVersion != undefined) {
                                if (saveNewForecast != true) {
                                    var parts = filePathWithExtension.split("\\");
                                    var nameOnly = parts[parts.length - 1];
                                    saveNewForecast = false;
                                    //if (document.OA1.GetErrorCode() == 200) {
                                    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
                                    if (isSaveAsForecast) {
                                        //currentForecast.name = projectnameRename; 
                                        var projectnameRename = currentForecast.name;
                                        var saveAsVersion = getExpectedVersionForSaveAs(enableMinorVersion, false, projectnameRename);
                                        var splitByV = saveAsVersion.split('V');
                                        var excelVersionWithoutV = '';
                                        var excelVersion = '';
                                        if (splitByV || splitByV.length > 0) {
                                            var lastElementIndex = splitByV.length - 1;
                                            excelVersionWithoutV = splitByV[lastElementIndex];
                                            excelVersion = "V" + excelVersionWithoutV;
                                            currentForecast.version = excelVersion;
                                        }
                                    }
                                    else {
                                        try {
                                            if (type == 0 || type == 1)                           // acthar 
                                            {
                                               // currentForecast.version = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("L2").Value;
                                            }
                                            else {
                                                var expectedForecastVersion = getExpectedVersion(enableMinorVersion, false);
                                                var splitByV = expectedForecastVersion.split('V');
                                                var excelVersionWithoutV = '';
                                                var excelVersion = '';
                                                if (splitByV || splitByV.length > 0) {
                                                    var lastElementIndex = splitByV.length - 1;
                                                    excelVersionWithoutV = splitByV[lastElementIndex];
                                                    excelVersion = "V" + excelVersionWithoutV;
                                                    currentForecast.version = excelVersion;

                                                }
                                            }
                                        }
                                        catch (e) {
                                            //eat exception
                                        }
                                    }
                                }
                            }
                            else if (saveNewForecast == true) {
                                createForecastAfterUpload();
                            }
                            checkForecastSavedOrNot(nameOnly, enableMinorVersion, callback);
                        });
                    }, 3000);
                }
                else {
                    hideOverlay();
                    onJSButtonclick(1);
                }
                },
                function (result) {
                    hideOverlay();
                    onJSButtonclick(1);
                });
            //}
    }

    function createForecastAfterUpload()
    {
        var argumentsArray = [];
        isCreatedOrRetrieved = true;
        InitializeAssumptionAttachment();
        createSetAssumptionSections(getSectionDetails());
        updateScreen();
        showEDraw();
        populateSelectedList();
        enableButton();
        hideOverlay();
       // $('#Prdbox').css("display", "block");
        $('#newbutton').addClass('imageclickdisable');
        $('#saveasdesc').attr("placeholder", '');
        $('#saveasdesc').attr("placeholder", currentForecast.name);
        $('#saveasdesc').attr("title", currentForecast.name);
        $('.navigationPane').css("display", "block");
        updateProperties();
        //PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nestable.js", function () {
            $('#nestable').nestable();
            $('.dd').nestable('collapseAll');
        //});
            if (offlineSave != true)
                argumentsArray.push("Project ", currentForecast.name, " created", "successfully");
            handleSaveError(13, argumentsArray)
        //PHARMAACE.FORECASTAPP.UTILITY.popalert("Project {0} created successfully".replace("{0}", currentForecast.name));
    }

    function checkForecastSavedOrNot(nameOnly, enableMinorVersion, callback)
    {
                   if (isSaveAsForecast)
                       RefreshModelForSync(enableMinorVersion, callback);
                   else
                       RefreshModel(nameOnly, enableMinorVersion, callback);
                       hideOverlay();             
               }

    function resolveVersion() {
        if (!objExcel)
            return;

        var onlineVersion = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("L2").Value;
        var offlineVersion = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("I2").Value;
        if (!onlineVersion) {
            if (offlineVersion)
                return offlineVersion;
        }
        else if (!offlineVersion) {
            if (onlineVersion)
                return onlineVersion;
        }
        else { //both onlineversion and offlineversion exist
            var onlineVersionNumber = onlineVersion.replace('V', '');
            var offlineVersionNumber = offlineVersion.replace('V', '');
            if (isNaN(onlineVersionNumber))
                return offlineVersion;
            if (isNaN(offlineVersionNumber))
                return onlineVersion;
            var onlineMajorMinor = getMajorMinorFromVersionLabel(onlineVersion);
            var offlineMajorMinor = getMajorMinorFromVersionLabel(offlineVersion);            
            if (onlineMajorMinor.major > offlineMajorMinor.major)
                    return onlineVersion;
            if (offlineMajorMinor.major > onlineMajorMinor.major)
                    return offlineVersion;
            if (offlineMajorMinor.major == onlineMajorMinor.major) {
                if (!offlineMajorMinor.minor)
                    offlineMajorMinor.minor = 0;
                if (!onlineMajorMinor.minor)
                    onlineMajorMinor.minor = 0;
                if (onlineMajorMinor.minor > offlineMajorMinor.minor)
                        return onlineVersion;
                    else
                        return offlineVersion;
                }
            
        }

        return "V0.0";
    }

    function buildUserForecastToSave(versionDescription) {        
        var userForecast = {
            Forecast: getProject(),
            Versions: [{
                Label: currentForecast.version,
                Comment: versionDescription,
                Access: {
                    Creator: { UserId: getLoggedInUserId() }
                }
            }]
        };
        return userForecast;
    }

    function getLoggedInUserId(){
        return $('#btnprofile').attr("value");
    }

    function buildUserForecastToShare(sharedWithId, authorization, versionDescription, projectName, version, email, LoggedFirstname, LoggedLastname) {
        var userForecast;
            version = version;
            userForecast = {
                Forecast: projectName,
                Versions: [{
                Label: version,
                    Comment: versionDescription,
                    Access: {
                        SharedAccess: [{
                            SharedWith: { UserId: sharedWithId },
                            SharedBy: { UserId: $('#btnprofile').attr("value") },
                            AuthorizationLevel: authorization
                        }]
                    }
                }],
                UserEmail: email,
                LoggedInUserName: LoggedFirstname + " " + LoggedLastname
            };

        return userForecast;
    }

    function refreshUserForecastShared(sharedWithId, authorization, name, email)
    {
        var item = currentForecast.item;
        //var date = item.Access.CreatedOn;
        var userForecastShared = [];
        var  sharedWithIdAvailabel=false;

        for(var i = 0; i < item.Access.SharedAccess.length; i++)
        {
            if(item.Access.SharedAccess[i].SharedWith.UserId == sharedWithId)
            {
                item.Access.SharedAccess[i].SharedWith.AuthorizationLevel = authorization;
                sharedWithIdAvialabe=true;
            }
        }
        if (!sharedWithIdAvailabel)
        {
            var parts = name.split(" ");
            var firstname = parts.shift();
            var lastname = parts.shift() || "";
            var userForecastUnShare = {   
                    AuthorizationLevel: authorization,
                    SharedBy: { UserId: $('#btnprofile').attr("value") },
                    sharedOn: { Date: item.Access.CreatedOn },
                    SharedWith: { UserId : sharedWithId, FirstName : firstname, LastName : lastname , Email : email }
                
            }
        }
        return userForecastUnShare;
       }
        

    function createForecastToServer(filePathWithExtension,projectName)
    {
        var postKeyValues = [];
        var extension = 'xlsb';
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        postKeyValues[0] = { key: "Name", value: projectName + '.' + extension };
        postKeyValues[1] = { key: "type", value: type };
        postKeyValues[2] = { key: "isCreateFlag", value: saveNewForecast ? 1 : 0 };
        UploadFileToServer(document.all.OA1, filePathWithExtension, postKeyValues, undefined, undefined);
    }

    function SaveForecastToServer(filePathWithExtension, enableMinorVersion, versionDescription, saveAsName, callback) {
        var postKeyValues = [];
        var isMajorVersion;
        var extension = PHARMAACE.FORECASTAPP.UTILITY.getFileExtension(filePathWithExtension);
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (isSaveAsForecast)
            postKeyValues[0] = { key: "Name", value: saveAsName + '.' + extension };
        else
           postKeyValues[0] = { key: "Name", value: getProject() + '.' + extension };
        if (enableMinorVersion != undefined) {
            if (enableMinorVersion == false)
                isMajorVersion = 1;
            else
                isMajorVersion = 0;
            postKeyValues[1] = { key: "MajorVersion", value: isMajorVersion };
        }        
        postKeyValues[2] = { key: "type", value: type };
        postKeyValues[3] = { key: "isCreateFlag", value: saveNewForecast ? 1 : 0 };
        postKeyValues[4] = { key: "Description", value: versionDescription };
        var results = [];
        var sectionList = $("#nestable>ol:eq(0)>li");
        for (var i = 0; i < sectionList.length; i++) {
            results.push($(sectionList[i]).attr("data-id"));
        }
        var sectionIDsPipeseperated = results.join("|");
        postKeyValues[5] = { key: "SectionsOrder", value: sectionIDsPipeseperated }
        if (isSaveAsForecast) {
            postKeyValues[6] = { key: "TemplateNameForSaveAs", value: getProject() };
            postKeyValues[7] = { key: "IsSaveAsForecast", value: isSaveAsForecast ? 1 : 0 }
            currentForecast.name = saveAsName;
        }
        UploadFileToServer(document.all.OA1, filePathWithExtension, postKeyValues, enableMinorVersion, versionDescription, callback);
    }

   
    function getSectionDetailsForAttchment()
    {
        var sections = [];
        for (var i = 0; model.Sections && i < model.Sections.length; i++) {
            if (model.Sections[i].HasAssumption) {
                var section = { name: model.Sections[i].Name, start: model.Sections[i].Start, end: model.Sections[i].End };
                sections.push(section);
            }
            if (model.Sections[i].SubSections) {
                for (var j = 0; j < model.Sections[i].SubSections.length; j++) {
                    if (model.Sections[i].SubSections[j].HasAssumption) {
                        if (model.Sections[i].SubSections[j].Parent)
                            var section = {
                                name: model.Sections[i].Name + "_" + model.Sections[i].SubSections[j].Name, start: model.Sections[i].SubSections[j].Start,
                                end: model.Sections[i].SubSections[j].End
                            };
                        sections.push(section);
                    }
                }
            }
        }

        return sections;
    }

    function getSectionDetails() {
        var sections = [];
        for (var i = 0; i < model.Sections.length; i++) {
            if (model.Sections[i].HasAssumption) {
                var section = { name: model.Sections[i].Name, start: model.Sections[i].Start, end: model.Sections[i].End };
                sections.push(section);
            }
            if (model.Sections[i].SubSections) {
                for (var j = 0; j < model.Sections[i].SubSections.length; j++) {
                    if (model.Sections[i].SubSections[j].HasAssumption) {
                        var section = {
                            name: model.Sections[i].SubSections[j].Name, start: model.Sections[i].SubSections[j].Start,
                            end: model.Sections[i].SubSections[j].End
                        };
                        sections.push(section);
                    }
                }
            }
        }

        return sections;
    }
    
    function fillAssumptions(useCache) {
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (assumptionSet == null || assumptionSet.length == 0) {
            return;
        }
        var prodIndex = getProductIndex(useCache);
        var scenario = getScenarioIndex();
        var prodIndex = getProductIndex(useCache);
        var sectionCount = $('.section_note_write').length;
        var startIndex = (prodIndex - 1) * sectionCount;
        if (!attachmentMap)
            attachmentMap = [];
        for (var i = startIndex; i < startIndex + sectionCount; i++) {
            if (!attachmentMap[i])
                attachmentMap[i] = [];
        }
        for (var i = startIndex; i < startIndex + sectionCount; i++) {
            if (type == 0 || type == 1)
                {
                if (assumptionSet[i] && assumptionSet[i].Product == prodIndex) {
                    var order = startIndex + assumptionSet[i].Section - 1;
                    var sectionOrder = assumptionSet[i].Section - 1;
                    var desc = assumptionSet[i].Description;
                    if (desc && desc.length > 0)
                        $('.editable-div:eq(' + sectionOrder + ')').val(desc);
                    if (assumptionSet[i].Attachments && assumptionSet[i].Attachments.length > 0) {
                        for (var j = 0; j < assumptionSet[i].Attachments.length; j++) {
                            if (assumptionSet[i].Attachments[j].AttachmentPath && $.trim(assumptionSet[i].Attachments[j].AttachmentPath.length) > 0) {
                                attachmentMap[order][j] = {};
                                attachmentMap[order][j].name = assumptionSet[i].Attachments[j].AttachmentName;
                                attachmentMap[order][j].source = assumptionSet[i].Attachments[j].AttachmentPath;
                                attachmentMap[order][j].url = assumptionSet[i].Attachments[j].AttachmentPath;
                            }
                        }
                    }
                }
        }
         else
        {
                if (assumptionSet[i] && assumptionSet[i].Indication == prodIndex) {
                    var order = startIndex + assumptionSet[i].Section - 1;
                    var sectionOrder = assumptionSet[i].Section - 1;
                    var desc = assumptionSet[i].Description;
                    if (desc && desc.length > 0)
                        $('.editable-div:eq(' + sectionOrder + ')').val(desc);
                    if (assumptionSet[i].Attachments && assumptionSet[i].Attachments.length > 0) {
                        for (var j = 0; j < assumptionSet[i].Attachments.length; j++) {
                            if (assumptionSet[i].Attachments[j].AttachmentPath && $.trim(assumptionSet[i].Attachments[j].AttachmentPath.length) > 0) {
                                attachmentMap[order][j] = {};
                                attachmentMap[order][j].name = assumptionSet[i].Attachments[j].AttachmentName;
                                attachmentMap[order][j].source = assumptionSet[i].Attachments[j].AttachmentPath;
                                attachmentMap[order][j].url = assumptionSet[i].Attachments[j].AttachmentPath;
                            }
                        }
                    }
                }
        }
        }
        updateAttachmentIcons();
    }
    function loadAssumptionSections() {
        createSetAssumptionSections(getSectionDetails());
    }
    function textAreaAdjust(o) {
        o.style.height = "1px";
        o.style.height = (25 + o.scrollHeight) + "px";
    }
    function openIndicationInfo() {
        var sheet = null;
        var isIndicationEnabled = true;
        try {
            //this sometimes gives "System call failed" exception in Excel 2013, hence the try-catch
            sheet = objExcel.Workbooks(1).Worksheets("Indication");
        }
        catch (ex) {
            try {
                sheet = objExcel.Workbooks(1).Worksheets("Indication");
            }
            catch (ex) {
                isIndicationEnabled = false;
            }
        }
        var indicationValue = "";
        if(sheet)
            indicationValue = sheet.Range("A2").value;
        var link = 'ForecastReference?type=1&indicationValue={0}&forecast={1}&version={2}'.replace('{0}', encodeURI(indicationValue)).replace('{1}', forecastVar).replace('{2}', versionVar);
        var win = window.open(link, '_blank');
        win.focus();
    }
    function createSetAssumptionSections(sections) {
        //if (!objExcel)
        //    return;

        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (model.DisplayInitialModel)
            return;

        var ele = document.getElementById('set_assumptions');
        if ($('#set_assumptions>div').length > 0) {
            clearAllAttachmentsAndAssumptions();
        }
        else{
            for (var i = 0; i < sections.length; i++) {
                if (type == 0 || type == 2) {
                    var str = '<div class="banner section_note_write"><div class="panel panel-default"><div class="panel-heading">' + sections[i].name + '</div><div class="panel-body-assumption">';
                }
                else {
                    var strClass = "assump-" + sections[i].name.replace(/\s+/g, "-").toLowerCase();
                    var strHref = "active-" + sections[i].name.replace(/\s+/g, "").toLowerCase() + "#" + sections[i].name.replace(/\s+/g, "").toLowerCase();
                    var str = '<div class="banner section_note_write"><div class="panel panel-default"><div class="panel-heading">' + sections[i].name;

                    str += '<a href=#' + ' class="  ' + strClass + ' pull-right" >';
                    str += '<img src="../../Content/img/icon-book.png" class="indicationimg" onclick="openIndicationInfo()" /></a></div><div class="panel-body-assumption">';
                }
                str += '<div class="maxheight">';
                // str += '<div contenteditable="true" class="editable-div" onclick="expandableDiv();" placeholder="' + sections[i].name + ' Notes"></div>';
                str += '<textarea contenteditable="true" onkeyup="textAreaAdjust(this)" style="overflow:hidden" class="editable-div" onclick="expandableDiv();"></textarea>';
                str += '</div><div class="attach-box"><ul class="list-inline attachment_icons"></ul></div>';
                str += '</div></div></div>';

                if (i == 0)
                    ele.innerHTML = str;
                else
                    ele.innerHTML = ele.innerHTML + str;
            }
            str1 = '<div class="banner "><div class="maxheight">';
            str1 += '<div class="padding-box"><div class="col-md-12 no-padding-left"><span>Properties</span></div></div>';
            str1 += '<div class="padding-box"><div class="col-md-4 no-padding-left">Info</div><div class="col-md-8 no-padding-right" id="version_detail">version info</div></div>';
            str1 += '<div class="padding-box "><div class="col-md-4 no-padding-left">Comment</div><div class="col-md-8 no-padding-right" id="version_desc">version comment</div></div>';
            str1 += '</div> </div>';
            str1 += '<div class="banner "><div class="maxheight">';
            str1 += '<div class="padding-box"><div class="col-md-12 no-padding-left"><span>Related Date</span></div></div>';
            str1 += '<div class="padding-box"><div class="col-md-4 no-padding-left">Created</div><div class="col-md-8 no-padding-right" id="created_on">created</div></div>';
            str1 += '<div class="padding-box "><div class="col-md-4 no-padding-left">Modified</div><div class="col-md-8 no-padding-right" id="modified_on">Modified</div></div>';
            str1 += '</div> </div>';
            str1 += '<div class="banner "><div class="maxheight">';
            str1 += '<div class="padding-box"><div class="col-md-12 no-padding-left"><span>Related People</span></div></div>';
            str1 += '<div class="padding-box"><div class="col-md-4 no-padding-left">Author</div><div class="col-md-8 no-padding-right" id="author_id">forecast author</div></div>';
            str1 += '<div class="padding-box "><div class="col-md-4 no-padding-left">Modifier</div><div class="col-md-8 no-padding-right" id="modifier_id">version modifier</div></div>';
            str1 += '<div class="padding-box "><div class="col-md-4 no-padding-left">Shared</div><div class="col-md-8 no-padding-right" id="shared_with"> - </div> </div> </div> </div>';
            ele.innerHTML = ele.innerHTML + str1;
        }
    }
    function expandableDiv() {
        if (!$('.taskPane').hasClass("isCollapsed")) {
            $('#divNotes').addClass('hideprodfeed');
            updateScreen(true);
            $('.taskPane .toggleBtn').toggleClass("isCollapsed", 800);
            $('.taskPane').toggleClass("isCollapsed");
            if ($('.taskPane').hasClass('isCollapsed')) {
                //$('.visualizationPane').css("display", "block");
                $('.visualizationPane').css("width", "330px");

                $('#selectedassumption').val('1');
            }
        }
    }
    function applyBookMark(sections) {
        if (!objExcel)
            return;

        for (var i = 0; i < sections.length; i++) {
            var sheet = objExcel.Workbooks(1).Worksheets("Indication");
            var indicationValue = sheet.Range("A2").value;
            if (indicationValue) {
                var strClass = "assump-" + sections[i].name.replace(/\s+/g, "-").toLowerCase();
                var strHref = "active-" + sections[i].name.replace(/\s+/g, "").toLowerCase() + "#" + sections[i].name.replace(/\s+/g, "").toLowerCase();
                var link = 'ForecastReference?type=0&indicationValue={0}&href={1}';
                
                if (!$("#set_assumptions .section_note_write .panel-heading img:eq(" + i + ")").hasClass('indicationimg')) {
                    $("#set_assumptions .section_note_write .panel-heading:eq(" + i + ")").append('<a href=' + link.replace('{0}', encodeURI(indicationValue)).replace('{1}', strHref) + ' target ="_blank" class="  ' + strClass + ' pull-right" ><img src="../../Content/img/icon-book.png" class="indicationimg"/></a>');
                }
            }
           
        }      
    }

    function getAssumptionsForSections(useCache) {
        var prodIndex = getProductIndex(useCache);
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (!assumptionSet)
            assumptionSet = [];
        var fileInputs = document.getElementsByClassName('file_write');
        var sectionCount = $('.section_note_write').length;
        var startIndex = (prodIndex - 1) * sectionCount;
        for (var i = startIndex; i < startIndex + sectionCount; i++) {
            var attachments = [];
            if (attachmentMap) {
                if (attachmentMap[i]) {
                    for (var j = 0; j < attachmentMap[i].length; j++) {
                        if (attachmentMap[i][j].name)
                            attachments[j] = { AttachmentName: attachmentMap[i][j].name, AttachmentPath: attachmentMap[i][j].url, LocalPath: attachmentMap[i][j].localFullPath };
                        else
                            attachments[j] = {};
                    }
                }
            }
            var actualIndex = i - startIndex;
             var desc = $('.section_note_write>div:eq(' + actualIndex + ')>div:eq(1)>div:eq(0)>textarea').val();
            //var desc = $('.section_note_write>div:eq(' + actualIndex + ')>div:eq(1)>div:eq(0)>div').text();
             var html = desc;//urlify(desc);
            if (type == 0 || type == 1) {
                assumptionSet[i] = {
                    Project: getProject(),
                    Version: getLatestVersionLabel(),
                    Product: prodIndex,
                    SKU: getSKUIndex(),
                    Scenario: getScenarioIndex(),
                    Section: actualIndex + 1,
                    Description: html
                };
            } else if(type == 2)
            {
                assumptionSet[i] = {
                    Project: getProject(),
                    Version: getLatestVersionLabel(),
                    Indication: prodIndex,
                    Section: actualIndex + 1,
                    Description: html
                };
            }
                if (attachments && attachments.length > 0) {
                    assumptionSet[i].Attachments = attachments;
                }
        } 
        }
    

    function urlify(text) {
        if (text) {
            var urlRegex = /(\b(http|https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
            return text.replace(urlRegex, function (url) {
                return '<div contentEditable="false"><a href="' + url + '" target="_blank">' + url + '</a></div>';
            });
            // or alternatively
            // return text.replace(urlRegex, '<a href="$1">$1</a>')
        }
        else
            return "";
    }

    function populateAllAttachments() {
        if (!assumptionSet)
            assumptionSet = [];
        if (attachmentMap) {
            for (var i = 0; i < attachmentMap.length; i++) {
                var attachments = [];
                if (attachmentMap[i]) {
                    for (var j = 0; j < attachmentMap[i].length; j++) {
                        if (attachmentMap[i][j].name)
                            attachments[j] = { AttachmentName: attachmentMap[i][j].name, AttachmentPath: attachmentMap[i][j].url };
                        else
                            attachments[j] = {};
                    }
                }
                if (attachments && attachments.length > 0) {
                    assumptionSet[i].Attachments = attachments;
                }
            }
        }
    }
    function IssaveForecast(callback) {
        bootbx = bootbox.dialog({
            message: "Do you want to save your work before proceeding?",
            title: "",
            closeButton: true,
            size: 'small',
            className: "custom-dialogue",
            buttons: {
                success: {
                    label: "Yes",
                    className: "btn-diabox",
                    callback: function (result) {
                        if (result) {
                            saveExcel(callback);
                        }
                    }
                },
                danger: {
                    label: "No",
                    className: "btn-default",
                    callback: function () {
                        $('.bootbox').modal('hide');
                        callback();
                    }
                },
                main: {
                    label: "Cancel",
                    className: "btn-dacancel",
                    callback: function () {
                        bootbox.hideAll();
                    }
                }
            }
        });
        enableButton();
    }

    function RefreshModelForSync(enableMinorVersion) {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/ForecastEntity", { type: modelType },
            function (result) {
                if (result.success) {
                    model = result.entity;
                    populateControls();
                    projectnameRename = getProject();
                    var expectedVersion = getExpectedVersionForSaveAs(enableMinorVersion, false, projectnameRename);
                    var splitByV = expectedVersion.split('V');
                    var excelVersionWithoutV = '';
                    var excelVersion = '';
                    if (splitByV || splitByV.length > 0) {
                        var lastElementIndex = splitByV.length - 1;
                        excelVersionWithoutV = splitByV[lastElementIndex];
                        excelVersion = "V" + excelVersionWithoutV;
                        currentForecast.version = excelVersion;
                    }
                    updateProperties();
                    if (isSaveAsForecast) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Forecast saved successfully", '');
                    }
                }
                else {
                }
                hideOverlay();
            },
            function (result) {
                hideOverlay();

            });
    }
    function RefreshModel(nameOnly, enableMinorVersion, callback) {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/ForecastEntity", { type: modelType },
            function (result) {
                if (result.success) {
                    if (isRefreshedModel) {
                        model = result.entity;
                        isRefreshedModel = false;
                        hideEDraw();
                        currentForecast.item = getItemInModelByNameAndVersion(currentForecast.name, currentForecast.version);
                        updateProperties();
                    }
                    else {
                        model = result.entity;
                        if (nameOnly != undefined || enableMinorVersion != undefined) {
                            populateControls();
                            var desiredValue = getProject();
                            currentForecast.item = getItemInModelByNameAndVersion(currentForecast.name, currentForecast.version);
                            updateProperties();
                            if (callback)
                                callback();
                        }
                    }
                }
                else {

                }
                hideOverlay(true);
            },
            function (result) {
                hideOverlay(true);
            });
    }

    function clearAttachments() {
        var fileInputs = document.getElementsByClassName('file_write');
        for (var i = 0; i < fileInputs.length; i++) {
            fileInputs[i].title = "";
        }
    }
    function mapAttachmentsBeforeSave() {
        for (var i = 0; i < assumptionSet.length; i++) {
            if (assumptionSet[i]) {
                assumptionSet[i].Project = currentForecast.name;
                assumptionSet[i].Version = currentForecast.version;
                if (!attachmentMap[i] || attachmentMap[i].length == 0)
                    assumptionSet[i].Attachments = [];
                else {
                    for (var j = 0; j < assumptionSet[i].Attachments.length; j++) {
                        assumptionSet[i].Attachments[j].AttachmentPath = attachmentMap[i][j].url;
                    }
                }
            }
        }
    }

    function getExpectedVersion(enableMinorVersion, refreshed, updateVersion) {
        //TO DO : check for 512
        var expectedVersion = currentForecast.name;
        var majorMinor;
        var versionFromDropdown = getLatestVersionLabel().replace('V', '');
        var majorMinorFromDropdown = versionFromDropdown.split(".");
        var majorMinorCurrent = currentForecast.version.replace('V', '').split(".");
        if (parseInt(majorMinorFromDropdown[0]) > parseInt(majorMinorCurrent[0]))
            majorMinor = majorMinorFromDropdown;
        else if (parseInt(majorMinorFromDropdown[0]) < parseInt(majorMinorCurrent[0]))
            majorMinor = majorMinorCurrent;
        else
        {
            if (!majorMinorFromDropdown[1])
                majorMinorFromDropdown[1] = 0;
            if (!majorMinorCurrent[1])
                majorMinorCurrent[1] = 0;
            if (parseInt(majorMinorFromDropdown[1]) > parseInt(majorMinorCurrent[1]))
                majorMinor = majorMinorFromDropdown;
            else 
                majorMinor = majorMinorCurrent;
        }

        if (majorMinor.length == 2) {
            if (enableMinorVersion == true) {
                var intMinor;
                if (refreshed == true)
                    intMinor = parseInt(majorMinor[1]);
                else
                    intMinor = parseInt(majorMinor[1]) + 1;
                if (intMinor > 512) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Minor versions cannot be more than 512.", '');
                    return false;
                }
                if (updateVersion)
                    currentForecast.version = "V" + majorMinor[0] + "." + intMinor;
                expectedVersion += " V" + majorMinor[0] + "." + intMinor;
            }
            if (enableMinorVersion == false) {
                var intMajor;
                if (refreshed == true)
                    intMajor = parseInt(majorMinor[0]);
                else
                    intMajor = parseInt(majorMinor[0]) + 1;
                if (updateVersion)
                    currentForecast.version = "V" + intMajor + ".0";
                expectedVersion += " V" + intMajor + ".0";
            }
        }
        return expectedVersion;
    }

    function getExpectedVersionForSaveAs(enableMinorVersion, updateVersion, projectnameRename) {
        //TO DO : check for 512
        currentForecast.version = 'V0.0';
        var expectedVersion = projectnameRename;
        var majorMinor = currentForecast.version.replace('V', '').split(".");
        if (majorMinor.length == 2) {
            if (enableMinorVersion == true) {
                var intMinor = parseInt(majorMinor[1]) + 1;
                if (intMinor > 512) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Minor versions cannot be more than 512.", '');
                    return false;
                }
                if (updateVersion)
                    currentForecast.version = "V" + majorMinor[0] + "." + intMinor;
                expectedVersion += " V" + majorMinor[0] + "." + intMinor;
            }
            if (enableMinorVersion == false) {
                var intMajor = parseInt(majorMinor[0]) + 1;
                if (updateVersion)
                    currentForecast.version = "V" + intMajor + ".0";
                expectedVersion += " V" + intMajor + ".0";
            }
        }
        return expectedVersion;
    }
    function IsSaveAsForecast(enableMinorVersion, versionDescription, projectnameRename) {
        if (!objExcel)
            return;

        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        showOverlay("Saving Forecast " + projectnameRename + ". This may take a few moments...");
        setTimeout(function () {
            try {
                objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value = projectnameRename;
                objExcel.Workbooks(1).Worksheets("Master_List").Range("B2").Value = projectnameRename;
                if (type == 1) {
                    objExcel.Workbooks(1).Worksheets("Vars").Range("A2").Value = projectnameRename;
                }
                var vbaMethod = "'{0}'!Save_Forecast".replace("{0}", objExcel.Workbooks(1).Name);
                var filePathWithExtension = runMacro(vbaMethod);
                //objExcel.EnableEvents = false;
                if (filePathWithExtension && filePathWithExtension.length > 0)
                    SaveForecastToServer(filePathWithExtension, enableMinorVersion, versionDescription, projectnameRename);
            }
            catch (e) {
                hideOverlay();
            }
        }, 500);
    }

    function saveForecast(enableMinorVersion, versionDescription, callback) {
        if (!objExcel)
            return;
        //PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/IsSignedIn", null,
        //   function (result) {
        //       if (result.success) {
                   var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
                   isSaveAsForecast = false;
                   var expectedForecastVersion = getExpectedVersion(enableMinorVersion, false);
                   if (expectedForecastVersion == false)
                       return;
                   //showOverlay("Saving Forecast " + currentForecast.name + " to its next version...");
                   showOverlay("Saving forecast " + currentForecast.name + ". This may take a few moments...");
                   setTimeout(function () {
                       try {
                           if (type == 0 || type == 1) {               // acthar
                               var splitByV = expectedForecastVersion.split('V');
                               var excelVersionWithoutV = '';
                               var excelVersion = '';
                               if (splitByV || splitByV.length > 0) {
                                   var lastElementIndex = splitByV.length - 1;
                                   excelVersionWithoutV = splitByV[lastElementIndex];
                                   excelVersion = "V" + excelVersionWithoutV;
                               }
                               objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("L2").Value = excelVersion;
                               if (type == 1)
                                   objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("I2").Value = excelVersion;
                           }
                           if (type == 2) {
                               objExcel.Workbooks(1).Worksheets("Vars").Range("A1").Value = currentForecast.name;
                           }
                           var vbaMethod = "'{0}'!Save_Forecast".replace("{0}", objExcel.Workbooks(1).Name);
                           var filePathWithExtension = runMacro(vbaMethod);
                           var extension = PHARMAACE.FORECASTAPP.UTILITY.getFileExtension(filePathWithExtension);
                           if (filePathWithExtension && filePathWithExtension.length > 0) {
                               if (extension == 'xlsb') {
                                   SaveForecastToServer(filePathWithExtension, enableMinorVersion, versionDescription, null, callback);
                               }
                               else {
                                   hideOverlay();
                                   hideEDraw();
                                   bootbox.dialog({
                                       message: "Output format is incorrect",
                                       title: "",
                                       closeButton: true,
                                       size: 'small',
                                       className: "custom-dialogue",
                                       buttons: {
                                           main: {
                                               label: "OK",
                                               className: "btn-dacancel",
                                               callback: function () {
                                                   bootbox.hideAll();
                                               }
                                           }
                                       }
                                   });
                               }
                           }

                       }

                       catch (e) {
                           hideOverlay();
                       }
                   }, 500);
              // }
           //    else {
           //        hideOverlay();
           //        onJSButtonclick(1);
           //    }
           //},
           //     function (result) {
           //         hideOverlay();
           //         onJSButtonclick(1);
           //     });
    }
    function updateScreen(forceUpdate) {
        try{
            if (objExcel && (!objExcel.ScreenUpdating || forceUpdate))
                objExcel.ScreenUpdating = true;
        }
        catch(e) {
            //eat exception
        }
    }
    function stopUpdateScreen() {
        try{
            if (objExcel && objExcel.ScreenUpdating)
                objExcel.ScreenUpdating = false;
        }
        catch (e) {
            //eat exception
        }
    }

    function loadUsers() {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetAllUsers", { type: modelType },
                function (result) {
                    if (result.success) {
                        usersInformation = result.users;                      
                    }
                    else
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching user details failed: " + result.errors.join(), '');
                },
                function (result) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching user details failed! " + result.responseText, '');
                });
    }
    function getUserId(userId) {
        return userId;
    }

    var hideInProgress = false;
    var showModalId = '';
    function showModal(elementId) {
        if (hideInProgress) {
            showModalId = elementId;
        } else {
            $("#" + elementId).modal("show");
        }
    }
    function hideModal(elementId) {
        hideInProgress = true;
        $("#" + elementId).on('hidden.bs.modal', hideCompleted);
        $("#" + elementId).modal("hide");
    }
    function hideCompleted(elementId) {
        hideInProgress = false;
        if (showModalId) {
            showModal(showModalId);
        }
        showModalId = '';
        $(elementId).off('hidden.bs.modal');
    }

    function populateSharePopup()
    {
        var forecastModule = 1;
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Forecast/SharePopup", { shareType: forecastModule },
             function (data) {
                 var element = document.getElementById('ShareResult');
                 element.innerHTML = data;
                 fillSharePopup();
                 
                 PHARMAACE.FORECASTAPP.SHARE.autocompleteForUsers();
                 //dynamicInputTextboxShare();
                 //$('#inputPassword').autocomplete({ source: PHARMAACE.FORECASTAPP.SHARE.autocompleteListData });
                 
                 $('.modal-backdrop').remove();
                 $('#shareModal').modal('show');
             },
                    function (status) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                    });
    }

    function shareDocumentWithSelectedUsers() {
        buildUserForecastMappingForShare();
        shareDocumentWithUsers(undefined, undefined, userForecastMappingForShare);
    }
    function GoToSendMail(sendmailinfo) {
        if (sendmailinfo.CommonSendInfoValue != null && sendmailinfo.SendMailInfoValue != null) {
            var postData = JSON.stringify({ "smi": sendmailinfo });
            PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/UserWorkSpace/SendMail", postData,
            function (result) {
                if (result.success) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Mail sent successfully", '');
                }
                else {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to send mail", '');
                }
            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Unable to send mail", '');
            });
        }
    }
    function shareDocumentWithUsers(nameOnly, enableMinorVersion, userForecastMapping) {
        var version = null;
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var url = "";
            url = "/Forecast/ShareDocument";
            var postData = JSON.stringify({ "userForecasts": userForecastMapping, "type": type });
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("", 'shareContentId', '', '');
            var overlayDiv = $('#sharePpoupFooterId').next();
            overlayDiv.addClass('overlayPopup');
        PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData(url, postData,
            function (result) {
                if (nameOnly != undefined && enableMinorVersion != undefined) {
                    //new forecast - this should hit while saving only
                    if (isSaveAsForecast)
                        RefreshModelForSync(enableMinorVersion);
                    else
                        RefreshModel(nameOnly, enableMinorVersion);
                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
                }
                else {
                    if (result.success) {
                        var sendmailinfo = {};
                        if (result.SendMailInformation != null && result.SendMailInformation.UserMailInfo!=null) {
                            var sendmailusers = result.SendMailInformation;
                            sendmailinfo = {
                                SendMailInfoValue: sendmailusers.UserMailInfo.SendMailInfoValue,
                                CommonSendInfoValue: sendmailusers.UserMailInfo.CommonSendInfoValue
                            };
                        }

                        if (result.unsccessIds.length<=0) {
                             var table = $('#prdverid > tbody  > tr');
                            table.each(function () {
                                $(this).removeAttr('style');
                            });
                            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
                            refreshModelEverytime();
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully assigned permission" + currentForecast.name, '');
                            $('#closebtnShare').click();
                            hideEDraw();
                            overlayDiv.removeClass('overlayPopup');
                            addSharedWithValuesTocurrentForecast(userArrayShared);
                            if (sendmailinfo!=null)
                                GoToSendMail(sendmailinfo);
                        }
                        else {
                        overlayDiv.removeClass('overlayPopup');
                        refreshModelEverytime();
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
                        PHARMAACE.FORECASTAPP.UTILITY.popalert(result.StatusMsg, '');
                        var table=$('#prdverid > tbody  > tr')
                        table.each(function () {
                            var id = $(this).find("td.divOne").attr("highligthid");
                            for(j=0;j<result.unsccessIds.length;j++)
                            {  
                                if(id==result.unsccessIds[j])
                                {
                                    //$(this).attr('style', 'background-color: red;');
                                    $(this).attr('style','border:2px solid #f00; display:inline-block');
                                }
                            }
                        });
                            //overlayDiv.removeClass('overlayPopup');
                        if (sendmailinfo != null)
                            GoToSendMail(sendmailinfo);
                    }
                       
                    }
                    else {
                        refreshModelEverytime();
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
                        PHARMAACE.FORECASTAPP.UTILITY.popalert(result.errors.join(), '');
                    }
               }
            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('shareContentId');
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Sharing document failed! " + result.responseText, '');
            });
        $('.overlay#openShare').trigger('hide'); 


       // return false;
    }
    function addSharedWithValuesTocurrentForecast(userArrayShared)
    {
        var item = currentForecast.item;
        
        for(var i = 0 ; i < userArrayShared.length; i++)
        {
            item.Access.SharedAccess.push(userArrayShared[i]);
        }
    }
    function ClosePopup() {
        showEDraw();
    }
    function removeOptions(selectbox) {
        var i;
        if (selectbox && selectbox.options) {
            for (i = selectbox.options.length - 1; i >= 0; i--) {
                selectbox.remove(i);
            }
        }
    }

    ////////////*************************************************************EDRAW*********************************************************************//////////
    function getAssumptions(useCache) {
        var versionWithV = getVersion();
        if (useCache == true)
            fillAssumptions(useCache);
        else {
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetAssumptions", { project: getProject(), version: versionWithV, type: modelType },
                function (result) {
                    if (result.success) {
                        populateAssumptionSet(result.notes);
                        fillAssumptions();
                    }
                },
                function (result) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not load assumptions", '');
                });
        }
    }
    function populateAssumptionSet(notes) {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        assumptionSet = [];
        var sectionCount = getAssumptionSectionCount();
        for (var i = 0; i < notes.length; i++) {
            if (modelType == 0 || modelType == 1) {
                var productBasedIndex = (notes[i].Product - 1) * sectionCount + notes[i].Section - 1;
            }
            else
            {
                var productBasedIndex = (notes[i].Indication - 1) * sectionCount + notes[i].Section - 1;
            }
            assumptionSet[productBasedIndex] = notes[i];
            if (!attachmentMap[productBasedIndex])
                attachmentMap[productBasedIndex] = [];
            if (notes[i].Attachments && notes[i].Attachments.length > 0) {
                for (var j = 0; j < notes[i].Attachments.length; j++) {
                    if (!attachmentMap[productBasedIndex][j])
                        attachmentMap[productBasedIndex][j] = {};
                    attachmentMap[productBasedIndex][j].name = notes[i].Attachments[j].AttachmentName;
                    attachmentMap[productBasedIndex][j].source = notes[i].Attachments[j].AttachmentPath;
                    attachmentMap[productBasedIndex][j].url = notes[i].Attachments[j].AttachmentPath;
                }
            }
        }
    }
    function getAssumptionSectionCount(sections) {
        var count = 0;
        if(!sections)
            sections = model.Sections;
        for(var i = 0;i < sections.length; i++){
            var section = sections[i];
            if (section.HasAssumption)
                count++;
            if (section.SubSections && section.SubSections.length > 0)
                count += getAssumptionSectionCount(section.SubSections);
        }

        return count;
    }
    function getProject() {
        if (!objExcel)
            return;

        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var project = "";
        try {
            if (modelType == 0 || modelType == 1) {
                project = objExcel.Workbooks(1).Worksheets("Master_List").Range("B2").Value;
            }
            else {
                project = currentForecast.name;
            }
        }
        catch (e) {
            //eat exception
        }
        //if (!project || project.length == 0) {
        if(project != currentForecast.name) {
            project = currentForecast.name;
        }
        return project;
    }
    function getVersion() {
        return currentForecast.version;
    }    
    function getProduct() {
        if (!objExcel)
            return;

        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 0) {
            var ele = document.getElementById('selectProduct');
            if (ele && ele.options && ele.options[ele.selectedIndex])
                return ele.options[ele.selectedIndex].text;
        }
        if (modelType == 1) {
            if (!selectedProduct) {
                //TO DO: need to return the entire list of products
                var firstInlineProduct = objExcel.Workbooks(1).Worksheets("Vars").Range("L3").Value;
                if (firstInlineProduct)
                    selectedProduct = firstInlineProduct;
                var firstPipelineProduct = objExcel.Workbooks(1).Worksheets("Vars").Range("Q3").Value;
                selectedProduct += firstPipelineProduct;
                if(firstInlineProduct && firstPipelineProduct)
                    selectedProduct = firstInlineProduct + ' '+ firstPipelineProduct;
            }
            return selectedProduct;
        }
    }
    function getProductIndex(fromDropdown) {
        if (!objExcel)
            return;

        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 0) {
            if (fromDropdown == true) {
                var ele = document.getElementById('selectProduct');
                if (ele)
                    return ele.selectedIndex + 1;
            }
            return objExcel.Workbooks(1).Worksheets("Vars").Range("B18").Value;
        }
        else if (modelType == 1) {
            if (fromDropdown == true) {
                var ele = document.getElementById('selectCountry');
                if (ele)
                    return ele.selectedIndex + 1;
            }
            return objExcel.Workbooks(1).Worksheets("Vars").Range("V3").Value;
        }
        else
        {
            if (fromDropdown == true) {
                var ele = document.getElementById('selectIndication');
                if (ele)
                    return ele.selectedIndex + 1;
            }
            return objExcel.Workbooks(1).Worksheets("Vars").Range("M1").Value;
        }
    }
    function getSKUIndex() {
        if (!objExcel)
            return;

        return objExcel.Workbooks(1).Worksheets("Vars").Range("B20").Value;
    }
    function getScenarioIndex() {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var selectedScenarioCell = "";
        if (modelType == 0)
            scenarioSheet = "B22";
        if (modelType == 1)
            scenarioSheet = "BK1";
        if (selectedScenarioCell && objExcel)
            return objExcel.Workbooks(1).Worksheets("Vars").Range(selectedScenarioCell).Value;
        return 1;
    }
    function getLatestVersionLabel() {
        var latest = null;
        if (currentForecast) {
            if (currentForecast.item)
                latest = currentForecast.item.latest;
            if (!latest)
                latest = currentForecast.version;
        }
        return latest;
    }

    function setUnsavedCreateForecastName() {
        if (!objExcel)
            return;

        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (type == 0)
        {

            var newProjName = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value;
        }
        else if(type == 1)
        {
            var newProjName = objExcel.Workbooks(1).Worksheets("Vars").Range("A2").Value;
        }
        else
        {
            // var newProjName = objExcel.Workbooks(1).Worksheets("Vars").Range("A1").Value;
            var newProjName = objExcel.Workbooks(1).Worksheets("Dates_Available").Range("D2").Value;
        }
        var valueLabel = "V0.0";
        var selectforecastOption = '<li name="{0}" value="{1}" latest="{2}" class="dropdown-submenu forecast-version"><a href="#">{0}</a></li>'.replaceAll("{0}", newProjName).replaceAll("{1}", valueLabel);
        $('#selectForecast').prepend(selectforecastOption);        
    }
    function onProductUpdateForChart() {
        if (!objExcel)
            return;

        try {
            var sheet = objExcel.Workbooks(1).Worksheets("Vars");
            var ele = document.getElementById('chart_product');
            sheet.Range("AQ2").Value = ele.selectedIndex + 1;
            populateSKUsForChart();
            var vbaMethod = "'{0}'!Graph_Product_Change".replace("{0}", objExcel.Workbooks(1).Name);
            runMacro(vbaMethod)
        }
        catch (e) {
            //hideOverlay();
        }
    }

    
    

    function populateSKUsForChart() {
        if (!objExcel)
            return;

        removeOptions(document.getElementById('chart_sku'));
        var sheet = objExcel.Workbooks(1).Worksheets("SKU_InformationOld");
        var sheet1 = objExcel.Workbooks(1).Worksheets("Master_List");
        var ele = document.getElementById('chart_product');
        var SkuValue = document.getElementById('chart_sku');
        var row = 2;
        var col = ele.selectedIndex + 2;
        var sku = sheet.Cells(row, col).Value;
        while (sku && sku.length > 0) {
            $('#chart_sku').append("<option value=" + sku + ">" + sku + "</option>");
            row++;
            sku = sheet.Cells(row, col).Value;
        }
        if (sheet1.Cells(col + 8, 8).value == true)
        setDefaultSkuValueForChart();
    }
    function setDefaultSkuValueForChart() {
        if ($('#chart_sku option:last').length == 0) {
            $('#chart_sku').append("<option value=" + "Total" + ">" + "Total" + "</option>");
        }
        else {
            var defaultSkuValue = $('#chart_sku option:last').val();
            if (defaultSkuValue != 'Total') {
                $('#chart_sku option:last').after("<option value=" + "Total" + ">" + "Total" + "</option>");
            }
        }
    }

    $('#npvbox').click(function (e) {
        if (!objExcel)
            return;

        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 0) {
            try {
                objExcel.Workbooks(1).Worksheets("NPV").Activate();
            }
            catch (e) {
                //eat exception
            }
        }
    });

    $('#assumptionsheetid').click(function (e) {
        if (!objExcel)
            return;

        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 0) {
            try {
                showOverlay("Opening assumption summary...");
                setTimeout(function () {
                    var vbaMethod = "'{0}'!Forecast_Assumptions".replace("{0}", objExcel.Workbooks(1).Name);
                    runMacro(vbaMethod);
                    objExcel.Workbooks(1).Worksheets("Forecast_Assumptions").Activate();
                    showEDraw();
                    hideOverlay();

                }, 500);
            }
            catch (e) {
                //eat exception
            }
        }
    });

    


    function openChartPopup() {
        hideEDraw();
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (type == 0) {
            loadProductForChart();
            onProductUpdateForChart();
            if (rememberChartValue == true) {
                document.getElementById('chart_product').selectedIndex = chartConfig.ProductIndex;
                onProductUpdateForChart();
                document.getElementById('chart_sku').selectedIndex = chartConfig.SkuIndex;
            }
        }
        else
        {
            bdlLoadCountryForChart();
            bdlLoadProductForChart();
            if (rememberChartValue == true) {
                document.getElementById('chart_productbdl').selectedIndex = chartConfigBdl.productIndexBdl;
                document.getElementById('chart_country').selectedIndex = chartConfigBdl.countryIndex;
            }
        }

    }

    function bdlLoadCountryForChart() {
        if (!objExcel)
            return;

        $('#chart_country').html('');
        var cntrySelectList = $('#chart_country');
        var countryValue = objExcel.Workbooks(1).Worksheets("vars");
        var countOfCountries = countryValue.Range("V7").Value;
        var row = 2;
        for (i = 1; i <= countOfCountries; i++) {       
            var col = 23;
            cntrySelectList.append("<option value=" + countryValue.Cells(row, col).value + ">" + countryValue.Cells(row, col).value + "</option>");  
            row++;
        }
    }

    function bdlLoadProductForChart()
    {
        if (!objExcel)
            return;

        $('#chart_productbdl').html('');
        var productValueBdl = objExcel.Workbooks(1).Worksheets("vars");
        var countOfProduct = productValueBdl.Range("L3").Value;
        var row = 3;
        var col = 12;
        do {
            $('#chart_productbdl').append("<option value=" + productValueBdl.Cells(row, col).value + ">" + productValueBdl.Cells(row, col).value + "</option>");
            row++;
        } while (productValueBdl.Cells(row, col).value == '' || productValueBdl.Cells(row, col).value != undefined);

        var countOfProductPipeline = productValueBdl.Range("Q3").Value;
        var row1 = 3;
        var col1 = 17;
        do {
            $('#chart_productbdl').append("<option value=" + productValueBdl.Cells(row1, col1).value + ">" + productValueBdl.Cells(row1, col1).value + "</option>");
            row1++;
        } while (productValueBdl.Cells(row1, col1).value == '' || productValueBdl.Cells(row1, col1).value != undefined);

        $("#chart_productbdl option:contains(undefined)").remove();

    }

    function loadProductForChart() {
        if (!objExcel)
            return;

        $('#chart_product').html('');
        var productValue = objExcel.Workbooks(1).Worksheets("ProductDetails");
        var row = 2;
        var col = 1;
        do {
            productValue.Cells(row, col).value;
            $('#chart_product').append("<option value=" + productValue.Cells(row, col).value + ">" + productValue.Cells(row, col).value + "</option>");
            $("#chart_product option:selected").val();
            row++;
        } while (productValue.Cells(row, col).value == '' || productValue.Cells(row, col).value != undefined);
    }


    function populateIndicationListInActharModel()
    {
        if (!objExcel)
            return;

        if (objExcel.Workbooks(1).ActiveSheet.Name == "Monthly" || "Quarterly" || "Yearly")
        {
            var indicationList = $('#selectIndication');
            isIndication = true;
            if (indicationList && indicationList.length > 0) {
                indicationList.html('');
                var indicationValue = objExcel.Workbooks(1).Worksheets("vars");
                var row = 6;
                var col = 13;
                do {
                    indicationList.append("<option value=" + indicationValue.Cells(row, col).value + ">" + indicationValue.Cells(row, col).value + "</option>");
                    row++;
                } while (indicationValue.Cells(row, col).value == '' || indicationValue.Cells(row, col).value != undefined);


            }

        }
        else 
        if (objExcel.Workbooks(1).ActiveSheet.Name == "Total_Monthly" || "Total_Quarterly" || "Total_Yearly")
        {
            isTotalIndication = true;
            var indicationList = $('#selectIndication');
            if (indicationList && indicationList.length > 0) {
                indicationList.html('');
                var indicationValue = objExcel.Workbooks(1).Worksheets("vars");
                var row = 3;
                var col = 13;
                for (row = 3; row <= 5 ; row++) {
                    indicationList.append("<option value=" + indicationValue.Cells(row, col).value + ">" + indicationValue.Cells(row, col).value + "</option>");
                }
                   
            }
        }

    }
    function populateSelectedList() {
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (setUnsaveCreateForecastName == true) {
            setUnsavedCreateForecastName();
        }
        if (type == 0 || type == 1) {
            loadCountry();
            loadProduct();
            loadSKU();
            loadScenario();
        }
    }
    
    function loadCountry() {
        if (!objExcel)
            return;
        var cntrySelectList = $('#selectCountry');
        if (cntrySelectList && cntrySelectList.length > 0) {
            cntrySelectList.html('');
            var countryValue = objExcel.Workbooks(1).Worksheets("vars");
            var countOfCountries = countryValue.Range("V7").Value;
            var row = 2;
            var col = 23;
            for (i = 1; i <= countOfCountries; i++) {
                cntrySelectList.append("<option value=" + countryValue.Cells(row, col).value + ">" + countryValue.Cells(row, col).value + "</option>");
                row++;
            }
        }
    }
    function loadProduct() {
        if (!objExcel)
            return;

        var productSelectList = $('#selectProduct');
        if (productSelectList && productSelectList.length > 0) {
            productSelectList.html('');
            var productValue = objExcel.Workbooks(1).Worksheets("ProductDetails");
            var row = 2;
            var col = 1;
            do {
                productSelectList.append("<option value=" + productValue.Cells(row, col).value + ">" + productValue.Cells(row, col).value + "</option>");
                $("#selectProduct option:selected").val();
                row++;
            } while (productValue.Cells(row, col).value == '' || productValue.Cells(row, col).value != undefined);

        }
        updateFeed();
    }

    function loadSKU() {
        if (!objExcel)
            return;

        try {
            var skuSelectList = $('#selectSKU');
            if (skuSelectList && skuSelectList.length > 0) {
                skuSelectList.html('');
                var skuValue = objExcel.Workbooks(1).Worksheets("SKU_InformationOld");
                var ele = document.getElementById('selectProduct');
                var row = 2;
                var col = ele.selectedIndex + 2;
                do {
                    skuSelectList.append("<option value=" + skuValue.Cells(row, col).value + ">" + skuValue.Cells(row, col).value + "</option>");
                    row++;
                } while (skuValue.Cells(row, col).value == '' || skuValue.Cells(row, col).value != undefined);
            }
        }
        catch (e) {
            //eat exception
        }
    }
    
    function loadScenario() {
        if (!objExcel)
            return;

        var scenarioSelectList = $('#selectScenario');
        if (scenarioSelectList && scenarioSelectList.length > 0) {
            scenarioSelectList.html('');
            var scenarioValue = objExcel.Workbooks(1).Worksheets("ScenarioTable");
            var row = 2;
            var col = 2;
            do {
                scenarioValue.Cells(row, col).value;
                scenarioSelectList.append("<option value=" + scenarioValue.Cells(row, col).value + ">" + scenarioValue.Cells(row, col).value + "</option>");
                row++;
            } while (scenarioValue.Cells(row, col).value == '' || scenarioValue.Cells(row, col).value != undefined);
        }
    }
    function disableCommands() {
        if (!objExcel)
            return;

        for (var i = 1; i <= objExcel.CommandBars.Count; i++) {
            objExcel.CommandBars(i).Enabled = false;
        }
    }
    function disableKeys() {
        if (!objExcel)
            return;

        var arr = ["+", "^", "%", "+^", "+%", "^%", "+^%"];
        var KeysArray = ["{BS}", "{BREAK}", "{CAPSLOCK}", "{CLEAR}", "{DEL}",
                        "{DOWN}", "{END}", "{ENTER}", "~", "{ESC}", "{HELP}", "{HOME}",
                        "{INSERT}", "{LEFT}", "{NUMLOCK}", "{PGDN}", "{PGUP}",
                        "{RETURN}", "{RIGHT}", "{SCROLLLOCK}", "{UP}"];
        //"{TAB}", 

        for (var z = 0; z < arr.length; z++) {
            var StartKeyCombination = arr[z];

            //Disable the StartKeyCombination key(s) with every key in the KeysArray                
            for (var x = 0; x < KeysArray.length; x++) {
                var Key = KeysArray[x];
                objExcel.OnKey(StartKeyCombination + Key, "");
            }

            //Disable the StartKeyCombination key(s) with every other key
            for (var i = 32; i <= 126; i++) {
                try {
                    if (StartKeyCombination == '^') //CTRL
                    {
                        if (i == 67 //C
                        || i == 99 //c
                        || i == 86 //V
                        || i == 118 //v
                        )
                            continue;
                    }
                    objExcel.OnKey(StartKeyCombination + String.fromCharCode(i), "");
                }
                catch (e) {
                    //eat up exception - e.g. if String.fromCharCode(i) = '%'
                }
            }


            //objExcel.OnKey("%TO", alert("Hi"));
            //objExcel.OnKey("%to", alert("Hi"));
            //objExcel.OnKey("%To", alert("Hi"));
            //objExcel.OnKey("%tO", alert("Hi"));

            //Disable the F1 - F15 keys in combination with the Shift, Ctrl or Alt key
            for (var i = 1; i <= 15; i++)
                objExcel.OnKey(StartKeyCombination + "{F" + i + "}", "");
        }
        try {
            objExcel.OnKey("%", "");
        }
        catch (e) {
            //eat up exception - e.g. if String.fromCharCode(i) = '%'
        }

        //Disable the F1 - F15 keys
        for (var i = 1; i <= 15; i++) {
            objExcel.OnKey("{F" + i + "}", "");
        }

        //Disable the PGDN and PGUP keys
        objExcel.OnKey("{PGDN}", "");
        objExcel.OnKey("{PGUP}", "");
    }
    function getTempDirectory() {
        return OA1.GetTempFilePath('|').replace("\\|.|", "");
    }

//*****************************************************ForecastModel.aspx********************************************************************