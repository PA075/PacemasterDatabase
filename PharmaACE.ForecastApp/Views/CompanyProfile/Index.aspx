<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   Company Profile
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.8.1/css/bootstrap-slider.min.css">
           <%: Styles.Render("~/Content/KMDrugCSS") %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/9.8.1/bootstrap-slider.min.js"></script>
    <style>
.kmBox39{top:-34px !important; right:-103px !important;}
#searchbar .slider.slider-horizontal{width:136px !important;}        
.kmBox40{width:100%; margin-bottom:0px;}

    </style>
    <script>

        $(document).ready(function () {
            $("#mktcaprng").slider({});
     
            // Without JQuery
            //var slider = new Slider('#ex2', {});
        })
    </script>

   
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
           <%-- <div id="Search"><% Html.RenderPartial("_Search"); %>
                <%--<% Html.RenderAction("RenderSearch","Drugs"); %>
            </div>--%>
             
            <div class="btn-group btn-group-sm" id="SearchABCD">
    <input type="button" class="btn btn-default" id="A" value="A" />
    <input type="button" class="btn btn-default" id="B" value="B" />
    <input type="button" class="btn btn-default" id="C" value="C" />
    <input type="button" class="btn btn-default" id="D" value="D" />
    <input type="button" class="btn btn-default" id="E" value="E" />
    <input type="button" class="btn btn-default" id="F" value="F" />
    <input type="button" class="btn btn-default" id="G" value="G" />
    <input type="button" class="btn btn-default" id="H" value="H" />
    <input type="button" class="btn btn-default" id="I" value="I" />
    <input type="button" class="btn btn-default" id="J" value="J" />
    <input type="button" class="btn btn-default" id="K" value="K" />
    <input type="button" class="btn btn-default" id="L" value="L" />
    <input type="button" class="btn btn-default" id="M" value="M" />
    <input type="button" class="btn btn-default" id="N" value="N" />
    <input type="button" class="btn btn-default" id="O" value="O" />
    <input type="button" class="btn btn-default" id="P" value="P" />
    <input type="button" class="btn btn-default" id="Q" value="Q" />
    <input type="button" class="btn btn-default" id="R" value="R" />
    <input type="button" class="btn btn-default" id="S" value="S" />
    <input type="button" class="btn btn-default" id="T" value="T" />
    <input type="button" class="btn btn-default" id="U" value="U" />
    <input type="button" class="btn btn-default" id="V" value="V" />
    <input type="button" class="btn btn-default" id="W" value="W" />
    <input type="button" class="btn btn-default" id="X" value="X" />
    <input type="button" class="btn btn-default" id="Y" value="Y" />
    <input type="button" class="btn btn-default" id="Z" value="Z" />
</div>
            <div class="col-md-12 col-sm-12 col-xs-12" id="kmmainsearch">
    <div class="form-horizontal">
        <form class="navbar-form kmBox1" role="search" id="searchbar" >
            <div class="input-group" style="width:60%;">
                <div id="search-box" class="col-md-8 col-sm-8 col-xs-12">
                    <div class="col-md-5 col-sm-5 col-xs-5">
                    <div class="ddl-select input-group-btn ">
                        <select class="selectpicker form-control search-filter select-dropdown selectBox kmBox2" id="search-filter-dropdown">
                            <option selected="selected" value="1">Company Name</option>
                                <option value="2">Stock Code</option>
                                <option value="3">Therapeutic Area</option>
                                <option value="4">Market Cap</option>
                        </select>
                    </div>
                    </div>
                    <div class="col-md-6 col-sm-5 col-xs-6 ">
                        <div class="ui-widget">
                       
                           
                    <input id="searchInput"  type="text" class="form-control  kmBox2" placeholder="Enter here" aria-describedby="ddlsearch">
                    </div>
                    </div>
                    <div class="col-md-1 col-sm-1  col-xs-1 ">
                        <div class="input-group-btn">
                        <input id="btnSearch" class="btn btn-default" type="submit" value="" style="background-image: url('../../Content/img/search.jpg'); background-color: #e6e6e6; background-repeat: no-repeat; border-radius: 0px; box-shadow: inset 0px 1px 1px rgba(0,0,0,0.075); white-space: pre-wrap;" />
                        </div>
                    </div>
                </div>
                <div class="input-group-btn col-md-4 col-sm-4 col-xs-12" id="search-type">
                    <label class="checkbox-inline kmBox4" >
                    <input type="checkbox" id="chkinPipeBoth" value="Pipeline" checked="checked">Both</label>
                    <label class="checkbox-inline kmBox3">
                    <input type="checkbox" id="chkInline" value="Inline" checked="checked">Generic&nbsp;</label>
                    <label class="checkbox-inline kmBox4" >
                    <input type="checkbox" id="chkPipeline" value="Pipeline" checked="checked">Branded</label>
                    
                </div>
            </div>
            <div style="float:right; width:432px;">
                <label class="kmBox40">Market capital range(M):</label>
              <b>$1&nbsp;</b> <input id="mktcaprng" type="text" class="span2"value="" data-slider-min="10" data-slider-max="1000" data-slider-step="5" data-slider-value="[250,450]"/> <b>$10000</b>
            </div>
        </form>
    </div>
</div>
        

            <div id="SearchResult" class="kmBox19" >


                <div id="tblsummury" class="margin-top kmBox39">
      <div class="kmBox26">
        <h5 class="kmBox27">Search Result for: <span class="rcount">MNK</span></h5>
    </div>
    <div class="kmBox28">
        <h5 class="kmBox30">No of companies found: <span id="total_count" class="rcount">145</span></h5>
    </div>
    <br>
    <br>
    
    <div class="kmBox32">
        <h5>Generic: <span id="generic_count" class="rcount">90</span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5>
    </div>
    <div class="kmBox32">
        <h5>Brand: <span id="brand_count" class="rcount">22</span></h5>
    </div>
    <br>
   
</div>
            <div class="kmBox20 companyprofile" id="drugsid">
                <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
                

<table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
        <thead id="tblthead">
            <tr>
                <th>SNo.</th>
                <th>Stock Code</th>
                <th>Company Name</th>
                <th>Mkt Capital</th>
                <th>Subsidiaries</th>
                <th>Annual Sales</th>
                <th>Geographical Details</th>
                <th>Therapeutic Area</th>
                <th>Sector</th>
            </tr>
        </thead>
        <tfoot id="tbltfoot">
            <tr>
                 <th>SNo.</th>
                <th>Stock Code</th>
                <th>Company Name</th>
                <th>Mkt Capital</th>
                <th>Subsidiaries</th>
                <th>Annual Sales</th>
                <th>Geographical Details</th>
                <th>Therapeutic Area</th>
                <th>Sector</th>
            </tr>
        </tfoot>
        <tbody>
            <tr>
                <td>Tiger Nixon</td>
                <td>System Architect</td>
                <td>Edinburgh</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>Garrett Winters</td>
                <td>Accountant</td>
                <td>Tokyo</td>
                <td>63</td>
                <td>2011/07/25</td>
                <td>$170,750</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>Ashton Cox</td>
                <td>Junior Technical Author</td>
                <td>San Francisco</td>
                <td>66</td>
                <td>2009/01/12</td>
                <td>$86,000</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>Cedric Kelly</td>
                <td>Senior Javascript Developer</td>
                <td>Edinburgh</td>
                <td>22</td>
                <td>2012/03/29</td>
                <td>$433,060</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>Airi Satou</td>
                <td>Accountant</td>
                <td>Tokyo</td>
                <td>33</td>
                <td>2008/11/28</td>
                <td>$162,700</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
         
            <tr>
                <td>Herrod Chandler</td>
                <td>Sales Assistant</td>
                <td>San Francisco</td>
                <td>59</td>
                <td>2012/08/06</td>
                <td>$137,500</td>
                <td>61</td>
                <td>2011/04/25</td>
                <td>$320,800</td>
            </tr>
           
            
        </tbody>
    </table>
            </div>
            <br />
            <br />
            

            </div>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
   <%: Scripts.Render("~/Scripts/DrugsIndexScript") %>
    <script>
        $(document).ready(function () {
            
           // document.getElementById('searchInput').innerHTML = '<%= ViewData["searchKey"] %>'
            var element = document.getElementById('example');
            //element.innerHTML = data;
            //PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView(element);
           // if (($("#tbltfoot") && $("#tbltfoot").length > 0)) {
                PHARMAACE.FORECASTAPP.UTILITY.filteration('filteration');
           // }
            
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



        //$('input[type="checkbox"]').on('change', function () {
        //    var searchText = $("#searchInput").val();
        //    if (searchText != "") {
        //        getDrugs($("#searchInput").val(), 1);     
        //        return false;
        //    }
        //    else
        //        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
        //});
        //$('#searchbar').submit(function () {
        //   // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
        //    var searchText = $("#searchInput").val();
        //    if (searchText != "") {
        //        getDrugs($("#searchInput").val(), 1);    
        //        return false;
        //    } else
        //        //PHARMAACE.FORECASTAPP.UTILITY.hideOverlay("kmoverlayid");
        //        PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search word..");
        //});
        //$('#SearchABCD').on('click', '> *', function () {
        //   // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", 'kmoverlayid', "15", "");
        //    getDrugs(this.id, 2);    
        //});
        
        function popup() {
            $('[data-rel=popover]').popover({
                placement: 'top'
            });
        }




        });
       
    </script>
  <%--  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/i18n/defaults-*.min.js"></script>--%>
    <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
   
</asp:Content>


   



