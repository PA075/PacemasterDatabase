<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Disease Area
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div id="sidemenu">
                <% Html.RenderAction("_DiseaseIndicationMenu", "DiseaseIndicationMenu"); %>
            </div>
            <div id="contentbox" class="col-md-9">
                <div id="kmoverlayid">
                <div id="Search">
                    <% Html.RenderPartial("_DSearch"); %>
                </div>
                    </div>
                <h2>Disease Area</h2>
                <div id="SearchResult"></div>
            <br />
            <br />
                <div style="text-align: center; vertical-align: middle;">
                    <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">

  <%--  <%: Scripts.Render("~/Scripts/serviceLIB") %>
    <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js" defer></script>--%>
    <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <%: Scripts.Render("~/Scripts/DiseaseAreaIndexScript") %>
    <script>
        $(document).ready(function () {

            if ('<%=Session["DAReturnBack"]%>' != null && '<%=Session["DAReturnBack"]%>' == 'True') {
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "kmoverlayid", "15", "");
            var DiseaseName = '<%=Session["DiseaseName"]%>';
            $("#searchInput").val(DiseaseName);
             var searchCondition = '<%=Session["searchParam"]%>';
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/DiseaseArea/DiseaseAreaSearch", { DiseaseName: DiseaseName, searchCondition: 1, SearchType: 1 }, //contains
               function (data) {
                   document.getElementById('SearchResult').innerHTML = data;
                   PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
               },
               function (status) {
                   PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                   alert(status);
               });
          
        }
        });
        $('#searchbar').submit(function () {        
            var DiseaseName = $("#searchInput").val();     // passed as parameters to Index details Method 
            if (DiseaseName != "") {
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "kmoverlayid", "15", "");
    
               PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/DiseaseArea/DiseaseAreaSearch", { DiseaseName: DiseaseName, searchCondition: 1, SearchType: 1 }, //contains
                   function (data) {
                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                       document.getElementById('SearchResult').innerHTML = data;

                   },
                   function (status) {
                       PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                       alert(status);
                   });
               return false;
            }
            else
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
            
        });
        var count = 0;
        var PreId = "";
        $('#SearchABCD').on('click', '> *', function () {
            if (this.id != PreId) {
                onclick = document.getElementById(this.id).style.backgroundColor = '#d4d4d4';
            }
            if (count != 0 && this.id != PreId) {
                onclick = document.getElementById(PreId).style.backgroundColor = '#fff';
            }
            count++;
            PreId = this.id;
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "kmoverlayid", "15", "");
            SearchFunctionWithKey(this.id);      
        });
        function SearchFunctionWithKey(s) {
            
            var DiseaseName = s;
            $("#searchInput").val('');            
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/DiseaseArea/DiseaseAreaSearch", { DiseaseName: DiseaseName, searchCondition: 2, SearchType: 1 }, //starts with
                function (data) {
                   
                    document.getElementById('SearchResult').innerHTML = data;
                     PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                     
                },
                function (status) {
                   PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
                    alert(status);
                });
        }
        //$(document).ajaxSend(function (event, request, settings) {
        //    // $('#SearchResult').hide();
        //   $('#SearchResult').show();
        //   // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "kmoverlayid", "15", "");
        //});
        //$(document).ajaxComplete(function (event, request, settings) {
        //    //$('#loading-indicator').hide();
        //   // PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
        //    //showOverlay("Getting data");
        //   $('#SearchResult').show();
        //});
    </script>
</asp:Content>
           