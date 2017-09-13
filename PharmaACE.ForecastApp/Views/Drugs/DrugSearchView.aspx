<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.DrugSearchList>" %>
<%@ Import Namespace="PharmaACE.ForecastApp.Business" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
         <%: Styles.Render("~/Content/KMProductdetailCSS") %>

   <%-- <div class="container" id="contentbox">
    <%Html.RenderPartial("GetDrugs"); %>
    </div>--%>
    
     <div class="container" id="contentbox">
        <div class="" id="kmoverlayid">
            <div id="Search"><% Html.RenderPartial("_Search"); %></div>
           <%-- <div id="SearchResult">--%>
                <% Html.RenderPartial("GetDrugs"); %>
            <%--</div>--%>
           
            <div class="kmBox25">
                <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
   <%: Scripts.Render("~/Scripts/DrugsIndexScript") %>
    <script>
        $(document).ready(function () {
            
            document.getElementById('searchInput').innerHTML = '<%= ViewData["searchKey"] %>'
            var element = document.getElementById('example');
            //element.innerHTML = data;
            PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView(element);
            if (($("#tbltfoot") && $("#tbltfoot").length > 0)) {
                PHARMAACE.FORECASTAPP.UTILITY.filteration(populateSummary);
            }
            //PHARMAACE.FORECASTAPP.UTILITY.loadScript('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css', function () {
            //    PHARMAACE.FORECASTAPP.UTILITY.loadScript('https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js', function () {
            //    });
            //});
            $('.selectpicker').selectpicker({
                style: 'btn-default',
                size: 4
            });

            $('#searchbar .selectBox').click(function () {
                if ($('#searchbar .select-dropdown').hasClass('open')) {
                    $('#SearchResult').css("z-index", "0");
                    $('#drugsid').css("z-index", "0");
                }
                else {
                    $('#SearchResult').css("z-index", "-1");
                    $('#drugsid').css("z-index", "-1");
                }
            });
            //This is for visible dtatable searchbox after dropdown select
            $(document).on('click', function (e) {
                if (!$('#searchbar div.select-dropdown').hasClass('open')) {
                    $('#SearchResult').css("z-index", "0");
                    $('#drugsid').css("z-index", "0");
                }
            });



        $('input[type="checkbox"]').on('change', function () {
            var searchText = $("#searchInput").val();
            if (searchText != "") {
                getDrugs($("#searchInput").val(), 1);     
                return false;
            }
            else
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
        });
        $('#searchbar').submit(function () {
           // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
            var searchText = $("#searchInput").val();
            if (searchText != "") {
                getDrugs($("#searchInput").val(), 1);    
                return false;
            } else
                //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
        });
        $('#SearchABCD').on('click', '> *', function () {
           // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
            getDrugs(this.id, 2);    
        });
        function getDrugs(searchKey, condition) {
            var e = document.getElementById("search-filter-dropdown");
            var searchParam = e.options[e.selectedIndex].value;
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
                PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Drugs/GetDrugs", { searchKey: searchKey, searchParam: searchParam, searchCondition: condition, switchView: false, searchModule: searchModule },
                    function (data) {
                        //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
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
                       // PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                        PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                    });
            }
            else
                //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select drug type..");
        }
        function popup() {
            $('[data-rel=popover]').popover({
                placement: 'top'
            });
        }




        });
        $(document).ajaxSend(function (event, request, settings) {
            $('#SearchResult').hide();
            //$('#loading-indicator').show();
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
        });
        $(document).ajaxComplete(function (event, request, settings) {
            //$('#loading-indicator').hide();
            //$('#SearchResult').show();
            PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
        });
    </script>
  <%--  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/i18n/defaults-*.min.js"></script>--%>
    <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
   
</asp:Content>

