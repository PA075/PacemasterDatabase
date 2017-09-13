<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ForecastEntity>" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<%: Styles.Render("~/Content/forecastModelCSS") %>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />
<%: Styles.Render("~/Content/fontawesomeCSS", "~/Content/bootstrapCSS") %>
 <%: Scripts.Render("~/Scripts/forecastModelScript") %>
<link href="../../Content/CSS/aero.css" rel="stylesheet" />
<link href="../../Content/CSS/calendarDefault.css" rel="stylesheet" />
<%--<link href="../../Content/CSS/calendarReset.css" rel="stylesheet" />--%>
<link href="../../Content/CSS/calendarStyle.css" rel="stylesheet" />

<link href="../../Content/CSS/bootstrap-tagsinput.css" rel="stylesheet" />
<script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js"></script>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
 <script src="../../Scripts/lib/bootstrap/bootstrap-multiselect.js"></script>

<%--<script src="../../Scripts/lib/jquery/icheck.min.js"></script>--%>
    <script src="../../Scripts/lib/jquery/jquery.smartWizard.js"></script>
<%--      <script src="../../Scripts/lib/modernizr/moment-with-locales.js"></script>--%>
<%--    <script src="../../Scripts/lib/bootstrap/bootstrap-datetimepicker.js"></script> --%>
<script src="../../Scripts/lib/bootstrap/bootstrap-tagsinput.min.js"></script>  
<script src="../../Scripts/custom/PharmaACE.ForecastApp.Generics.js"></script>
<script src="../../Scripts/lib/jquery/calendar_zebra_datepicker.js"></script>
<script>    
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
        var accessTypeGT = '<%= Session["AccessTypeGT"]%>';
        if (accessTypeGT == 3) {

            $('#createid').addClass('disabled');
            $('#createid').removeAttr('onclick');
            $('#openofflinebox').removeAttr('onclick');
            $('#openofflinebox').addClass('disabled');
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
            $('#chartbox a.enbdisbl').attr('data-toggle', 'modal');
            $('#chartbox a.enbdisbl').attr('onclick', 'openChart();hideEDraw();');
            $('#formulabox a.enbdisbl').attr('onclick', 'toggleFormulaBar(this);');

        }
        else {
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
                $("#tabmenu .navbar-nav li a.enbdisbl").removeClass("disabled");
                $('#editbox a.enbdisbl').attr('onclick', 'Edit();');
                $('#savebox a.enbdisbl').attr('data-toggle', 'modal');
                $('#savebox a.enbdisbl').attr('onclick', 'hideEDraw();');
                $('#attdoc a.enbdisbl').attr('onclick', 'cleanFileList();hideEDraw();');
                $('#chartbox a.enbdisbl').attr('onclick', 'openChart();hideEDraw();');
                $('#chartid').attr('onclick', 'hideEDraw();');
                $('#formulabox a.enbdisbl').attr('onclick', 'toggleFormulaBar(this);');
                $('#sharebox a.enbdisbl').attr('onclick', 'hideEDraw();');
                $('#unsharebox a.enbdisbl').attr('onclick', 'hideEDraw();populateUnsharePopup();');
                $('#closebutton a.enbdisbl').attr('onclick', 'hideEDraw();');
                $('#chartbox a.enbdisbl').attr('data-toggle', 'modal');
                $('#sharebox a.enbdisbl').attr('data-toggle', 'modal');
                $('#unsharebox a.enbdisbl').attr('data-toggle', 'modal');
                $('#attdoc a.enbdisbl').attr('data-toggle', 'modal');
                $('#conso a.enbdisbl').attr('onclick', 'clidator();');
                $('#syncid a.enbdisbl').attr('onclick', 'hideEDraw();');
                $('#syncid a.enbdisbl').attr('data-toggle', 'modal');
                if (modelType == 0 || modelType == 1) { 
                    $('#npvbox').css("display", "block");
                    $('#npvbox a.enbdisbl').attr('onclick', 'hideEDraw();');
                }
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
        var ttl = status == 0 ? "You are offline" : "You are logged out";
        var msgl = status == 0 ? "Do you want to save your work locally?" : "Do you want to save your work";
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
                            runMacro(vbaMethod);
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
        hideEDraw();
    }
    function saveOfflineByUser()
    {
        showOverlay("Please Wait While We Saving Offline ");
        setTimeout(function () { 
                var vbaMethod = "'{0}'!Save_Forecast_Offline".replace("{0}", objExcel.Workbooks(1).Name);
                runMacro(vbaMethod);
                hideEDraw();
                hideOverlay();

        }, 500);
    }
</script>
<script type="text/javascript">    
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
            
            PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/bootstrap/bootstrap-multiselect.js", function () {
                $('#attachment_sections').multiselect();
            });
            $("#tab-scroller #botbar").niceScroll({
                cursorfixedheight: 70
            });
        });
    })(jQuery);
</script>
<style type="text/css">
#menu-burger, #header-menu .navbar-toggle{display:none !important;}
    @media screen and (min-width:320px) and (max-width: 1170px) {
        #tabmenu .navbar-collapse {
            display:none !important;;
        }
    }

</style>
<body class="nav-sm">
<div id="NoInternet" class="modal bootbox internet-on-of in" tabindex="-1">
    <div class="modal-dialog">
        <div class="bootcustom">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close bootbox-close-button" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">You are offline</h4>
                </div>
                <form role="form">
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div style="margin-left: 15px;">
                                    <span>Do you want to save your work offline?</span>
                                    <label for="chkYes">
                                        <input type="radio" id="offlineYes" name="ChkInternet" />
                                        Yes
                                    </label>
                                    <label for="chkNo" style="margin-left: 20px;">
                                        <input type="radio" id="offlineNo" name="ChkInternet" checked />
                                        No
                                    </label>
                                    <hr />
                                    <div id="OfflineFile">
                                        <span style="width: 81%; float: left;">
                                            <input type="text" class="form-control" id="OfflineText" disabled required style="width: 93%;"></span><span><label class="btn btn-default btn-file disabled">
                                                Browse
                                                <input type="file" id="OfflineInput"></label></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-default pull-left" type="button" data-dismiss="modal">Cancel</button>
                        <input class="btn btn-primary pull-right" type="submit" value="Save Offline">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
     <%Html.RenderAction("RenderHeader", "Header", new { headerType = Model.MenuType }); %>

<div id="overlay_container" class="story">
    <div class="wrapper-left explorationHost " id="wrapper">
          <div class="navigationPane unselectable">
                    <div class="innerLayout">
                        
                        <div class="scrollRegion scroll-view">

                             <div class="headertitle"><a href="#">Forecast Navigation</a></div>           
                           <div class="sidebar-wrapper-left">
            <ul class="sidebar-nav-left">
               <% for (int i = 0; i < Model.Sections.Count; i++)
                   { %>
                <li><a onclick="navigateToSection(<%= Model.Sections[i].Start %>, '<%= Model.Sections[i].Name %>')" href="#"><%= Model.Sections[i].Name %></a>
                    <% if(Model.Sections[i].SubSections != null && Model.Sections[i].SubSections.Count > 0) { %>
                    <ul>
                        <% for (int j = 0; j < Model.Sections[i].SubSections.Count; j++)
                   { %>
                        <li><a onclick="navigateToSection(<%= Model.Sections[i].SubSections[j].Start %>, '<%= Model.Sections[i].SubSections[j].Name %>')" href="#"><%= Model.Sections[i].SubSections[j].Name %></a></li>
                    <% } %>                        
                    </ul>
                    <% } %>
                </li>                
                <% } %>
            </ul>
        </div>
                          

                        </div>
                    </div>
                   <div class="expanderBtn" id="menu_toggle" onclick="updateScreen(true);;" >
                       <a id="menu-toggle-left" class="slideLeft">
                                <span class="fa fa-angle-right" style="padding: 0px; font-size: 24px;"></span>
                            </a>
                            <h2 class="verticalTitle verticalText">
                                <span class="collapsedVisualsTitle largeFontSize">Forecast</span>
                                <span class="collapsedFiltersTitle largeFontSize">Sections</span>
                            </h2>
                        </div>
                </div>

             <%Html.RenderPartial("ForecastRightPane", Model.ForecastAuxiliary); %>
           <div id="page-content-wrapper" class="page-content-wrapper-left imgclickenable horizontalItemsContainer" style="">
            <div class="container-fluid">
                <div class="row">
                    <div class="">
                      <%Html.RenderPartial("ForecasterControl", Model); %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var serverurl = '<%= Session["ServerUrl"]%>';
    
    var model = JSON.parse('<%=Html.Raw(Json.Encode(Model))%>');
    var loginEmail = '<%= Session["User"] %>';
    var templatePath = "";
    var consolidatorTemplatePath = "";
    var objExcel;
    var assumptionSet;
    var attachmentMap = [];
    var urlArr = [];
    var unshareArray = [];
    var userArrayShared = [];
    var saveNewForecast;
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
    var checkedVersionIndex=0;
    var isTotalIndication = false, isIndication = false;
    var offlineSave = false;
    var projectOkCheck = false;
    var isImportImsData = false;
    var selectedProductId = -1, selectedSkuId = -1, selectedScenarioId = -1;

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
    $(document).ready(function () {
//start Notification code
         //window.setInterval(function () {
         //    GetNotifications();
         //   }, 5000);
        //Ends Notification code
        $('#ims_molecule').multiselect({
            enableFiltering: true,
            includeSelectAllOption: true,
        });
        $('#ims_product').multiselect({
            enableFiltering: true,
            includeSelectAllOption: true,
        });
        $('#ims_sku').multiselect({
            enableFiltering: true,
            includeSelectAllOption: true,
        });
        //$('#attachment_sections').multiselect('select', []);
        $('#menu_toggle').click(function () {
            if ($('body').hasClass('nav-md')) {
                $('body').removeClass('nav-md').addClass('nav-sm');
                $('.scrollRegion').removeClass('scroll-view');
            } else {
                $('body').removeClass('nav-sm').addClass('nav-md');
                $('.scrollRegion').addClass('scroll-view');
            }
        });


        var accessTypeGT = '<%= Session["AccessTypeGT"]%>';

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
        var firstname = '<%= Session["FirstName"].ToString().Substring(0, 1)%>';
        var lastname = '<%= Session["LastName"].ToString().Substring(0, 1)%>';
        if (loginEmail) {
            $("#btnprofile").text(firstname + "" + lastname);
            $("#btnprofile").attr("title", tooltiptitle);
        }
        if (!isTrusted)
            return;
        populateControls(true);
        populateAttachmentSections();
        loadUsers();
        window.onbeforeunload = function () {
            if(isCreatedOrRetrieved)
                return "This will take you out of the forecast window. Are you sure?";
        }
        window.onunload = function () {
            if (objExcel != null) {
                if (document.all.OA1.IsOpened && document.all.OA1.IsOpened())
                    document.all.OA1.CloseDoc(false);
                try {
                    if (objExcel.Version > 14.0) {
                        var vbaMethod = "'{0}'!Kill_Process_Excel".replace("{0}", objExcel.Workbooks(1).Name);
                        objExcel.Run(vbaMethod);
                    }
                }
                catch (ex) {
                }
                objExcel = null;
            }
            model = null;
        }

        $("#liImages").click(function (e) {
            hideEDraw();
        });
  
        $("#importimsdataid").click(function (e) {
            isImportImsData = true;
            var vbaMethod = "'{0}'!Import_IMSData".replace("{0}", objExcel.Workbooks(1).Name);
            runMacro(vbaMethod);
        });



        $("#openofflinebox").click(function (e) {
            showOverlay("Please Wait While We Uploading Offline File ");
            unProtectSheet();
            isCreatedOrRetrieved = true;
             offlineSave = true;
            var offlineProjName;
           var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            setTimeout(function () {
                var vbaMethod = "'{0}'!Retrieve_Forecast_From_Offline".replace("{0}", objExcel.Workbooks(1).Name);
                runMacro(vbaMethod);
                $('#Prdbox').css("display", "block");
                if (type == 0) {
                    offlineProjName = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value;
                }
                else if(type == 1) {
                    offlineProjName = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value;
                }
                else
                {
                    offlineProjName = objExcel.Workbooks(1).Worksheets("Dates_Available").Range("D2").Value;
                }
                currentForecast.name = offlineProjName;
                $('#saveasdesc').attr("placeholder", currentForecast.name);
                $('#saveasdesc').attr("title", currentForecast.name);
                createSetAssumptionSections(getSectionDetails());
                if (type == 0 || type == 1) {
                    populateSelectedList();
                }
                else
                {
                    populateIndicationListInActharModel();
                }
                enableButton();
                hideOverlay();
            }, 500);
        });
        $("#closebutton").click(function (e) {
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
            });
        }
    
        $("#saveModal").on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);  // Button that triggered the modal
            var username = loginEmail;
            var dt = new Date();
            dt = dt.toString().replace(/:\d{2} GMT/, " GMT");
            var html = "Saved By " + username + " on " + dt;
            $("#vDesc").attr("placeholder", html);
            $('#vDesc').attr("title", html);
            $('#vDesc').text(html);
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
            showOverlay("Please wait While We Upload File...");
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
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("File Uploaded Successfully. ", '');
                            }
                                //}
                            else {
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not Upload ", '');
                            }
                        };
                    }
                    $('table#sync_users_table td').remove();
               
            }
            catch (e) {
                hideOverlay();
            }
        });

        $("#file_attachment").change(function () {
            var val = $(this).val().toLowerCase();
            var ext = val.substr(val.lastIndexOf('.') + 1);
            var lblError = $("#lblError");
            var validFileType = PHARMAACE.FORECASTAPP.VALIDFILETYPE;
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
        });
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
                var url = attachmentMap[i][j].source;
                var arr = name.split('.');
                var ext = arr[arr.length - 1];
                var imageLink = PHARMAACE.FORECASTAPP.UTILITY.getImageForFileType(ext);
                if (url && url.length > 0)
                    str += "<li><a href='/Forecast/DownloadAttachment?source=" + url + "&sink=" + name + "&modelLocation=" + model.ModelLocation + "' target='_blank'><img src='" + imageLink + "' class='img-thumbnail' style='height:32px;' title='" + name + "'></a><div style='position:absolute;top:-4.32px;right:-3.9px;'><a href='#' onclick='removeAttachment(" + i + ", " + "$(this));'><span class='tag label label-default' style='background:none;color:red !important; font-size:10px !important;'>X</span></a></div></li>";
                else
                    str += "<li><a href='" + attachmentMap[i][j].localFullPath + "' target='_blank'><img src='" + imageLink + "' class='img-thumbnail' style='height:32px;' title='" + name + "'></a><div style='position:absolute;top:-4.32px;right:-3.9px;'><a href='#' onclick='removeAttachment(" + i + ", " + "$(this));'><span class='tag label label-default' style='background:none;color:red !important; font-size:10px !important;'>X</span></a></div></li>";
            }
            ele[i - startIndex].innerHTML = str;
        }
    }
    $('#attachment_sections').multiselect('deselectAll', false);
    $('#attachment_sections').multiselect('select', []);
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
function uploadAttachments(callback) {
    var formdata = new FormData(); //FormData object
    var isFormDataPopulated = false;
    var fileInputs = document.getElementsByClassName('file_write');
    for (var j = 0; j < attachmentMap.length; j++) {
        if (!attachmentMap[j] || attachmentMap[j].length == 0)
            continue;
        formdata.append("modelLocation", model.ModelLocation);
        for (i = 0; i < attachmentMap[j].length; i++) {
            if (!attachmentMap[j][i].repeat) {
                formdata.append(attachmentMap[j][i].name, attachmentMap[j][i].file);
                isFormDataPopulated = true;
            }
        }
    }
    if (isFormDataPopulated) {
        var modelPath;
        var controllerUrl = "/Home/UploadFile";
        var xhr = new XMLHttpRequest();
        xhr.open('POST', controllerUrl);
        xhr.send(formdata);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var sources = xhr.responseText.split("||^||");
                var k = 0;
                for (var j = 0; j < attachmentMap.length; j++) {
                    if (!attachmentMap[j] || attachmentMap[j].length == 0)
                        continue;
                    for (i = 0; i < attachmentMap[j].length; i++) {
                        if (!attachmentMap[j][i].repeat) {
                            if (!attachmentMap[j][i].source) {
                                attachmentMap[j][i].url = sources[k]; //added attachments
                                k++;
                            }
                            else
                                attachmentMap[j][i].url = attachmentMap[j][i].source; //retrieved attachments
                        }
                    }
                    for (i = 0; i < attachmentMap[j].length; i++) {
                        if (attachmentMap[j][i].repeat) {
                            var sectionIndex = attachmentMap[j][i].repeat.section;
                            var fileIndex = attachmentMap[j][i].repeat.file;
                            attachmentMap[j][i].url = attachmentMap[sectionIndex][fileIndex].url;
                        }
                    }
                }
                if (callback)
                    callback();
            }
        }
    }
    else if (callback)
        callback();
    return false;
}

function populateAttachmentSections() {
    var sections = getSectionDetails();
    for (var i = 0; i < sections.length; i++) {
        $('#attachment_sections').append("<option value=" + i + ">" + sections[i].name + "</option>");
    }
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
function runMacro(vbaMethod, oa, objEx) {
    if (!oa) {
        oa = document.all.OA1;
        objEx = objExcel;
    }
    oa.focus();
    oa.click();
    var runResult = true;
    try {
        runResult = objEx.Run(vbaMethod);
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



    
function populateControls(updateFeed) {
    var roleId = '<%=  Session["RoleId"] %>';
    var forecastList = $('#selectForecast');
    forecastList.children().remove();
    selectforecastOptions = '';
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
            selectforecastOptions += addVersionListItem(firstLevelItem, item.LatestVersion, 1);
            if (item.Versions) {
                selectforecastOptions += '<ul class="dropdown-menu secondlevel">';
                for (var firstLevelVersionIndex = 0; firstLevelVersionIndex < item.Versions.length; firstLevelVersionIndex++) {                    
                    if (item.Versions[firstLevelVersionIndex].PreDrafts) {
                        var preDraftCount = item.Versions[firstLevelVersionIndex].PreDrafts.length;
                        if (preDraftCount > 0) {
                            selectforecastOptions += addVersionListItem(item.Versions[firstLevelVersionIndex], item.LatestVersion, 2, true)
                            selectforecastOptions += '<ul class="dropdown-menu thirdlevel">';
                            for (var preDraftIndex = 0; preDraftIndex < preDraftCount; preDraftIndex++) {
                                selectforecastOptions += addVersionListItem(item.Versions[firstLevelVersionIndex].PreDrafts[preDraftIndex], item.LatestVersion, 3, true)
                                selectforecastOptions += '</li>';
                            }
                   
                            selectforecastOptions += '</ul>';
                            selectforecastOptions += '</li>';
                           

                        }
                    }
                    else {
                        //valueLabel will be empty for 0.0
                        
                            selectforecastOptions += addVersionListItem(item.Versions[firstLevelVersionIndex], item.LatestVersion, 2, true);
                            selectforecastOptions += '</li>';
                        
                    }
                }
                selectforecastOptions += '</ul>';
               
            }
            if (roleId == 3) {
                selectforecastOptions += '<div style="top: 6px; right: 21px; position: absolute; cursor: pointer;"><i class="fa fa-trash fa-1 fa-white" aria-hidden="true" onclick="gFRemoveProjectDetailsMsg(\'' + item.Forecast + '\');" data-toggle="tooltip" title="Delete Forecast"></i>';
                selectforecastOptions += '<a href="#" data-toggle="modal" data-target="#copyModal"><i class="fa fa-files-o fa-1 fa-white" aria-hidden="true" onclick="

electedForecast(\'' + item.Forecast + '\');" data-toggle="tooltip" title="Copy Forecast" style="margin-left:6px;"></i></a>'
                selectforecastOptions += '<a class="fast-retrieve" href="#"><i class="fa fa-trash fa-1 fa-white" aria-hidden="true" data-toggle="tooltip" title="Fast Retrieve"></i></a></div>';
            }
            selectforecastOptions += '</li>';
            selectforecastOptions = selectforecastOptions.replaceAll("{0}", item.Forecast);
            
        }
        forecastList.append(selectforecastOptions);
    }

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
        }
        else
            editForecast(this);
    });

    $('.forecast-version.fast-retrieve').click(function (e) {
        e.stopPropagation();
        editForecast(this, true);
    });

    keydownFunctioality();
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
function addVersionListItem(version, latestVersion, level, displayLabelAsVersion) {
    var valueLabel = version.Label;
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
        if (mock == true)
        displayLabelAsVersion = " In progress...";
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
    
    return '<li name="{0}" value="{1}" latest="{2}" mock="{7}" title="{8}" class="{5} forecast-version {3}"><a href="#">{4}{6}</a>'.replaceAll("{1}", valueLabel).replaceAll("{2}", latest).replaceAll("{3}", clsLevel).replaceAll('{4}', displayLabelAsVersion).replaceAll('{5}', clsLeaf).replaceAll('{6}', arrow).replaceAll('{7}', mock).replaceAll('{8}', displayLabelAsVersionTooltip);
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
function navigateToSection(start, name) {
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
function updateProperties() {
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

    $('.vcoment').html(getVersion() + " Comment");
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
            $('#created_on').text(newCurrDate);
            $('#created_on').attr('title', newCurrDate);

            $('#modified_on').text(newCurrDate);
            $('#modified_on').attr('title', newCurrDate);
        }

        if (item.Access.SharedAccess.length > 0) {
            var name = [];
            var email = [];
            var divContent = document.getElementById('shared_with');
            var str = '';
            for (var i = 0; i < item.Access.SharedAccess.length; i++) {
                str += '<div title = ' + item.Access.SharedAccess[i].SharedWith.Email + '>' + item.Access.SharedAccess[i].SharedWith.FirstName + " " + item.Access.SharedAccess[i].SharedWith.LastName + ', ' + '</div>'
                unshareArray.push(item.Access.SharedAccess[i].SharedWith.UserId);
            }
            divContent.innerHTML = str;
        }
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
    var tableRef = document.getElementById('copied_users_table').getElementsByTagName('tbody')[0];
    document.getElementById('ProjNameid').innerHTML=ProjectName;
  
    var str = '';
  
    if (model.ForecastDetails && model.ForecastDetails.ItemList) {
        var lst = model.ForecastDetails.ItemList;
        for (var i = 0; i < lst.length; i++) {
            var item = lst[i];
            if (item.Forecast == ProjectName) {
                if (!item.Versions || item.Versions.length == 0)
                    continue;
                for (var j = 0; j < item.Versions.length; j++) {

                    if (item.Versions[j].PreDrafts != null) {
                        if (item.Versions[j].Label) {
                            if (item.Versions[j].Label.split(".")[1] == "0") {

                                str += '<tr><td id="" style = "">' + item.Versions[j].Label + '</td>';
                                str += '<td style=""><input data-index="1" class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style=""><input data-index="1" class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style="" class="selectedversionvalue"></td></tr>';
                            }
                        }


                        for (var k = 0 ; k < item.Versions[j].PreDrafts.length ; k++) {
                            if (k == 0) {
                                str += '<tr><td id="" style = "">' + item.Versions[j].PreDrafts[k].Label + '</td>';
                                str += '<td style=""><input data-index="1" class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style=""><input data-index="1" class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style="" class="selectedversionvalue"></td></tr>';
                            }
                            else {

                                str += '<tr><td id="" style = "">' + item.Versions[j].PreDrafts[k].Label + '</td>';
                                str += '<td style=""><input data-index="1" class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style=""><input data-index="1" class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                                str += '<td style="" class="selectedversionvalue"></td></tr>';
                            }
                        }
                    }
                    else {
                        str += '<tr><td id="" style = "">' + item.Versions[j].Label + '</td>';
                        str += '<td style=""><input data-index="1" class="CopyForecast" name="btSelectItem" type="checkbox"></td>';
                        str += '<td style=""><input data-index="1" class="ischeckminor" name="btSelectItem" type="checkbox"></td>';
                        str += '<td style="" class="selectedversionvalue"></td></tr>';

                    }
                }
            }
        }
    }
    tableRef.innerHTML = str;
}



$(document).on("change", "input:checkbox[class='CopyForecast']", function () {
    var ischecked = $(this).is(':checked');
        
        if (ischecked) {
            //if ($('.ischeckminor').is(':checked')) {
            //    $(this).parent().parent().find('td.selectedversionvalue').text("V" +checkedVersionIndex +"."+ ++checkedVersionminorIndex);
            //}
            //else {
            checkedVersionminorIndex = 0;
                $(this).parent().parent().find('td.selectedversionvalue').text("V" + ++checkedVersionIndex + ".0");
           // }
       
        }
    else
        {
            $(this).parent().parent().find('td.selectedversionvalue').text("");
            checkedVersionIndex--;
        }
});

$(document).on("change", "input:checkbox[class='ischeckminor']", function () {
    var ischecked = $(this).is(':checked');
   
    if (ischecked) {
        var majorchecked = $(this).parent().parent().find('td.CopyForecast')
        if (majorchecked) {
            $(this).parent().parent().find('td.selectedversionvalue').text("V" + checkedVersionIndex + "." + ++checkedVersionminorIndex);

        }
        //else {

        //    checkedVersionminorIndex = 0;
        //    $(this).parent().parent().find('td.selectedversionvalue').text("V" + checkedVersionIndex + "." + ++checkedVersionminorIndex);
        //}
    }
    else {
                $(this).parent().parent().find('td.selectedversionvalue').text("");
                if (checkedVersionminorIndex > 1)
                    checkedVersionminorIndex--;
                else
                    checkedVersionminorIndex = 0;
            }
    //else {
    //    var majorchecked = $(this).parent().parent().find('td.CopyForecast')
    //    if (majorchecked) {
    //        checkedVersionminorIndex--;
    //        $(this).parent().parent().find('td.selectedversionvalue').text("V" + checkedVersionIndex + "." + ++checkedVersionminorIndex);
               
           
    //    }
    //    else {

    //        $(this).parent().parent().find('td.selectedversionvalue').text("");
    //        if (checkedVersionminorIndex > 1)
    //            checkedVersionminorIndex--;
    //        else
    //            checkedVersionminorIndex = 0;
    //    }
    //}
    
});




function CopyForecast() {
    showOverlay("Please Wait While We Copy Forecast...");
    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var modelLocation = model.ModelLocation;
    var projectName = $("#ProjNameid").html().trim();
    var copiedToForecast = $("#copiedtoname").val();
    currentForecast.name = copiedToForecast;
   
    var userArray = [];
    var NoOfVersion = 1;
    var IsEnableMinorVersionCheck = false;

    if (copiedToForecast != "")
        {
    var checkboxes = document.getElementsByClassName("CopyForecast");
    var ele = document.getElementsByClassName("ischeckminor");
    for (i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            if (ele[i].checked) {
                IsEnableMinorVersionCheck = true;
            }
            else {
                IsEnableMinorVersionCheck = false;
            }
            var versionarrayselected = { NoOfVersion: NoOfVersion, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0, Forecast: projectName, CopiedToForecastName: copiedToForecast, modelLocation: modelLocation, type: type };
            userArray.push(versionarrayselected);
            NoOfVersion++;
        }
        else {
            if (ele[i].checked) {
                IsEnableMinorVersionCheck = true;

                var versionarrayselected = { NoOfVersion: NoOfVersion, IsEnableMinorVersionCheck: IsEnableMinorVersionCheck ? 1 : 0, Forecast: projectName, CopiedToForecastName: copiedToForecast, modelLocation: modelLocation, type: type };
                userArray.push(versionarrayselected);
                NoOfVersion++;
            }
        }
    }

        jQuery.ajaxSettings.traditional = true;
        userArray = JSON.stringify({ 'UserVerisonArray': userArray });
        PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/CopyForecast", userArray,
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
    else
    {
        hideOverlay();
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Coping Forecast failed", '');
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
                        showEDraw();
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
    showOverlay("Please Wait While We Delete A Forecast...");
    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var modelLocation = model.ModelLocation;
    var ProjectName = ProjName;
    PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/GFRemoveProjectDetails", JSON.stringify({ 'ProjectName': ProjectName, 'type': type, 'ModelLocation': modelLocation }),
       function (result) {
           if (result.success) {              
               hideOverlay();
               RefreshModelForDeleteForecast();
           }
           else {              
               hideOverlay();
           }
       },
       function (result) {
           hideOverlay();         
       });
}







   
function  populateUnsharePopup()
{
    var item = currentForecast.item;
    var tableRef = document.getElementById('unshare_users_table').getElementsByTagName('tbody')[0];
    var str = '';
    unshareArray.push(item.Access.SharedAccess);
    if (item.Access.SharedAccess.length > 0) {
        for (var i = 0; i < item.Access.SharedAccess.length; i++) {
            str += '<tr data-index="0" class="">';
            str += '<td style=""><input data-index="1" class="UnshareUser" name="btSelectItem" type="checkbox" checked></td>';
            str += '<td class="bs-checkbox"> {0} {1} </td>'.replace("{0}", item.Access.SharedAccess[i].SharedWith.FirstName).replace("{1}", item.Access.SharedAccess[i].SharedWith.LastName);
            str += '<td id="shareuseremail" style = ""> ' + item.Access.SharedAccess[i].SharedWith.Email + '</td>';
            str += '<td style = "display:none"> ' + item.Access.SharedAccess[i].SharedWith.UserId + '</td>';
        }     
    }
    tableRef.innerHTML = str;
}

function unshareDocumentWithSelectedUsers() {
    var unShareUserArray = [];

    $('input:checkbox[class="UnshareUser"]:not(:checked)').each(function () {
        var unshareUserID = $.trim($(this).parent().siblings(0)[2].innerText)
        var unShareUserForecast = { UnShareUserID: unshareUserID, projectName: getProject(), Version: currentForecast.version, loggedInUserId: getLoggedInUserId() };
        unShareUserArray.push(unShareUserForecast);
    });

    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    var url = "";
    if (type == 0)
        url = "/Forecast/UnShareDocument";
    else if(type == 1)
        url = "/Forecast/BDLUnShareDocument";
    else
        url = "/Forecast/ActharUnShareDocument";
    var postData = JSON.stringify(unShareUserArray);
    PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData(url, postData,
    function (result) {
        if (result.success) {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully Unshared " + currentForecast.name + " " + currentForecast.version, '');
            removeSharedWithValuesTocurrentForecast(unShareUserArray);
        }
        else
            PHARMAACE.FORECASTAPP.UTILITY.popalert("Unsharing document failed: " + result.errors.join(), '');
    },
    function (result) {
        PHARMAACE.FORECASTAPP.UTILITY.popalert("Unsharing document failed! " + result.responseText, '');
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
function getItemInModelByNameAndVersion(name, versionLabel) {
    var itemList = model.ForecastDetails.ItemList;
    for (var i = 0; i < itemList.length; i++) {
        if(itemList[i].Forecast == name)
            return getItemInModelByVersion(itemList[i], versionLabel);
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
            hideEDraw();
            createFreshForecast();
        }
    }
    function unProtectSheet()
    {
        try {
            objExcel.Workbooks(1).Worksheets("Generic_Forecast").Unprotect();
        }
        catch (e) {
            //eat exception
        }
    }
    function createFreshForecast() {
        showOverlay("Please Wait While We Create A New Forecast...");
        unProtectSheet();
        isSaveAsForecast = false;
        offlineSave = false;
        setTimeout(function () {
            try {
                //var projName = "";
                //var vbaMethod = "'{0}'!Create_Forecast_Generic".replace("{0}", objExcel.Workbooks(1).Name);
                //if (runMacro(vbaMethod)) {
                PHARMAACE.FORECASTAPP.GENERICS.Create_Forecast_Generic();
                setUnsaveCreateForecastName = true;
                var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
                //if (type == 0) {
                //    projName = objExcel.Workbooks(1).Worksheets("Master_List").Range("B2").Value;
                //}
                //else {
                //    projName = objExcel.Workbooks(1).Worksheets("Vars").Range("A2").Value;
                //}
                //if (!projName) {
                //    hideOverlay();
                //    return;
                //}

                var projName = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.Name;
                currentForecast.name = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.Name;
                currentForecast.version = 'V0.0';
                currentForecast.item = {};
                //var isCancelled = objExcel.Workbooks(1).Worksheets("Home").Range("A3").Value;
                //if (!isCancelled) {
                //vbaMethod = "'{0}'!InitializeDisplay".replace("{0}", objExcel.Workbooks(1).Name);
                //runMacro(vbaMethod);
                var x = document.getElementById("selectForecast");
                var i;
                var projectExistOrNot = false;
                var selectedProjName = $('#selectForecast option:selected').text();
                if (projName && selectedProjName !== projName) {
                    for (i = 0; i < x.length; i++) {
                        if ((x.options[i].text == projName)) {
                            projectExistOrNot = true;
                            bootbox.dialog({
                                message: 'Project Name already exists'
                            });
                            hideEDraw();
                            break;
                        }
                    }
                }
                else if (projName && selectedProjName == projName) {
                    hideOverlay();
                    return;
                }
                updateScreen();
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/CheckForExistingProjectName", { projName: projName, type: type },
                function (result) {
                    if (result.success) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Project Name already exists..", "");
                        hideEDraw();
                    }
                    else {
                        if (projName && selectedProjName != projName) {
                            if (!projectExistOrNot) {
                                saveNewForecast = true;
                                isCreatedOrRetrieved = true;
                                InitializeAssumptionAttachment();
                                createSetAssumptionSections(getSectionDetails());
                                updateScreen();
                                //populateLazy();
                                //populateSelectedList();
                                showEDraw();
                                //$('#crtnfcst').removeClass('col-md-3').addClass('col-md-2');
                                //$('#slctfcst').removeClass('col-md-12').addClass('col-md-5');
                                //  $("#import").removeAttr("style")
                                $('#Prdbox').css("display", "block");
                                //$('#Prdbox').removeClass('col-md-7').addClass('col-md-7');
                            }
                        }
                        populateSelectedList();
                        $('#Prdbox').css("display", "block");
                        $('#newbutton').addClass('imageclickdisable');
                        $('#saveasdesc').attr("placeholder", '');
                        $('#saveasdesc').attr("placeholder", currentForecast.name);
                        $('#saveasdesc').attr("title", currentForecast.name);
                        $('.navigationPane').css("display", "block");
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Project {0} created successfully".replace("{0}", currentForecast.name));
                    }
                },
               function (result) {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
               });
                //}
                enableButton();
                //}
                hideOverlay();
            }
            catch (e) {
                hideOverlay();
            }
        }, 500);
    }

    function editForecast(liElement, fast) {
        var name = $(liElement).attr('name');
        var versionLabel = $(liElement).attr('value');
        var isLatest = $(liElement).attr('latest') == 'true' ? true : false;
        addDisabledopen();
        if (isCreatedOrRetrieved) {
            bootbox.dialog({
                message: "Do you want to save your work?",
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
                                saveExcel();
                                editFreshForecast(name, versionLabel, isLatest, fast);
                            }
                        }
                    },
                    danger: {
                        label: "No",
                        className: "btn-default",
                        callback: function () {
                            isCreatedOrRetrieved = false;
                            editFreshForecast(name, versionLabel, isLatest, fast);
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
        }
        else {
            editFreshForecast(name, versionLabel, isLatest, fast);
        }
        $('#newbutton').removeClass('open-default').addClass('open-inline');
        $('#openbutton').removeClass('open-inline').addClass('open-default');
       
    }

    function actharRetrieveForecast(name, versionLabel, isLatest)
    {
        setUnsaveCreateForecastName = false;
        offlineSave = false;
        showOverlay("Retrieving {0} {1}...".replace('{0}', name).replace('{1}', versionLabel));
        try {
            setTimeout(function () {
                downloadFile(document.all.OA1, name, versionLabel, isLatest,
                    function (sPath, intermediatePath) {
                        objExcel.Workbooks(1).Worksheets("Home").Range("A1").Value = sPath.replace(getTempDirectory() + "\\", "");//getSelectedItemInModel().name;
                        currentForecast.item = getItemInModelByNameAndVersion(name, versionLabel);
                        applyAuthorization();
                        var vbaMethod = "'{0}'!Retrieve_Forecast".replace("{0}", objExcel.Workbooks(1).Name);
                        if (runMacro(vbaMethod)) {
                            isCreatedOrRetrieved = true;
                            currentForecast.name = name;
                            currentForecast.version = versionLabel;
                            saveNewForecast = false;
                            try {
                                objExcel.Workbooks(1).Worksheets("Vars").Range("M1").Value = 1;
                                
                            }
                            catch (e) {
                                //eat exception
                            }
                            InitializeAssumptionAttachment();
                            createSetAssumptionSections(getSectionDetails());
                            getAssumptions();
                            isRetrieving = true;
                            //populateSelectedList();
                            $('#Prdbox').css("display", "block");
                            populateIndicationListInActharModel(); //only for acthar model
                            updateProperties();
                            
                        }
                        $('.navigationPane').css("display", "block");
                        $('#saveasdesc').attr("placeholder", currentForecast.name);
                        $('#saveasdesc').attr("title", currentForecast.name);
                        enableButton();
                        //delete the temp folder in server -- getting logged out if we do this:please revisit
                        deleteIntermediate(intermediatePath);
                        onNewsLoaded();
                    });
            }, 500);
        }
        catch (e) {
            hideOverlay();
        }
    }


    function editFreshForecast(name, versionLabel, isLatest, fast) {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 2)             // acthar
        {
            actharRetrieveForecast(name, versionLabel, isLatest)   
        }
        else
        {                     // generic and bdl 
            unProtectSheet();
            setUnsaveCreateForecastName = false;
            offlineSave = false;
            showOverlay("Retrieving {0} {1}...".replace('{0}', name).replace('{1}', versionLabel));
            try {
                setTimeout(function () {
                    //downloadFile(document.all.OA1, name, versionLabel, isLatest,
                        //function (sPath, intermediatePath) {
                            //objExcel.Workbooks(1).Worksheets("Home").Range("A1").Value = sPath.replace(getTempDirectory() + "\\", "");//getSelectedItemInModel().name;
                            currentForecast.item = getItemInModelByNameAndVersion(name, versionLabel);
                            applyAuthorization();
                            //if (fast) {
                            downloadFileNew(name, versionLabel,
                                function (name, versionLabel) {
                                    isCreatedOrRetrieved = true;
                                    currentForecast.name = name;
                                    currentForecast.version = versionLabel;
                                    try {
                                        objExcel.Workbooks(1).Worksheets("Generic_Forecast").Activate();
                                    }
                                    catch (e) {
                                        //eat exception
                                    }
                                    saveNewForecast = false;
                                    try {
                                        objExcel.Workbooks(1).Worksheets("Vars").Range("B18").Value = 1;
                                    }
                                    catch (e) {
                                        //eat exception
                                    }
                                    InitializeAssumptionAttachment();
                                    createSetAssumptionSections(getSectionDetails());
                                    getAssumptions();
                                    isRetrieving = true;
                                    populateSelectedList();
                                    updateProperties();
                                    $('#Prdbox').css("display", "block");
                                    $('.navigationPane').css("display", "block");
                                    $('#saveasdesc').attr("placeholder", currentForecast.name);
                                    $('#saveasdesc').attr("title", currentForecast.name);
                                    enableButton();
                                })
                            //}
                            //else {
                            //    var vbaMethod = "'{0}'!Retrieve_Forecast".replace("{0}", objExcel.Workbooks(1).Name);
                            //    if (runMacro(vbaMethod)) {
                            //        isCreatedOrRetrieved = true;
                            //        currentForecast.name = name;
                            //        currentForecast.version = versionLabel;
                            //        try {
                            //            objExcel.Workbooks(1).Worksheets("Generic_Forecast").Activate();
                            //        }
                            //        catch (e) {
                            //            //eat exception
                            //        }
                            //        saveNewForecast = false;
                            //        try {
                            //            objExcel.Workbooks(1).Worksheets("Vars").Range("B18").Value = 1;
                            //            objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value = currentForecast.name;
                            //        }
                            //        catch (e) {
                            //            //eat exception
                            //        }
                            //    }
                            //    InitializeAssumptionAttachment();
                            //    createSetAssumptionSections(getSectionDetails());
                            //    getAssumptions();
                            //    isRetrieving = true;
                            //    populateSelectedList();
                            //    updateProperties();
                            //    $('#Prdbox').css("display", "block");
                            //    //$('#npvbox').css("display", "block");

                            //    $('.navigationPane').css("display", "block");
                            //    $('#saveasdesc').attr("placeholder", currentForecast.name);
                            //    $('#saveasdesc').attr("title", currentForecast.name);
                            //    enableButton();
                            //    objExcel.Workbooks(1).Worksheets("Master_List").Range("B2").Value = currentForecast.name;
                            //    //delete the temp folder in server -- getting logged out if we do this:please revisit
                            //    deleteIntermediate(intermediatePath);
                            //}
                        //});
                }, 500);
                //enableButton();


            }
            catch (e) {
                hideOverlay();
            }
        }
    }
    function deleteIntermediate(modelPath) {
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/DeleteTempFileContainer", { fullFilePath: modelPath },
            function (deleteResult) {
                //be silent
                var deleteSuccess = deleteResult.success;
            },
            function (deleteResult) {
                //be silent
                var deleteFailure = deleteResult;
            });
    }
    function applyAuthorization() {
        if (currentForecast.item && currentForecast.item.Access && currentForecast.item.Access.SharedAccess) //read only for the logged in user
            for (var i = 0; i < currentForecast.item.Access.SharedAccess.length; i++) {
                if (currentForecast.item.Access.SharedAccess[i].SharedWith.UserId == getLoggedInUserId() && currentForecast.item.Access.SharedAccess[i].AuthorizationLevel == 3) {
                    try{
                        objExcel.Workbooks(1).Worksheets("Home").Range("T1").Value = 3;
                    }
                    catch (e) {
                        //eat exception
                    }
                    break;
                }
            }
    }
    
    function projectOk() {
        projectOkCheck = true;
        showOverlay("Please wait while we set up the parameters...");
        try {
            var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
            if (isCountryChanged) {
                isScenarioChanged = true;
                try {
                    var countryDropdown = document.getElementById('selectCountry');
                    var sheet1 = objExcel.Workbooks(1).Worksheets("Vars");
                    sheet1.Range("V3").Value = countryDropdown.selectedIndex + 1;
                }
                catch (e) {
                    //eat exception
                }
            }
            if (isProductChanged) {
                isSKUChanged = true;
                isScenarioChanged = true;
                try {
                    var ele = document.getElementById('selectProduct');
                    selectedProductId = ele.options[ele.selectedIndex].value;
                }
                catch (e) {
                    //eat exception
                }

                getAssumptionsForSections();
                createSetAssumptionSections(getSectionDetails());
                fillAssumptions(true);
                updateProperties();
            }

            if (isSKUChanged) {
                try {
                    var ele = document.getElementById('selectSKU');
                    selectedSkuId = ele.options[ele.selectedIndex].value;
                }
                catch (e) {
                    //eat exception
                }
            }

            if (isScenarioChanged) {
                var scenarioDropdown = document.getElementById('selectScenario');
                if (modelType == 0) {
                    try {
                        var productIndex = document.getElementById('selectProduct');
                        selectedProductId = productIndex.options[productIndex.selectedIndex].value;
                        var SkuIndex = document.getElementById('selectSKU');
                        selectedSkuId = SkuIndex.options[SkuIndex.selectedIndex].value;
                        /** for checking data is present or not **/
                        //var sheet = objExcel.Workbooks(1).Worksheets("Vars");
                        var ele = document.getElementById('selectScenario');
                        selectedScenarioId = ele.options[ele.selectedIndex].value;
                        //sheet.Range("N4").Value = ele.selectedIndex + 1;
                        //var sheet = objExcel.Workbooks(1).Worksheets("Vars_1");
                        //sheet.Range("N3").Value = ele.selectedIndex + 1;
                    }
                    catch (e) {
                        //eat exception
                    }
                    //var dataIsInExcel = false;
                    //var vbaMethod = "'{0}'!Scenario_DropDown_Message".replace("{0}", objExcel.Workbooks(1).Name);
                    //var IsDataPresentInExcel = runMacro(vbaMethod);
                    //if (IsDataPresentInExcel == 1)
                    //    dataIsInExcel = true;
                }
                else if (modelType == 1) {
                    var sheet1 = objExcel.Workbooks(1).Worksheets("Vars");
                    sheet1.Range("BK1").Value = scenarioDropdown.selectedIndex + 1;
                }
                /**  check if data present or not **/
                var dataIsInExcel = false;
                var vbaMethod = "'{0}'!Scenario_DropDown_Message".replace("{0}", objExcel.Workbooks(1).Name);
                var IsDataPresentInExcel = runMacro(vbaMethod);
                if (IsDataPresentInExcel == 1)
                    dataIsInExcel = true;
                if (dataIsInExcel) {
                    bootbox.dialog({
                        message: "Do you want to use previous historical data?",
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
                                        objExcel.Workbooks(1).Worksheets("Home").Range("O1").Value = 1;
                                        setTimeout(function () {
                                            PHARMAACE.FORECASTAPP.GENERICS.getDataByProductSkuScenario();
                                        }, 200);
                                    }
                                }
                            },
                            danger: {
                                label: "No",
                                className: "btn-default",
                                callback: function () {
                                    objExcel.Workbooks(1).Worksheets("Home").Range("O1").Value = 0;
                                    setTimeout(function () {
                                        PHARMAACE.FORECASTAPP.GENERICS.getDataByProductSkuScenario();
                                    }, 500);
                                }
                            },
                        }
                    });

                }
                else {
                    objExcel.Workbooks(1).Worksheets("Home").Range("O1").Value = 0;
                    setTimeout(function () {
                        PHARMAACE.FORECASTAPP.GENERICS.getDataByProductSkuScenario();
                    }, 500);
                }
            }
            else {
                setTimeout(function () {
                    PHARMAACE.FORECASTAPP.GENERICS.getDataByProductSkuScenario();
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
        // getAssumptionsForSections();
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
        rememberChartValue = true;
        try {
            //setTimeout(function () {
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
                   
                }
            //}, 500);
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
        var displayFormulaBar = objExcel.DisplayFormulaBar;
        if (displayFormulaBar == true) {
            objExcel.DisplayFormulaBar = false;
            btnFormula.title = "Show Formula Bar";
        }
        else {
            objExcel.DisplayFormulaBar = true;
            btnFormula.title = "Hide Formula Bar";
        }
    }

    //function checkTypeForSaveExcel()                 // acthar
    //{
    //    var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    //    if(type == 0 || type == 1)
    //    {
    //        saveExcel();
    //    }
    //    else
    //    {
    //        var enableMinorVersion = false;
    //        var descr = document.getElementById('vDesc').value;
    //        if (descr == '') {
    //            descr = GetdefaultComment();
    //        }
    //        else {
    //            var description = GetdefaultComment();
    //            descr = descr + description;
    //        }
    //        if (document.getElementById('rbCustonVersion').checked) {
    //            enableMinorVersion = true;
    //        }
    //        var projName = currentForecast.name;
    //        var projectnameRename = document.getElementById('saveasdesc').value;
    //        if (projectnameRename == '') {
    //            projectnameRename = projName;
    //        }
    //        else {
    //            projectnameRename = document.getElementById('saveasdesc').value;
    //        }

    //        if (projectnameRename != projName) {
    //            isSaveAsForecast = true;
    //            IsSaveAsForecast(enableMinorVersion, descr, projectnameRename);
    //        }
    //        else
    //            saveForecast(enableMinorVersion, descr);
    //    }
    //}

    //save generic and bdl
    function saveExcel() {
        var nameOnly = getProject();
        var versionLabel = getVersion();
        if (versionLabel == -1)
            versionLabel = "V1";
        saveExcel1();
        enableButton();
        setUnsaveCreateForecastName = false;
    }
    function GetdefaultComment() {
        var username = loginEmail;
        var dt = new Date();
        dt = dt.toString().replace(/:\d{2} GMT/, " GMT");
        var description = "Saved By " + username + " at " + dt;
        return description;
    }
    function saveExcel1() {
        var enableMinorVersion = false;
        var descr = document.getElementById('vDesc').value;
        if (descr == '') {
            descr = GetdefaultComment();
        }
        else {
            var description = GetdefaultComment();
            descr = descr + description;
        }
        if (document.getElementById('rbCustonVersion').checked) {
            enableMinorVersion = true;
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
            saveForecast(enableMinorVersion, descr);
    }
    function UploadFileToServer(oa, filePathWithExtension, postKeyValues, enableMinorVersion, versionDescription) {
        if (checkJSNetConnection() == false) {
           hideOverlay();
           onJSButtonclick(0);
        }
        else {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/IsSignedIn", null,
            function (result) {
                if (result.success) {
                    oa.HttpInit();
                    oa.HttpAddPostFile(filePathWithExtension);
                    if (oa && postKeyValues) {
                        for (var i = 0; i < postKeyValues.length; i++)
                            oa.HttpAddPostString(postKeyValues[i].key, postKeyValues[i].value);
                    }
                    var res = oa.HttpPost(baseUrl + "/Forecast/SaveFile");
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
                                    currentForecast.version = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("L2").Value;
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
                           checkForecastSavedOrNot(nameOnly, enableMinorVersion);
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
        }
    }

    function checkForecastSavedOrNot(nameOnly, enableMinorVersion)
    {
        var expectedVersion = getExpectedVersion(enableMinorVersion, true, true);
        var userId = $('#btnprofile').attr("value");
        PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/getGuidForsaveForecast", JSON.stringify({ 'UserId': userId}),
           function (result) {
               if (result.success)
               {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert(" "+ result.errors.join(), '');
                   hideOverlay();
               }
               else {
                   if (isSaveAsForecast)
                       RefreshModelForSync(enableMinorVersion);
                   else
                       RefreshModel(nameOnly, enableMinorVersion);
                       hideOverlay();             
               }
           },
           function (result) {
               hideOverlay();
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save " +expectedVersion,'');
           });
    }

    function resolveVersion() {
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

    function buildUserForecastToShare(sharedWithId, authorization, versionDescription, isChecked) {
        var userForecast;
        if (isChecked == true) {
            userForecast = {
                Forecast: getProject(),
                Versions: [{
                    Label: null,
                    Comment: versionDescription,
                    Access: {
                        SharedAccess: [{
                            SharedWith: { UserId: sharedWithId },
                            SharedBy: { UserId: $('#btnprofile').attr("value") },
                            AuthorizationLevel: authorization
                        }]
                    }
                }]
            };
        }

        else {
            userForecast = {
                Forecast: getProject(),
                Versions: [{
                    Label: currentForecast.version,
                    Comment: versionDescription,
                    Access: {
                        SharedAccess: [{
                            SharedWith: { UserId: sharedWithId },
                            SharedBy: { UserId: $('#btnprofile').attr("value") },
                            AuthorizationLevel: authorization
                        }]
                    }
                }]
            };
        }
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
        
    function SaveForecastToServerForSaveAs(filePathWithExtension, enableMinorVersion, versionDescription, projectnameRename) {
        var postKeyValues = [];
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var extension = PHARMAACE.FORECASTAPP.UTILITY.getFileExtension(filePathWithExtension);
        postKeyValues[0] = { key: "Name", value: projectnameRename + '.' + extension };
        if (enableMinorVersion != undefined) {
            postKeyValues[1] = { key: "EnableMinorVersion", value: enableMinorVersion ? 1 : 0 };
        }
        postKeyValues[2] = { key: "ModelLocation", value: model.ModelLocation };
        postKeyValues[3] = { key: "type", value: type };
        postKeyValues[4] = { key: "isCreateFlag", value: saveNewForecast ? 1 : 0 };
        postKeyValues[5] = { key: "Description", value: versionDescription };

        UploadFileToServer(document.all.OA1, filePathWithExtension, postKeyValues, enableMinorVersion, versionDescription);
    }

    function SaveForecastToServer(filePathWithExtension, enableMinorVersion, versionDescription) {
        var postKeyValues = [];
        var extension = PHARMAACE.FORECASTAPP.UTILITY.getFileExtension(filePathWithExtension);
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        postKeyValues[0] = { key: "Name", value: getProject() + '.' + extension };
        if (enableMinorVersion != undefined) {
            postKeyValues[1] = { key: "EnableMinorVersion", value: enableMinorVersion ? 1 : 0 };
        }        
        postKeyValues[2] = { key: "ModelLocation", value: model.ModelLocation };
        postKeyValues[3] = { key: "type", value: type };
        postKeyValues[4] = { key: "isCreateFlag", value: saveNewForecast ? 1 : 0 };
        postKeyValues[5] = { key: "Description", value: versionDescription };
       
        UploadFileToServer(document.all.OA1, filePathWithExtension, postKeyValues, enableMinorVersion, versionDescription);
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
        var sku = getSKUIndex();
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
                        $('.editable-div:eq(' + sectionOrder + ')').html(desc);
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
                        $('.editable-div:eq(' + sectionOrder + ')').html(desc);
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
    function createSetAssumptionSections(sections) {
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));

        if (model.DisplayInitialModel)
            return;
        for (var i = 0; i < sections.length; i++) {
            if (type == 0 || type == 2) {
                var str = '<div class="banner section_note_write"><div class="panel panel-default"><div class="panel-heading">' + sections[i].name + '</div><div class="panel-body-assumption">';
            }
            else {
                var sheet = objExcel.Workbooks(1).Worksheets("Indication");
                var indicationValue = sheet.Range("A2").value;
                if (indicationValue) {
                    var strClass = "assump-" + sections[i].name.replace(/\s+/g, "-").toLowerCase();
                    var strHref = "active-" + sections[i].name.replace(/\s+/g, "").toLowerCase() + "#" + sections[i].name.replace(/\s+/g, "").toLowerCase();
                    var str = '<div class="banner section_note_write"><div class="panel panel-default"><div class="panel-heading">' + sections[i].name;
                    var link = 'ForecastReference?type=0&indicationValue={0}&href={1}';
                    str += '<a href=' + link.replace('{0}', encodeURI(indicationValue)).replace('{1}', strHref) + ' target ="_blank" class="  ' + strClass + ' pull-right" >';
                    str += '<img src="../../Content/img/icon-book.png" class="indicationimg"/></a></div><div class="panel-body-assumption">';
                }
                else {
                    var str = '<div class="banner section_note_write"><div class="panel panel-default"><div class="panel-heading">' + sections[i].name + '</div><div class="panel-body-assumption">';
                }

            }
            str += '<div class="maxheight">';
            str += '<div contenteditable="true" class="editable-div" placeholder="' + sections[i].name + ' Notes"></div>';
            str += '</div><div class="attach-box"><ul class="list-inline attachment_icons"></ul></div>';
            str += '</div></div></div>';
            var ele = document.getElementById('set_assumptions');
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
        str1 += '<div class="padding-box "><div class="col-md-4 no-padding-left">Shared</div><div class="col-md-8 no-padding-right" id="shared_with">shared with</div> </div> </div> </div>';
        ele.innerHTML = ele.innerHTML + str1;
    }
    
    function applyBookMark(sections) {
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
                            attachments[j] = { AttachmentName: attachmentMap[i][j].name, AttachmentPath: attachmentMap[i][j].url };
                        else
                            attachments[j] = {};
                    }
                }
            }
            var actualIndex = i - startIndex;
            var desc = $('.section_note_write>div:eq(' + actualIndex + ')>div:eq(1)>div:eq(0)>div').html();
            if (type == 0 || type == 1) {
                assumptionSet[i] = {
                    Project: getProject(),
                    Version: getLatestVersionLabel(),
                    Product: prodIndex,
                    SKU: getSKUIndex(),
                    Scenario: getScenarioIndex(),
                    Section: actualIndex + 1,
                    Description: desc
                };
            } else if(type == 2)
            {
                assumptionSet[i] = {
                    Project: getProject(),
                    Version: getLatestVersionLabel(),
                    Indication: prodIndex,
                    Section: actualIndex + 1,
                    Description: desc
                };
            }
                if (attachments && attachments.length > 0) {
                    assumptionSet[i].Attachments = attachments;
                }
        } 
        }
    
    function populateAllAttachments() {
        if (!assumptionSet)
            assumptionSet = [];
        for (var i = 0; i < attachmentMap.length; i++) {
            var attachments = [];
            if (attachmentMap) {
                if (attachmentMap[i]) {
                    for (var j = 0; j < attachmentMap[i].length; j++) {
                        if (attachmentMap[i][j].name)
                            attachments[j] = { AttachmentName: attachmentMap[i][j].name, AttachmentPath: attachmentMap[i][j].url };
                        else
                            attachments[j] = {};
                    }
                }
            }
            if (attachments && attachments.length > 0) {
                assumptionSet[i].Attachments = attachments;
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
                            saveExcel();
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
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Forecast Version " + expectedVersion + " Saved Successfully", '');
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
    function RefreshModel(nameOnly, enableMinorVersion) {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/ForecastEntity", { type: modelType },
            function (result) {
                if (result.success) {
                    model = result.entity;
                    populateControls();             
                    //if (modelType == 0 || modelType == 1) {  // generic and bdl 
                        var desiredValue = getProject();
                        updateProperties();
                        uploadAttachments(function () {
                            SaveAssumptions(enableMinorVersion);
                        });
                   // }
                    //else            // acthar
                    //{
                    //    SaveAssumptions(enableMinorVersion);
                    //}
                }
                else {
                    //alert?
                }
                hideOverlay();
            },
            function (result) {
                hideOverlay();
            });
    }
    function SaveAssumptions(isMinor) {
        var expectedVersion = getExpectedVersion(isMinor, true, true);
        var projectName = currentForecast.name;
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        //if (modelType == 0 || modelType == 1) {  //  acthar
            if (offlineSave == false) {
                getAssumptionsForSections();
                mapAttachmentsBeforeSave();
            }
        //}

        PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Forecast/SetAssumptions", JSON.stringify({ 'assumptions': assumptionSet, 'type': modelType, 'ProjectName': projectName }),
            function (result) {
                if (result.success) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Forecast Version " + projectName + " " + result.Version + " Saved Successfully", '');
                    currentForecast.version = result.Version;
                    currentForecast.item = getItemInModelByNameAndVersion(projectName, currentForecast.version);
                    updateProperties();
                    hideOverlay();
                    //if (offlineSave == true) {
                    //    if (modelType == 0)
                    //        objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("L2").Value = result.Version;
                    //    else if (modelType == 1)
                    //        objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("I2").Value = result.Version;
                    //}
                    offlineSave = false;
                }
                else {
                    hideOverlay();
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save" + expectedVersion + ": " + result.errors.join(), '');
                }
            },
            function (result) {
                hideOverlay();
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not save " + getExpectedVersion(isMinor, true), '');
                clearAttachments();
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
       // offlineSave = false;
        currentForecast.name = projectnameRename;
        var expectedForecastVersion = getExpectedVersionForSaveAs(enableMinorVersion, false, projectnameRename);
        if (expectedForecastVersion == false)
            return;
        showOverlay("Saving " + expectedForecastVersion);

        setTimeout(function () {
            try {
                objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value = projectnameRename;
                objExcel.Workbooks(1).Worksheets("Master_List").Range("B2").Value = projectnameRename;
                var vbaMethod = "'{0}'!Save_Forecast".replace("{0}", objExcel.Workbooks(1).Name);
                var filePathWithExtension = runMacro(vbaMethod);
                //objExcel.EnableEvents = false;
                if (filePathWithExtension && filePathWithExtension.length > 0)
                    SaveForecastToServerForSaveAs(filePathWithExtension, enableMinorVersion, versionDescription, projectnameRename);
            }
            catch (e) {
                hideOverlay();
            }
        }, 500);
    }

    function saveForecast(enableMinorVersion, versionDescription) {
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        isSaveAsForecast = false;
            var expectedForecastVersion = getExpectedVersion(enableMinorVersion, false);
            if (expectedForecastVersion == false)
                return;
        showOverlay("Saving Forecast " +currentForecast.name + " to it's next version...");
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
                        SaveForecastToServer(filePathWithExtension, enableMinorVersion, versionDescription);
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
    }
    function updateScreen(forceUpdate) {
        if (objExcel && (!objExcel.ScreenUpdating || forceUpdate))
            objExcel.ScreenUpdating = true;
    }
    function stopUpdateScreen() {
        if (objExcel && !objExcel.ScreenUpdating)
            objExcel.ScreenUpdating = false;
    }
    function loadUsers() {
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetAllUsers", null,
                function (result) {
                    if (result.success) {
                        populateSharePopup(result.users);
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
    function populateSharePopup(users) {
        var tableRef = document.getElementById('shared_users_table').getElementsByTagName('tbody')[0];
        var str = '';
        users.forEach(function (user) {
            str += '<tr data-index="0" class="">';
            str += '<td style=""><input data-index="1" class="shareUser" name="btSelectItem" type="checkbox"></td>';
            str += '<td class="bs-checkbox"> {0} {1} </td>'.replace("{0}", user.FirstName).replace("{1}", user.LastName);
            str += '<td id="shareuseremail" style = ""> ' + user.Email + '</td>';
            str += '<td style = "display:none"> ' + user.UserId + '</td>';
            str += '<td style=""><input data-index="1" class="ViewOnlyUser" name="btSelectItem" type="checkbox"></td>';
            str += '<td style=""><input data-index="1" class="ShareAllVersion" name="AllVersion" type="checkbox"></td>';
        })
        tableRef.innerHTML = str;
    }
    function shareDocumentWithSelectedUsers() {
        var userArray = [];
        var userForecastMapping = [];
        userArrayShared = [];
        var isChecked;

        if ($(".ShareAllVersion").is(':checked')) {
            isChecked = true;
        }
        else {
            isChecked = false;
        }

        $('input:checkbox[class="shareUser"]:checked').each(function () {

            userArray.push(parseInt($.trim($(this).parent().siblings(0)[2].innerText)));
            var userId = $.trim($(this).parent().siblings(0)[2].innerText)
            var name = $.trim($(this).parent().siblings(0)[0].innerText)
            var email = $.trim($(this).parent().siblings(0)[1].innerText)
            var authLevel = 2;

            var checkAuthLevel = $(this).parent().parent().find('.ViewOnlyUser');
            if (checkAuthLevel && checkAuthLevel.length == 1) {
                if (checkAuthLevel[0].checked == true) {
                    authLevel = 3;
                }
            }
            var shareComment = ""; //to be added to the UI
            userForecastMapping.push(buildUserForecastToShare(userId, authLevel, shareComment, isChecked));
            userArrayShared.push(refreshUserForecastShared(userId, authLevel, name, email));
        });

        shareDocumentWithUsers(undefined, undefined, userForecastMapping);
    }

    function shareDocumentWithUsers(nameOnly, enableMinorVersion, userForecastMapping) {
        var version = null;
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var url = "";
        if(type == 0)
            url = "/Forecast/ShareDocument";
        else if(type == 1)
            url = "/Forecast/BDLShareDocument";
        else
            url = "/Forecast/ActharShareDocument";

        var postData = JSON.stringify(userForecastMapping);
        PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData(url, postData,
            function (result) {
                if (nameOnly != undefined && enableMinorVersion != undefined) {
                    //new forecast - this should hit while saving only
                    if (isSaveAsForecast)
                        RefreshModelForSync(enableMinorVersion);
                    else
                        RefreshModel(nameOnly, enableMinorVersion);
                }
                else {
                    if (result.success) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully shared " + currentForecast.name, '');
                        addSharedWithValuesTocurrentForecast(userArrayShared);
                    }
                    else
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Sharing document failed: " + result.errors.join(), '');
                }
            },
            function (result) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Sharing document failed! " + result.responseText, '');
            });
        $('.overlay#openShare').trigger('hide');
        return false;
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
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Forecast/GetAssumptions", { project: getProject(), version: versionWithV, modelLocation: model.ModelLocation, type: modelType },
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
        var sectionCount = $('.section_note_write').length;
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
    function getProject() {
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
        if (!project || project.length == 0) {
            project = currentForecast.name;
        }
        return project;
    }
    function getVersion() {
        return currentForecast.version;
    }    
    function getProduct() {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (modelType == 0) {
            var ele = document.getElementById('selectProduct');
            if (ele && ele.options && ele.options[ele.selectedIndex])
                return ele.options[ele.selectedIndex].text;
        }
        if (modelType == 1) {
            //TO DO: need to return the entire list of products
            var firstInlineProduct = objExcel.Workbooks(1).Worksheets("Vars").Range("L3").Value;
            if (firstInlineProduct)
                return firstInlineProduct;
            var firstPipelineProduct = objExcel.Workbooks(1).Worksheets("Vars").Range("Q3").Value;
            return firstPipelineProduct;
        }
    }
    function getProductIndex(fromDropdown) {
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
        return objExcel.Workbooks(1).Worksheets("Vars").Range("B20").Value;
    }
    function getScenarioIndex() {
        var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        var selectedScenarioCell = "";
        if (modelType == 0)
            scenarioSheet = "B22";
        if (modelType == 1)
            scenarioSheet = "BK1";
        if (selectedScenarioCell)
            return objExcel.Workbooks(1).Worksheets("Vars").Range(selectedScenarioCell).Value;
        return 1;
    }
    function getLatestVersionLabel() {
        var latest = currentForecast.item.latest;
        if (!latest)
            latest = currentForecast.version;
        return latest;
    }

    function setUnsavedCreateForecastName() {
        var type = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
        if (type == 0 || type == 1) {
            var newProjName = objExcel.Workbooks(1).Worksheets("ProjectDetails").Range("A2").Value;
        }
        else
        {
            var newProjName = objExcel.Workbooks(1).Worksheets("Vars").Range("A1").Value;
        }
        var valueLabel = "V0.0";
        var selectforecastOption = '<li name="{0}" value="{1}" latest="{2}" class="dropdown-submenu forecast-version"><a href="#">{0}</a></li>'.replaceAll("{0}", newProjName).replaceAll("{1}", valueLabel);
        $('#selectForecast').prepend(selectforecastOption);        
    }
    function onProductUpdateForChart() {
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

       // alert("hi");
        try {
            objExcel.Workbooks(1).Worksheets("NPV").Activate();
        }
        catch (e) {
            //eat exception
        }
    });


    $('#chartbox').click(function (e) {
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

    });

    function bdlLoadCountryForChart() {
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

    //$("#prdbox").click(function (e) {
    //    var modelType = parseInt(PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('type'));
    //    if (modelType == 2) 
    //    {
    //        populateIndicationListInActharModel();
    //    }
    //});


    function populateIndicationListInActharModel()
    {
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
        var cntrySelectList = $('#selectCountry');
        if (cntrySelectList && cntrySelectList.length > 0) {
            cntrySelectList.html('');
            var countryValue = objExcel.Workbooks(1).Worksheets("vars");
            var countOfCountries = countryValue.Range("V7").Value;
            for (i = 1; i <= countOfCountries; i++) {
                var row = 2;
                var col = 23;
                cntrySelectList.append("<option value=" + countryValue.Cells(row, col).value + ">" + countryValue.Cells(row, col).value + "</option>");
                $("#selectProduct option:selected").val();
                row++;
            }


        }
    }
    function loadProduct() {
        var productSelectList = $('#selectProduct');
        if (productSelectList && productSelectList.length > 0) {
            productSelectList.html('');
            //var productValue = objExcel.Workbooks(1).Worksheets("ProductDetails");
            //var row = 2;
            //var col = 1;
            for (var i = 0; i < PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts.length; i++) {
                productSelectList.append("<option value=" + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[i].UniqueId + ">"
                    + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[i].Name + "</option>");
            }

        }
        updateFeed();
    }

    function loadSKU() {
        //return;
        try {
            var skuSelectList = $('#selectSKU');
            if (skuSelectList && skuSelectList.length > 0) {
                skuSelectList.html('');
                var ele = document.getElementById('selectProduct');
                var prod = PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.ForecastProducts[ele.selectedIndex];
                for (var i = 0 ; i < prod.SKUs.length; i++) {
                    skuSelectList.append("<option value=" + prod.SKUs[i].Id + ">" + prod.SKUs[i].Name + "</option>");
                }
                //skuValue = objExcel.Workbooks(1).Worksheets("Master_List");
            }
        }
        catch (e) {
            //eat exception
        }
    }

    function loadScenario() {
        var scenarioSelectList = $('#selectScenario');
        if (scenarioSelectList && scenarioSelectList.length > 0) {
            scenarioSelectList.html('');
            for (var i = 0 ; i < PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.Scenarios.length; i++) {
                scenarioSelectList.append("<option value=" + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.Scenarios[i].Id + ">"
                    + PHARMAACE.FORECASTAPP.GENERICS.forecastData.fv.Scenarios[i].Name + "</option>");
            }
        }
    }
    function disableCommands() {
        for (var i = 1; i <= objExcel.CommandBars.Count; i++) {
            objExcel.CommandBars(i).Enabled = false;
        }
    }
    function disableKeys() {

        //Shift key = "+"  (plus sign)
        //Ctrl key = "^"   (caret)
        //Alt key = "%"    (percent sign)
        //We fill the array with this keys and the key combinations
        //Shift-Ctrl, Shift- Alt, Ctrl-Alt, Shift-Ctrl-Alt
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

</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
    </body>
