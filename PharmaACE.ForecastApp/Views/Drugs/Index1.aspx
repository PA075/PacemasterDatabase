<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<PharmaACE.ForecastApp.Models.Drug>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Drugs
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%--    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />--%>
<%--    <link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />--%>
    <%--<script src="../../Scripts/export/buttons.flash.min.js"></script>
    <script src="../../Scripts/export/buttons.html5.min.js"></script>
    <script src="../../Scripts/export/dataTables.buttons.min.js"></script>
    <script src="../../Scripts/export/buttons.print.min.js"></script>
        <link href="../../Scripts/export/buttons.dataTables.min.css" rel="stylesheet" />--%>
<%--    <link href="../../Scripts/export/buttons.dataTables.css" rel="stylesheet" />--%>
    <script src="../../Scripts/export/dataTables.tableTools.min.js"></script>
        <script src="../../Scripts/export/copy_csv_xls_pdf.swf"></script>

<%--    <a href="../../Scripts/export/copy_csv_xls_pdf.swf">../../Scripts/export/copy_csv_xls_pdf.swf</a>--%>
    <script src="../../Scripts/export/dataTables.buttons.min.js"></script>
    <script src="../../Scripts/export/buttons.flash.min.js"></script>
    <script src="../../Scripts/export/jszip.min.js"></script>
    <script src="../../Scripts/export/pdfmake.min.js"></script>
    <script src="../../Scripts/export/vfs_fonts.js"></script>
    <script src="../../Scripts/export/buttons.html5.min.js"></script>
    <script src="../../Scripts/export/buttons.print.min.js"></script>
           <%: Styles.Render("~/Content/KMDrugCSS") %>


   
    <div id="popalert" class="modal" style="overflow: visible;" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <p style="text-align: center"></p>
                </div>
            </div>
        </div>
    </div>
    <div class="container " id="contentbox">

        <div class="reportdynamidiv" id="kmoverlayid">
            <div id="Search"><% Html.RenderPartial("_Search"); %>
                <%--<% Html.RenderAction("RenderSearch","Drugs"); %>--%>
            </div>
            <div id="SearchResult" class="kmBox19"></div>
            <br />
            <br />
            <div class="kmBox20">
                <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">  
    <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <script src="../../Scripts/lib/jquery/jquery-ui.js"></script>
    <script>
        $('#exportall').css("display", "block");
       
        $(document).ready(function () {
            var autocompleteListData;
            var productNameList=[];
            var pharmaClassNameList = [];
            var indicationNameList = [];
            var moleculeNameList = [];
            var IsBothChecked = false;
            var jsonData;
            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Drugs/GetAutocompleteListData", null,
                 function (data) {

                     productNameList = data.ProductList;
                     pharmaClassNameList = data.PharmaClassList;
                     indicationNameList = data.IndicationList;
                     moleculeNameList = data.MoleculeList;
                     autocompleteListData = productNameList;
                 },
                  function (data) {
                      //alert(data);
                  });


            $("#searchInput").autocomplete({
                source: function (request, response) {
                   
                    var matches = $.map(autocompleteListData, function (acItem) {
                        if ((acItem.label).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#searchInput").val(ui.item.label);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#searchInput").val(ui.item.label);
                }
            }); 
            if ('<%=Session["returnBack"]%>' != null && '<%=Session["returnBack"]%>' == 'True') {
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
                var searchKey = '<%=Session["searchKey"]%>';
                var searchParam = '<%=Session["searchParam"]%>';
                var searchCondition = '<%=Session["searchCondition"]%>';
                var switchView = '<%=Session["switchView"]%>';
                var searchModule = '<%=Session["searchModule"]%>';
                $("#searchInput").val(searchKey);
                var dd = document.getElementById('search-filter-dropdown');
                for (var i = 0; i < dd.options.length; i++) {
                    if (dd.options[i].value === searchParam) {
                        dd.selectedIndex = i;
                        break;
                    }
                }

                if (searchModule == 0) {
                    $("#chkInline").prop('checked', true);
                    $("#chkPipeline").prop('checked', true);
                }
                else if (searchModule == 1) {
                    $("#chkInline").prop('checked', true);
                    $("#chkPipeline").prop('checked', false);
                }
                else if (searchModule == 2) {
                    $("#chkInline").prop('checked', false);
                    $("#chkPipeline").prop('checked', true);
                }

                PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Drugs/GetDrugs", { searchKey: searchKey, searchParam: searchParam, searchCondition: searchCondition, switchView: switchView, searchModule: searchModule },
                    function (data) {
                        $('#SearchResult').hide();
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                        var element = document.getElementById('SearchResult');
                        if (element = null) {
                            element.innerHTML = data;
                            PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView(element);
                        }
                        if (($("#tbltfoot") && $("#tbltfoot").length > 0)) {
                            PHARMAACE.FORECASTAPP.UTILITY.filteration(populateSummary);
                        }
                       
                       
                        $('#SearchResult').show();
                    },
                    function (status) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                       
                        $('#SearchResult').show();
                    });
            }

            $('input[type="checkbox"]').on('change', function () {
                var searchText = $("#searchInput").val();
                var selectedButtonstatus = $("#SearchResult   #example").length;
                    var chkinline = document.getElementById("chkInline").checked
                    var chkpipeline = document.getElementById("chkPipeline").checked;
                    if (searchText != "" || selectedButtonstatus != 0) {
                        
                        getDrugs($("#searchInput").val(), 1);
                    
                    return false;
                    }
                    else if ((chkinline) || (chkpipeline)) {
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
                    }
                    else {
                            pharmaace.forecastapp.utility.popalert("please select drug type..");
                        }      
            });
            $('#searchbar').submit(function () {
                if (PreId != "")
                {
                    document.getElementById(PreId).style.backgroundColor = '#fff';
                }      
                var searchText = $("#searchInput").val();
                if (searchText != "") {
                    
                    getDrugs($("#searchInput").val(), 1);    
                    return false;
                } else
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
            });
            var count = 0;
            var PreId = "";
            $('#SearchABCD').on('click', '> *', function () {
                if (this.id != PreId){
                    onclick = document.getElementById(this.id).style.backgroundColor = '#d4d4d4';
                }
                if (count != 0 && this.id != PreId)
                {
                    onclick = document.getElementById(PreId).style.backgroundColor = '#fff';
               }
                count++;
                PreId = this.id;
                document.getElementById("searchInput").value= "";
                getDrugs(this.id, 2);    
            });
           
       
        function getDrugs(searchKey, condition) {
            $('#SearchResult').hide();
            PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
            var e = document.getElementById("search-filter-dropdown");
            var searchParam = e.options[e.selectedIndex].value;
            var searchModule = null;
            var chkinline = document.getElementById("chkInline").checked
            var chkpipeline = document.getElementById("chkPipeline").checked;
            if ((chkinline) && (chkpipeline))
            {
                searchModule = 0;
                IsBothChecked = true;
            }

            if ((!chkinline) && (chkpipeline))
            {
                searchModule = 2;
                IsBothChecked = false;
            }                
            else if ((chkinline) && (!chkpipeline))
            {
                IsBothChecked = false;
                searchModule = 1;
            }                
            if (searchModule != null) {
                PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Drugs/GetDrugs", { searchKey: searchKey, searchParam: searchParam, searchCondition: condition, switchView: false, searchModule: searchModule },
                    function (data) {
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                        var element = document.getElementById('SearchResult');
                        element.innerHTML = data;
                        PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView(element);
                        if (($("#tbltfoot") && $("#tbltfoot").length > 0)) {
                            PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.dataTables.min.js", function () {
                                PHARMAACE.FORECASTAPP.UTILITY.filteration(populateSummary);
                            });
                        }
                      
                        
                        $('#SearchResult').show();
                        
                    },
                    function (status) {
                        PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                        $('#SearchResult').show();
                        PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                       
                        
                    });
                
            }
            else
                
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select drug type..");
                
        }
        function popup() {
            $('[data-rel=popover]').popover({
                placement: 'top'
            });
        }

        $("#search-filter-dropdown").change(function () {
            var Selectedfilter = this.value;
            
            if (Selectedfilter == 1)
                autocompleteListData = productNameList;
            else if (Selectedfilter == 2)
                autocompleteListData = moleculeNameList;
            else if (Selectedfilter == 3)
                autocompleteListData = pharmaClassNameList;
            else if (Selectedfilter == 4)
                autocompleteListData = indicationNameList;
        });
        });
       
       
    </script>

     
   
</asp:Content>
