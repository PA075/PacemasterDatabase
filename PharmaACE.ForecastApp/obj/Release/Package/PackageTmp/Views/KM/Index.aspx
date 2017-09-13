<%@ Page Title="KM Home" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Knowledge Base
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%: Scripts.Render("~/Scripts/siteMasterLIB") %>
<%-- <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js" defer></script>
    <script src="../../scripts/lib/jquery/datatables.colvis.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>--%>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
<%-- <%: Scripts.Render("~/Scripts/KMIndexScript") %>--%>
    
    <div class="container" id="km-home-page">
        <div class="">
            <div id="content-box" class="col-md-12">
                <div id="kmoverlayid"class="row">
                    <div class="main-content-box">
                        <div class="" id="kmcontainer">
                            <div class="row" id="hpagegrid">
                                <div class="col-md-12 col-sm-12 col-xs-12 app-bar wow fadeInDown animated" style="visibility: visible; animation-name: fadeInDown;">
                                    <div class="">
                                        <div class="row" data-wow-duration="4s">
                                            <div class="col-xs-6  col-sm-4 col-md-3">
                                                <div class="panel panel-default img-zoom box-shadow--8dp ">
                                                    <div class="panel-heading">Disease Area</div>
                                                    <div class="panel-body">
                                                        <span class="ZPtooltip-rht IC-m-cls S20 ZProtate  down " title="" data-placement="bottom" data-toggle="tooltip" id="zp_minimax_leftpanel" onclick="ZPeople.minmaxTab(false);" data-original-title=" Maximize "></span>
                                                        <a href="<%=Url.Action("Index", "DiseaseArea")%>">
                                                            <img title="Disease Area" alt="Disease Area" src="../../Content/img/dieseas.jpg"></a><br />
                                                        Detail overview for more than 250 indications across various therapy areas – Risk factors, Symptoms and Diagnosis, Treatment Regimens etc. 
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6  col-sm-4 col-md-3">
                                                <div class="panel panel-default img-zoom box-shadow--8dp ">
                                                    <div class="panel-heading">Drugs</div>
                                                    <div class="panel-body">
                                                        <a href="<%=Url.Action("Index", "Drugs")%>">
                                                            <img title="Drugs" alt="Drugs" src="../../Content/img/drugs.jpg"></a><br />
                                                        More than 10,000 Brands, Biologics and Generics of inline database which updated monthly – Dosing, Price, Indication, MoA etc.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-6  col-sm-4 col-md-3">
                                                <div class="panel panel-default img-zoom box-shadow--8dp  ">
                                                    <div class="panel-heading">Clinical Trials</div>
                                                    <div class="panel-body">
                                                        <a href="<%=Url.Action("Index", "ClinicalTrials")%>">
                                                       <%-- <a href="<%=Url.Action("Index", "UnderConstruction")%>">--%>
                                                            <img title="Clinical Trials" alt="Clinical Trials" src="../../Content/img/clinical.jpg"></a><br />
                                                        The entire clinical trials landscape available in easy to comprehend structure – Sponsors, Locations, Design, Completion Date, Development Phase
                                                    </div>
                                                </div>
                                            </div>

                                          <div class="col-xs-6  col-sm-4 col-md-3">
                                                <div class="panel panel-default img-zoom box-shadow--8dp ">
                                                    <div class="panel-heading">Patent</div>
                                                    <div class="panel-body">
                                                        <%--<a href="#">
                                                            <img title="Others" alt="Others" src="../../Content/img/others.jpg"></a><br />
                                                        Epidemiology, Analog Finder, Videos, Live News feeds…<br />
                                                        <br />--%>
                                                     <a href="<%=Url.Action("Index", "Patent")%>">
                                                            <img title="Patent" alt="Patent" src="../../Content/img/others.jpg"></a><br />
                                                    </div>
                                                </div>
                                            </div>

<%--                                            <div class="col-xs-6  col-sm-4 col-md-3">
                                                <div class="panel panel-default img-zoom box-shadow--8dp ">
                                                    <div class="panel-heading">Others</div>
                                                    <div class="panel-body">
                                                        <a href="#">
                                                            <img title="Others" alt="Others" src="../../Content/img/others.jpg"></a><br />
                                                        Epidemiology, Analog Finder, Videos, Live News feeds…<br />
                                                        <br />
                                                    </div>
                                                </div>
                                            </div>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="Search">
                            <% Html.RenderPartial("_SearchWithOptionList"); %>
                        </div>
                        <div id="SearchResult">
                        </div>
                        <div style="text-align: center; vertical-align: middle;">
                            <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
     <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnprofile').click(function () {
                if ($("#myprofileid").css("display") == "none") {
                    $("#myprofileid").css("display", "block");
                }
                else {
                    $("#myprofileid").css("display", "none");
                }
            });
            $('#myprofileid li a').click(function () {
                if ($("#myprofileid").css("display") == "none") {
                    $("#myprofileid").css("display", "block");
                }
                else {
                    $("#myprofileid").css("display", "none");
                }
            });
        });
    </script>
    <script>
        $('#exportall').css("display", "block");
        $('input[type="checkbox"]').on('change', function () {
            var searchText = $("#searchInput").val();
            var searchModule = null;
            var searchParam = "1";
            var searchCondition = "2";
            var chkinline = document.getElementById("chkInline").checked
            var chkpipeline = document.getElementById("chkPipeline").checked;
            if ((chkinline) && (chkpipeline))
                searchModule = 0
            if ((!chkinline) && (chkpipeline))
                searchModule = 2
            else if ((chkinline) && (!chkpipeline))
                searchModule = 1
            if (searchModule != null) {
                if (searchText != "") {
                    getDrugs($("#searchInput").val(), searchParam, searchCondition, searchModule);
                    return false;
                }
                else
                {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
                }
            }
            else
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select drug type..");
        });
        $('#searchbar').submit(function () {
            //PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "SearchResult", "15", "");
            var ele = document.getElementById('search-filter-dropdown');
            var selectedSearchType = ele.options[ele.selectedIndex].value;
            var searchKey = $("#searchInput").val();
            if (searchKey.length < 1) {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
                return false;
            }
            else {
                switch (selectedSearchType) {
                    case "drug-name":
                        //PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "SearchResult", "15", "");
                        document.getElementById('SearchResult').innerHTML = '';
                        var searchParam = "1";
                        var searchCondition = "2";
                        var searchModule = null;
                        var chkinline = document.getElementById("chkInline").checked
                        var chkpipeline = document.getElementById("chkPipeline").checked;
                        if ((chkinline) && (chkpipeline))
                            searchModule = 0
                        if ((!chkinline) && (chkpipeline))
                            searchModule = 2
                        else if ((chkinline) && (!chkpipeline))
                            searchModule = 1
                        if (searchModule != null) {
                            getDrugs(searchKey, searchParam, searchCondition, searchModule);
                            return false;
                        }
                        else
                            //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select drug type..");
                       
                        
                        break;
                    case "DiseaArea":
                        
                        document.getElementById('SearchResult').innerHTML = '';
                        PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "SearchResult", "15", "");
                        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/DiseaseArea/DiseaseAreaSearch", { DiseaseName: searchKey, searchCondition: 1, searchModule: searchModule },
                          function (data) {
                              PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
                              document.getElementById('SearchResult').innerHTML = data;
                          },
                          function (status) {
                              PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
                              PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                          });
                        return false;
                        break;
                    case "Molecule":
                       
                        document.getElementById('SearchResult').innerHTML = '';
                        var searchParam = "2";
                        var searchCondition = "1";
                        var searchModule = null;
                        var chkinline = document.getElementById("chkInline").checked
                        var chkpipeline = document.getElementById("chkPipeline").checked;
                        if ((chkinline) && (chkpipeline))
                            searchModule = 0
                        if ((!chkinline) && (chkpipeline))
                            searchModule = 2
                        else if ((chkinline) && (!chkpipeline))
                            searchModule = 1
                        if (searchModule != null) {
                            getDrugs(searchKey, searchParam, searchCondition, searchModule);
                            return false;
                        }
                        else
                            //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select drug type..");

                        break;
                }
                return false;
            }
        });
        function getDrugs(searchKey, searchParam, searchCondition, searchModule) {
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "SearchResult", "15", "");
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Drugs/GetDrugs", { searchKey: searchKey, searchParam: searchParam, searchCondition: searchCondition, switchView: false, searchModule: searchModule },
            function (data) {
                
                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
                var element = document.getElementById('SearchResult');
                element.innerHTML = data;
                PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView(element);
                if (($("#tbltfoot") && $("#tbltfoot").length > 0)) {
                    PHARMAACE.FORECASTAPP.UTILITY.filteration(populateSummary);
                }
                PHARMAACE.FORECASTAPP.UTILITY.loadScript('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css', function () {
                    PHARMAACE.FORECASTAPP.UTILITY.loadScript('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js', function () {
                    });
                });
                $('.selectpicker').selectpicker({
                    style: 'btn-default',
                    size: 4
                });
            },
                function (status) {
                    PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
                    PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                });
        }
        //$(document).ajaxSend(function (event, request, settings) {
        //   // $('#SearchResult').hide();
        //    //$('#loading-indicator').show();
        //    //PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "SearchResult", "15", "");
        //});
        //$(document).ajaxComplete(function (event, request, settings) {
        //    //$('#loading-indicator').hide();
        //    //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("SearchResult");
        //   // $('#SearchResult').show();
        //});

        $("#search-filter-dropdown").change(function () {
            var Selectedfilter = this.value;

            if (Selectedfilter == "drug-name") {
                $('#search-type').css("display", "block");
            }
            else if (Selectedfilter == "DiseaArea") {
                $('#search-type').css("display", "none");
            }
        });
    </script>
</asp:Content>
