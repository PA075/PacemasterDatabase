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


     <script src="../../Scripts/lib/jquery/jquery-ui.js"></script>
    <script src="../../Scripts/lib/jquery/typeahead.bundle.min.js"></script>
    <script src="../../Scripts/lib/jquery/typeahead.tagging.js"></script>
    <link href="../../Content/CSS/typeahead.tagging.css" rel="stylesheet" />
    <script src="../../Scripts/custom/summernote.js"></script>
<link href="../../Content/CSS/summernote.css" rel="stylesheet" />
           <%: Styles.Render("~/Content/KMDrugCSS") %>
<style>
    ul.tagging_ul li.tagging_tag:hover{cursor:pointer;}
    .ui-autocomplete{background-color:#ddd !important; z-index:9999;}
.ui-autocomplete li:hover{color: #ffffff!important;background-color:#0097cf!important;}
.ui-autocomplete li:focus, .ui-autocomplete li:active{color: #ffffff!important;background-color:#0097cf!important;}
.nav-tabs>li>a{
    padding:6px 23px;
}
#patenttab .nav-tabs>li.active>a:after{
    display:none;
}
#patenttab .nav-tabs li:last-child{
    border-bottom: 1px solid #e6e6e6;
}
#patenttab .nav-tabs
{border-right:0px;}
#patenttab{
    margin-top: 4px;
}

#exclusiveinfoable{
    width:100%;
}

 #sectionB table, th, td {
    border: 1px solid #e6e6e6;
    text-align: center;
     padding: 5px;
     border-radius:4px;
         margin-left: -17px;
    width: 952px;
    
}
 #sectionD table, th, td {
    border: 1px solid #e6e6e6;
    text-align: center;
     padding: 5px;
         margin-left: -17px;
    width: 952px;
    
}

 .divd2{width:960px;}
  #sectionE table, th, td {
    border: 1px solid #e6e6e6;
    text-align: center;
     padding: 5px;
         margin-left: -17px;
    width: 952px;
    
}
  #addPatent .modal-header{
      border-bottom:0px;
  }
 #addPatent .tab-content{
      padding: 0px 20px 20px 20px;
  }
 .divd1{margin-top:8px;}
.textareasize{resize:none;}

.adddiv{float: right; margin-top:1px;};
 .ui-autocomplete > li.ui-state-focus {
  background-color: #0097cf!important;
  color: #ffffff!important;
}
  /*#regulatorytable_length{display:none;}   
  #regulatorytable_filter{display:none;}*/  
  #regulatorytable_info{display:none;} 
  #regulatorytable_paginate{display:none;}
  #regulatorytable_wrapper table.dataTable.no-footer{border-bottom:0px;border-radius: 4px;} 
  #regulatorytable_wrapper .row .col-sm-3{float:right;}
  #regulatorytable .table>caption+thead>tr:first-child>td, .table>caption+thead>tr:first-child>th, .table>colgroup+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>th, .table>thead:first-child>tr:first-child>td, .table>thead:first-child>tr:first-child>th{width:4%;}
  td.details-control {
    background: url('../Content/img/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.details td.details-control {
    background: url('../Content/img/details_close.png') no-repeat center center;
}                         
</style>
   
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
                <%if(Session["RoleId"] != null)%>
                           <%if(int.Parse(Session["RoleId"].ToString())== 3 || int.Parse(Session["RoleId"].ToString()) == 2){ %>
               <button type="button" class="btn btn-default" data-toggle="modal" role="button" id="addDurgs1"  data-target='#addDurgs'>Add Inline Drugs</></button>
                  <% } %>
                               <button type="button" class="btn btn-default" data-toggle="modal" role="button" id="patent"  data-target='#addPatent'>Add Drugs Patent</></button>
            </div>
            <div id="SearchResult" class="kmBox19"></div>
            <br />
            <br />
            <div class="kmBox20">
                <img src="../../Content/img/ajax-loader.gif" id="loading-indicator" style="display: none" />
            </div>
        </div>
    </div>
    <div class="modal" id="addDurgs" tabindex="-1" style="display:none;">
        <div class="modal-dialog divd2">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title custom_align" id="Heading">Add Inline Durgs Information</h4>
                </div>
                <div style="overflow-y:scroll;height:513px; cursor:pointer;">
                <form class="form" role="form" id="addDrugsform" name="form1">
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-2">App Short No.</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="applicationshortno" type="text" required />
                                </div>
                                <label class="control-label col-md-2">Product UID</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="productid" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Product NDC</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="productndc" type="text" required />
                                </div>
                         <%--   </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Product Code</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="productcode" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Product Name</label>
                                <div class="col-md-4">
                                    <div class="ui-widget">
                                    <input class="form-control" id="productname" type="text"  required />
                                        </div>
                                </div>
                          <%--  </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Company Name</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="companyname" type="text" required/>
                                </div>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Marketing Partner</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="marketingpartner" type="text" required/>
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Product Category</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="productcategory" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Molecule</label>
                                <div class="col-md-4 ui-widget" id="moleculearray">
                                    <input class="form-control tags-input" type="text" id="molecule" style="display: none;" required />
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Substance</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="substance" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Form</label>
                                <div class="col-md-4 ui-widget">
                                    <input class="form-control" id="form" type="text" value="" required />
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Strength</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="strength" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Route of Administration</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="routeofadministration" type="text" required />
                                </div>
                          <%--  </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Disease Area</label>
                                <div class="col-md-4" id="diseaseareaarray">
                                    <input class="form-control tags-input" id="diseasearea" type="text" style="display: none;" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Indication</label>
                                <div class="col-md-10" id="indicationarray">
                                     <div class="ui-widget">
                                                        <input id="indication" required="required" class="form-control tags-input" value="" style="display: none;">
                                              
                                                 </div>
                                    <%--<input class="form-control tags-input" id="indication" type="text" required />--%>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Sub Indication</label>
                                <div class="col-md-10" id="subindicationdiv">
                                    <span id="subindication"></span>
<%--                                    <textarea class="form-control textareasize" id="subindication"  required ></textarea>--%>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Dosage Adult</label>
                                <div class="col-md-10" id="dosageadultdiv">
                                    <span id="dosageadult"></span>
<%--                                    <textarea class="form-control textareasize" id="dosageadult"  required ></textarea>--%>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Dosage Pediatric</label>
                               <div class="col-md-10" id="dosagepediatricdiv">
                                    <span id="dosagepediatric"></span>
<%--                                    <textarea class="form-control textareasize" id="dosagepediatric"  required ></textarea>--%>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Price</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="price" type="text" required />
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Pricing Unit</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="pricingunit" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Price Source</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="pricesource" type="text" required />
                                </div>
                           <%-- </div>
                        </div>
                    
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Pharma Class</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="pharmaclass" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Pharma Class 2</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="pharmaclass2" type="text" required />
                                </div>
                            <%--</div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Pharma Class 3</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="pharmaclass3" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">IMS Class</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="imsclass" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">MoA</label>
                                <div class="col-md-10">
                                    <textarea class="form-control textareasize" id="moa"  required></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Approval Date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="approval" type="date" required/>
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Start Marketing Date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="startmarketingdate" type="date" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Product Type</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="producttype" type="text" required/>
                                </div>
                          <%--  </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Drug Type</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="durgstype" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Marketing Status</label>
                                <div class="col-md-4">
<%--                                    <input class="form-control" id="marstatus" type="text" />--%>

                                    <select id="marstatus" style="width:100%;">
                                        <option>Please Select</option>
                                        <option value="0">Prescription</option>
                                        <option value="1">Discontinued</option>
                                    </select>
                                </div>
                          <%--  </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Latest Label Date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="latestlabeldate" type="date" />
                                </div>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">RLD</label>
                                <div class="col-md-4 divd1">
                                    <input  name="rld"  value="1" type="radio" checked>Yes
                                     <input name="rld" value="0" type="radio">No
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">TE Code</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="tecode" type="text" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer ">
                        <button type="button" class="btn btn-default" data-dismiss="modal"   id="cancelpopoup">Cancel</button>
                         <input type="submit" class="btn btn-primary" id="validationdurgs"  style="display:none" />
                        <input type="button" class="btn btn-primary" id="editinlined" onclick="addInlineDurgs();" value="Save" />
                    </div>
                </form>
                    </div>
            </div>
        <!-- /.modal-content -->
    </div>
                  <!-- /.modal-dialog -->
               </div>
    <div class="modal" id="addPatent" tabindex="-1" style="display: none;">
        <div class="modal-dialog divd2">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h2 class="modal-title custom_align" id="Heading1">Add Patent Information </h2>
                    <div id="patenttab">
                         <ul class="nav nav-tabs" id="tablist">
                        <li class="active">
                            <a   href="#sectionA" data-toggle="tab" ><b>Generic Availability</b></a>
                        </li>
                        <li class="">
                            <a data-toggle="tab" class="" id="secb"  href="#sectionB" ><b>API Info</b></a>
                        </li>
                              <li class="">
                            <a data-toggle="tab" class="" id="secc"  href="#sectionC" ><b>Sale Info</b></a>
                        </li>
                              <li class="">
<%--                              <a data-toggle="tab" class="" id="secd" href="#sectionD" onclick="showExclusivityInfoTab();" ><b>Exclusivity Info</b></a>--%>
                                  <a data-toggle="tab" class="" id="secd" href="#sectionD" ><b>Exclusivity Info</b></a>

                        </li>
                              <li class="">
                            <a data-toggle="tab" class="" id="sece"  href="#sectionE" ><b>Patent Info</b></a>
                        </li>
                             <li class="">
                            <a data-toggle="tab" class="" id="secf"  href="#sectionF" ><b>Regulatory Strategy</b></a>
                        </li>
                    </ul>
                    </div>

                </div>
                <div class="tab-content">
               <div style="cursor:pointer;" id="sectionA" class="tab-pane fade in active">
                <form class="form" role="form"  name="form1">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-3">Generic Availability</label>
                                <div class="col-md-3 divd1">
                                     <input  name="genericavailability"  value="1" type="radio" checked>Yes
                                     <input name="genericavailability" value="0" type="radio">No
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">FTF Filing date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="ftffillingdate" type="date" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">FTF Approval Date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="ftfapprovedate" type="date" required />
                                </div>
                           <%-- </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">FTF Launch Date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="ftflaunchdate" type="date" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-3">FTF Holder</label>
                                <div class="col-md-8">
                                    <div class="ui-widget" id="ftfholderDiv">
                                                        <input id="ftfholder" required="required" class="form-control tags-input" value="" style="display: none;">
                                                 </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-3">Generic Players</label>
                                <div class="col-md-8" id="genericplayerDiv">
                                    <input class="form-control tags-input" id="genericplayer" style="display: none;"  required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-3">Authorized Generic</label>
                                <div class="col-md-8" id="authorizedGeneric">
                                    <input class="form-control" id="authorizedgeneric" type="text" required/>
                                </div>
                            </div>
                        </div> 
                    <div class="modal-footer ">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <%--<input type="submit" class="btn btn-primary" id="validationdurgs"  style="display:none" />--%>
                        <input type="button" class="btn btn-primary" onclick="Savepatent();"  value="Save" />
                    </div>
                    
                </form>
                    </div>
               <div style="cursor:pointer;" id="sectionB" class="tab-pane fade">
               <div class="form-group" >
                    <table id="apitable" class="table table-striped">
                        <tr>
                            
                            <th>Submission Date</th>
                            <th>DMF Holder Name</th>
                            <th>DMF Status</th>
                            <th>ANDA Holder Against DMF</th>
                            <th>Org Commercializes Product in US</th>
                            <th></th>
                        </tr>

                    </table>
                   </div>
                    <form class="form" role="form"  name="form1">
                         
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-3">Submission Date </label>
                                <div class="col-md-3">
                                    <input class="form-control" id="submissiondate" type="date" required />
                                </div>
                         <%--   </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-3">DMF Holder Name</label>
                                <div class="col-md-3">                                                
                                    <input class="form-control" id="dmfholdername" type="text" required  />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-3">DMF Status</label>
                                <div class="col-md-3 divd1">
                                    <input  name="dmfstatus" class="control-label " value="1" type="radio" checked/>Active
                                     <input name="dmfstatus"  class="control-label" value="0" type="radio"/>Inactive
                                   
                                </div>
                                
                            <%--</div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-4">ANDA Holder Against DMF</label>
                                <div class="col-md-2 divd1">
                                    <input  name="andaholder"  value="1" type="radio" checked>Yes
                                     <input name="andaholder" value="0" type="radio">No
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Org Commercializes Product in US</label>
                                <div class="col-md-2 divd1">
                                    <div class="ui-widget">
                                        <input  name="orgcomm"  value="1" type="radio" checked>Yes
                                     <input name="orgcomm" value="0" type="radio">No
                                        </div>
                                </div>
                                <div class="col-md-6">
                                 <input type="button" class="btn btn-primary adddiv"  onclick="addApiData();" value="Add" />
                                    </div>
                            </div>
                        </div>
                    <div class="modal-footer ">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" id="validationdurgs1"  style="display:none" />
                        <input type="button" class="btn btn-primary"  value="Save" />
                    </div>
                </form>
                    </div>
                <div style="cursor:pointer;" id="sectionC" class="tab-pane fade">
                <form class="form" role="form"  name="form1">   
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-2">Current Year </label>
                                <div class="col-md-4">
                                    <input class="form-control" id="currentyear" type="number" required />
                                </div>
                          <%--  </div>
                        </div>
                        <div class="form-group">
                            <div class="row">--%>
                                <label class="control-label col-md-2">Previous Year</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="previousyear" type="number" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">% Change</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="change" type="number" required />
                                </div>
                            </div>
                        </div>
                    <div class="modal-footer ">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                         <%-- <input type="submit" class="btn btn-primary" id="validationdurgs1"  style="display:none" />--%>
                        <input type="button" class="btn btn-primary" value="Save" />
                    </div>
                </form>
                    </div>
               <div style="cursor:pointer;" id="sectionD" class="tab-pane fade">
                    <div class="form-group" >
                    <table id="exclusiveinfoable"  class="table table-striped" >
                        <tr>
                            <th>Exclusivity</th>
                            <th>Expiry</th>
                            <th>Description</th>
                            <th></th>
                        </tr>
                    </table>
                        </div>
                <form class="form" role="form"  name="form1">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-md-2">Exclusivity</label>
                             <div class="col-md-4">
                                 <select id="exclusivitydrop" style="width:100%;" onchange="showExclusivityDescription();">
                                        <option>Please Select</option>
                                       
                                    </select>

                            </div>
                                <label class="control-label col-md-2">Expiry Date</label>
                                <div class="col-md-4">
                                    <input class="form-control" id="expirydate1" type="date" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-2">Description</label>
                                <div class="col-md-8">
                                    <textarea class="form-control textareasize" readonly id="description"  required ></textarea>
                                </div>
                                <div class="col-md-2">
                                 <input type="button" class="btn btn-primary adddiv"  onclick="addExlusivityInfo();" value="Add" />
                                    </div>
                            </div>
                        </div>
                      <%--  <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-3">Expiry Date</label>
                                <div class="col-md-7">
                                    <input class="form-control" id="expirydate1" type="date" required />
                                </div>
                                
                            </div>
                        </div>--%>
                    <div class="modal-footer ">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                         <%-- <input type="submit" class="btn btn-primary" id="validationdurgs1"  style="display:none" />--%>
                        <input type="button" class="btn btn-primary"  value="Save" />
                    </div>
                </form>
                    </div>
                    <div style="cursor: pointer;" id="sectionE" class="tab-pane fade">
                        <div class="form-group">
                            <table id="patentinfotable" class="table table-striped">
                                <tr>
                                    <th>Patent No.</th>
                                    <th>Type of Patent</th>
                                    <th>Patent Use Code</th>
                                    <th>Expiry Date</th>
                                    <th>PTE Granted</th>
                                    <th>Independent Claims</th>
                                    <th>Delist Requested</th>
                                    <th>Patent Licensing Info.</th>
                                    <th></th>
                                </tr>
                            </table>
                        </div>
                        <form class="form" role="form" name="form1">

                            <div class="form-group">
                                <div class="row">
                                    <label class="col-md-2">Patent No.</label>
                                    <div class="col-md-4">
                                        <input class="form-control" id="patentno" type="text" required />
                                    </div>
                                    <%-- </div>
                        </div>
                  
                        <div class="form-group">
                            <div class="row">--%>
                                    <label class="control-label col-md-2">Type of Patent</label>
                                    <div class="col-md-4">
                                        <select id="typeofpatent" style="width: 100%;" required>
                                            <option disabled>Please Select</option>
                                            <option value="0">MOU</option>
                                            <option value="1">Formulation</option>
                                            <option value="2">Polymorph</option>
                                            <option value="3">Combination</option>
                                            <option value="4">Composition and MOU</option>
                                            <option value="5">Prodrug</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-3">Patent Use Code</label>
                                    <div class="col-md-8">
                                        <textarea class="form-control textareasize" id="patentusecode"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-2">Expiry Date</label>
                                    <div class="col-md-4">
                                        <input class="form-control" id="expirydate" type="date" required />
                                    </div>
                              <%--  </div>
                            </div>
                            <div class="form-group">
                                <div class="row">--%>
                                    <label class="control-label col-md-3">PTE Granted</label>
                                    <div class="col-md-3 divd1">
                                        <input name="ptegranted" value="1" type="radio" checked>Yes
                                     <input name="ptegranted" value="0" type="radio">No
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-3">Independent Claims</label>
                                    <div class="col-md-8">
                                        <textarea class="form-control textareasize" id="independentclaims"></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-3">Delist Requested</label>
                                    <div class="col-md-2 divd1">
                                        <input name="delistrequested" value="1" type="radio" checked>Yes
                                     <input name="delistrequested" value="0" type="radio">No
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-3">Patent Licensing Info</label>
                                    <div class="col-md-8">
                                        <textarea class="form-control textareasize" id="patentlicensinginfo"></textarea>
                                    </div>
                                    <div class="col-md-1">
                                        <input type="button" class="btn btn-primary" onclick="addPatentInfo();" value="Add" />
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer ">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                <%-- <input type="submit" class="btn btn-primary" id="validationdurgs1"  style="display:none" />--%>
                                <input type="button" class="btn btn-primary" value="Save" />
                            </div>
                        </form>
                    </div>




                    <div style="cursor: pointer;" id="sectionF" class="tab-pane fade">
                        <div class="row">
                            <label class="col-md-2">Company Name</label>
                            <div class="col-md-3">
                                <select id="companynames" style="width: 100%;" required>
                                    <option disabled>Please Select</option>
                                    <option value="0">MOU</option>
                                    <option value="1">Formulation</option>
                                    <option value="2">Polymorph</option>
                                    <option value="3">Combination</option>
                                    <option value="4">Composition and MOU</option>
                                    <option value="5">Prodrug</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">

                            <table id="regulatorytable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Patent No.</th>
                                        <th>Type of Patent</th>
                                        <th>Patent Use Code</th>
                                        <th>Expiry</th>
                                    </tr>
                                </thead>


                                <tr>
                                    <td class="details-control"></td>
                                    <td>US7053092</td>
                                    <td>MOU</td>
                                    <td>Treatment of Major Depressive Disorder</td>
                                    <td>1/28/2022</td>
                                </tr>
                                <tr>
                                    <td class="details-control"></td>
                                    <td>US8017615</td>
                                    <td>Formulation</td>
                                    <td>No Information</td>
                                    <td>6/16/2024</td>
                                </tr>
                                <tr>
                                    <td class="details-control"></td>
                                    <td>US8580796</td>
                                    <td>Polymorph</td>
                                    <td>No Information</td>
                                    <td>9/25/2022</td>
                                </tr>
                            </table>
                        </div>
                        <form class="form" role="form" name="form1">

                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-2">505(j)/505(B2)</label>
                                    <div class="col-md-4">
                                        <input class="form-control" id="brand" type="text" required />
                                    </div>

                                    <label class="control-label col-md-2">PIV/PIII</label>
                                    <div class="col-md-4">
                                        <input class="form-control" id="patentnum" type="text" required />

                                    </div>

                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <label class="control-label col-md-2">PIV Strategy</label>
                                    <div class="col-md-4">
                                        <input class="form-control" id="patentnum1" type="text" required />
                                    </div>
                                    <div class="col-md-6">
                                        <input type="button" class="btn btn-primary adddiv" onclick="addApiData();" value="Add" />
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer ">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                <input type="submit" class="btn btn-primary" id="validationdurgs11" style="display: none" />
                                <input type="button" class="btn btn-primary" value="Save" />
                            </div>
                        </form>
                    </div>




                </div>

            </div>
        <!-- /.modal-content -->
    </div>
                  <!-- /.modal-dialog -->
               </div>


   
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">  
    <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <script src="../../Scripts/lib/jquery/jquery-ui.js"></script>
    <script>
       
            
       
        $('#exportall').css("display", "block");
        var autocompleteListData;
        var productNameList = [];
        var pharmaClassNameList = [];
        var indicationNameList = [];
        var indicationNameList1 = [];
        var moleculeNameList = [];
        var moleculeNameList1 = [];
        var companyNameList = [];
        var companyNameList1 = [];
        var productCategoryList = [];
        var substanceList = [];
        var formList =[];
        var roaList = [];
        var diseaseAreaList = [];
        var moaList = [];
        var productTypeList = [];
        var priceUnitList = [];
        var priceSourceList = [];
        var drugsTypeList = [];
        var strengthList = [];
        var IsBothChecked = false;
        var jsonData;
        var exclusivityData = [];
        var patentInfoData = [];

        function getFormattedDate(fdate)
        {
            var r = new Date(parseInt(fdate.substr(6)));
            var d = ("0" + r.getDate()).slice(-2);
            var m = ("0" + (r.getMonth() + 1)).slice(-2);
            var dt = r.getFullYear() + "-" + (m) + "-" + (d);
            return dt;


        }
        function setSalesInfo(salesInfo) {




        }

        function setGenericAvailability(genericData)
        {
          
            var fillingDate = getFormattedDate(genericData.FTFfilingDate);
            var ftfApprovalDate = getFormattedDate(genericData.FTFApprovalDate);
            var ftfLaunchDate = getFormattedDate(genericData.FTFLaunchDate);

            $("#ftffillingdate").val(fillingDate);
            $("#ftfapprovedate").val(ftfApprovalDate);
            $("#ftflaunchdate").val(ftfLaunchDate);

            for (var i = 0; i < genericData.AuthorisedGenerics.length; i++) {
                $('#authorizedGeneric').find('ul').append($("<li class='tagging_tag' title='" + genericData.AuthorisedGenerics[i] + "'>" + genericData.AuthorisedGenerics[i] + "<span class='tag_delete'>x</span></li>"));

            }
            for (var i = 0; i < genericData.FTFHolders.length; i++) {
                $('#ftfholderDiv').find('ul').append($("<li class='tagging_tag' title='" + genericData.FTFHolders[i] + "'>" + genericData.FTFHolders[i] + "<span class='tag_delete'>x</span></li>"));

            }

            for (var i = 0; i < genericData.GenericPlayers.length; i++) {
                $('#genericplayerDiv').find('ul').append($("<li class='tagging_tag' title='" + genericData.GenericPlayers[i] + "'>" + genericData.GenericPlayers[i] + "<span class='tag_delete'>x</span></li>"));

            }
        }

       

        function fillPatentPopup(currentDrug) {
            var inlineId = $(currentDrug).parent().parent().attr('inlineId');
            alert(inlineId);

            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Drugs/FetchPatentDetails", { inlineTransId: inlineId },
            function (result) {
                if (result.success) {
                    debugger;
                    if (result.result != null)
                    {
                        debugger;
                        setGenericAvailability(result.result.generic);
                    }
                    //if (result.userForShare.length == 0) {

                    //}
                    //else if (result.userForShare.length > 0) {

                    //    $("#btnShowShare").click();
                    //    populateSharePopupWithFetchedData(result.userForShare, fileForShare, fileLineage);

                    //}
                }

                else
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
            },
           function (result) {
               PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
           });





        }



        function getAuthorisedGenerics() {

            var ul = $("#authorizedgeneric").parent()[0].getElementsByTagName("ul");

            var li = ul[0].getElementsByTagName("li");

            var AuthorisedGenerics = [];

            for (var i = 0; i < li.length - 1 ; i++) {

                //if (AuthorisedGenerics=="") {
                //    AuthorisedGenerics =  li[i].firstChild.nodeValue;//nnerText;
                //}
                //else {
                    AuthorisedGenerics.push(li[i].firstChild.nodeValue);
                   // AuthorisedGenerics =  + ">" + li[i].firstChild.nodeValue;//nnerText;
               // }
            }
            return AuthorisedGenerics;

        }

        function getGenericsPlayers() {

            var ul = $("#genericplayer").parent()[0].getElementsByTagName("ul");

            var li = ul[0].getElementsByTagName("li");

            var GenericsPlayers = [];

            for (var i = 0; i < li.length - 1 ; i++) {

                //if (GenericsPlayers == "") {
                //    GenericsPlayers = li[i].firstChild.nodeValue;
                //}
                //else {
                     GenericsPlayers.push(li[i].firstChild.nodeValue);
              //  }
            }
            return GenericsPlayers;

        }

        function getFTFHolders() {

            var ul = $("#ftfholder").parent()[0].getElementsByTagName("ul");

            var li = ul[0].getElementsByTagName("li");

            var FTFHolders = [];

            for (var i = 0; i < li.length - 1 ; i++) {

                //if (FTFHolders == "") {
                //    FTFHolders = li[i].firstChild.nodeValue;
                //}
                //else {
                     FTFHolders.push(li[i].firstChild.nodeValue);
               // }
            }
            return FTFHolders;

        }

        function buildSaleInfoObject(currentYear, previousyear, percentChange) {
            var salesInfo;

            salesInfo = {
                CurrentYear: currentYear,
                PrevYear: previousyear,
                Change: percentChange,

            };
            return salesInfo;

        }

        function saveSalesInfo() {
            currentYear = (document.getElementById("currentyear").value).trim();
            PrevYear = (document.getElementById("previousyear").value).trim();
            percentChange = (document.getElementById("change").value).trim();

            return buildSaleInfoObject(currentYear, PrevYear, percentChange);

        }

        function getExclusivityInfo() {
            var table = $("#exclusiveinfoable table tbody");

            table.find('tr').each(function (key, val) {
                $(this).find('td').each(function (key, val) {
                    
                    var exclusivity =  $("#exclusivity").val();
                    var description = $("#description").val();
                    var expirydate1 = $("#expirydate1").val();

                    });
            });

             
            var Generic = {
                Id: 1,
                GenericAvailability: rad,
                InlineTrasnactionId: 1,
                FTFfilingDate: $("#ftffillingdate").val(),
                FTFApprovalDate: $("#ftfapprovedate").val(),
                FTFLaunchDate: $("#ftflaunchdate").val(),
                FTFHolders: $("#ftfholder").val(),
                GenericPlayers: $("#genericplayer").val(),
                AuthorisedGenerics: $("#authorizedgeneric").val(),
            }
    
        }

        function buildExclusivityDataObject(Exclusivity, Expiry, Description) {
            var ExclusivityData;

            ExclusivityData = {

                Exclusivity: Exclusivity,
                Expiry: Expiry,
                Description: Description,

            }
            return ExclusivityData;
        }

        function buildPatentInfoObject(patentNo, typeOfPatent, patentUseCode, expiryDate, PteGranted, independentClaims, delistRequested, patentLicensingInfo) {
            var patentInfoObject = "";
            patentInfoObject =
                {
                    PatentNo: patentNo,
                    TypeOfPatent: typeOfPatent,
                    PatentUseCode: patentUseCode,
                    ExpiryDate: expiryDate,
                    PTEGranted: PteGranted,
                    IndependentClaims: independentClaims,
                    DelistRequested: delistRequested,
                    PatentLicensingInfo: patentLicensingInfo

                }
            return patentInfoObject;


        }

        function savePatentInfoData() {

            
            $('#patentinfotable').find('tr').each(function () {
                if (this.rowIndex != 0) {
                    var patentNo = $(this).find('td:first')[0].innerText;
                    var typeOfPatent = $(this).find('td:eq(1)')[0].innerText;
                    var patentUseCode = $(this).find('td:eq(2)')[0].innerText;
                    var expiryDate = $(this).find('td:eq(3)')[0].innerText;
                  //  var PteGranted = $(this).find('td:eq(4)')[0].innerText;
                    var PteGranted = 1;
                    if ( $(this).find('td:eq(4)')[0].innerText == "Yes") {
                        PteGranted = 1;
                    }
                    else {
                        PteGranted = 0;
                    }
                   
                    var independentClaims = $(this).find('td:eq(5)')[0].innerText;
                    //var delistRequested = $(this).find('td:eq(6)')[0].innerText
                    if ($(this).find('td:eq(6)')[0].innerText == "No") {
                        delistRequested = 1;
                    }
                    else {
                        delistRequested = 0;
                    }


                    var patentLicensingInfo = $(this).find('td:eq(7)')[0].innerText

                    patentInfoData.push(buildPatentInfoObject(patentNo, typeOfPatent, patentUseCode, expiryDate, PteGranted, independentClaims, delistRequested, patentLicensingInfo));
                }
            });

        }


        var exclusivityDataArr = "";

        function showExclusivityInfoTab() {
            var length = $('#exclusivitydrop > option').length;
            if (length <= 1) {
                exclusivityDataArr = "";
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Drugs/GetExclusivityData", {},
                         function (result) {
                             if (result.success) {
                                 exclusivityDataArr = result.result;
                                 for (var i = 0; i < result.result.length; i++) {
                                     $('#exclusivitydrop').append('<option>' + result.result[i].Exclusivity + '</option>');

                                 }

                             }
                             else {

                             }

                         }
                         ,
                          function (result) {
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed! " + result.responseText, '');

                          });
            }
        }

        function showExclusivityDescription() {
            var flag = 0;
            var exclusivity = document.getElementById('exclusivitydrop').value;

            for (var i = 0; i < exclusivityDataArr.length; i++) {
                if ((exclusivityDataArr[i].Exclusivity).trim() == exclusivity.trim()) {
                    document.getElementById('description').value = exclusivityDataArr[i].Description;
                    flag = 1;
                    break;
                }


            }
            if (flag == 0) {
                document.getElementById('description').value = "";
            }
        }


        function createExclusivityInfo() {

            $('#exclusiveinfoable').find('tr').each(function () {

                if (this.rowIndex!=0) {
                    var Exclusivity = $(this).find('td:first')[0].innerText;
                    var Expiry = $(this).find('td:eq(1)')[0].innerText;
                    var Description = $(this).find('td:eq(2)')[0].innerText;

                    exclusivityData.push(buildExclusivityDataObject(Exclusivity, Expiry, Description));

                }
               
            });

        }

        function Savepatent() {

           // getAuthorisedGenerics();
            createExclusivityInfo();
            savePatentInfoData();

            var rad = $('input[name=genericavailability]').filter(':checked').val();
           

            var Generic = {
                Id: 1,
                GenericAvailability: rad,
                InlineTrasnactionId: 1,
                FTFfilingDate: $("#ftffillingdate").val(),
                FTFApprovalDate: $("#ftfapprovedate").val(),
                FTFLaunchDate: $("#ftflaunchdate").val(),
                FTFHolders: getFTFHolders(),
                GenericPlayers: getGenericsPlayers(),
                AuthorisedGenerics: getAuthorisedGenerics(),
            }
      
            var patent = {
                generic: Generic,
                saleInfo: saveSalesInfo(),
                exclusivity: exclusivityData,
                piData: patentInfoData
            }
          //  debugger;


            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Drugs/AddPatentDetails", JSON.stringify(patent),
                                                   function (result) {
                                                       if (result.success) {
                                                           PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('editableWorkSpace');
                                                          
                                                       }
                                                   },
                                                   function (result) {
                                                       PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed! " + result.responseText, '');
                                                   });

         
        }
       

        var dt = $('#regulatorytable').DataTable({
            "columns": [
                {
                    "className": 'details-control',
                    "orderable": false,
                    "data": null,
                    "defaultContent": ''
                },
                {  },
                { },
                { },
                { }
            ],
            "order": [[1, 'asc']]
        });

        $(document).ready(function () {
            
            PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Drugs/GetAutocompleteListData", null,
                 function (data) {

                     productNameList = data.ProductList;
                     pharmaClassNameList = data.PharmaClassList;
                     indicationNameList = data.IndicationList
                     moleculeNameList = data.MoleculeList;
                     autocompleteListData = productNameList;
                     diseaseAreaList = data.DiseaseAreaList;
                     companyNameList = data.CompanyList;
                     autoComplete("companyname", companyNameList);
                     autoComplete("marketingpartner", companyNameList);
                     productCategoryList = data.ProductCategoryList;
                     autoComplete("productcategory", productCategoryList);
                     substanceList = data.SubstanceList;
                     autoComplete("substance", substanceList);
                     formList = data.FormList;
                     autoComplete("form", formList);
                     roaList = data.ROA_MasterList;
                     autoComplete("routeofadministration", roaList);
                     moaList = data.MOA_MasterList;
                     autoComplete("moa", moaList);
                     productTypeList = data.ProductTypeList;
                     autoComplete("producttype", productTypeList);
                     priceUnitList = data.PriceUnitList;
                     autoComplete("pricingunit", priceUnitList);
                     priceSourceList = data.PriceSourceList;
                     autoComplete("pricesource", priceSourceList);
                     drugsTypeList = data.DrugsTypeList;
                     autoComplete("durgstype", drugsTypeList);
                     strengthList = data.StrengthList;
                     autoComplete("strength", strengthList);

                     // Turn the input into the tagging input
                     $('#indication').tagging(indicationNameList1);
                     $('#diseasearea').tagging(diseaseAreaList);
                     $('#authorizedgeneric').tagging(companyNameList);
                     $('#ftfholder').tagging(companyNameList);
                     $('#genericplayer').tagging(companyNameList);
                     $('#molecule').tagging(moleculeNameList1);


                     

                     for (var i = 0; i < data.IndicationList.length; i++) {
                         indicationNameList1.push(data.IndicationList[i].value);
                     };
                     
                      for (var i = 0; i < data.CompanyList.length; i++) {
                          companyNameList1.push(data.CompanyList[i].value);
                      };
                      for (var i = 0; i < data.MoleculeList.length; i++) {
                          moleculeNameList1.push(data.MoleculeList[i].value);
                      };
                      summerEditor("subindication");
                      summerEditor("dosageadult");
                      summerEditor("dosagepediatric");
                 },
                  function (data) {
                      //alert(data);
                  });



           
            $('#regulatorytable_length').parent().removeClass("col-sm-2");
            $('#regulatorytable_length').parent().addClass("col-sm-4");
            var detailRows = [];
            $('#regulatorytable tbody').on('click', 'tr td.details-control', function () {
                var tr = $(this).closest('tr');
                var row = dt.row(tr);
                var idx = $.inArray(tr.attr('id'), detailRows);

                if (row.child.isShown()) {
                    tr.removeClass('details');
                    row.child.hide();

                    // Remove from the 'open' array
                    detailRows.splice(idx, 1);
                }
                else {
                    tr.addClass('details');
                    row.child(format(row.data())).show();

                    // Add to the 'open' array
                    if (idx === -1) {
                        detailRows.push(tr.attr('id'));
                    }
                }
            });
           
        });

        function autoComplete(inputid, autoCompleteList) {
            $("#" + inputid).autocomplete({
                source: function (request, response) {

                    var matches = $.map(autoCompleteList, function (acItem) {
                        if ((acItem).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#" + inputid).val(ui.item.value);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#" + inputid).val(ui.item.value);
                }

            });
        }
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
            $("#productname").autocomplete({
                source: function (request, response) {
                   
                    var matches = $.map(productNameList, function (acItem) {
                        if ((acItem.label).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#productname").val(ui.item.label);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#productname").val(ui.item.label);
                }
               
            });

            $("#pharmaclass").autocomplete({
                source: function (request, response) {

                    var matches = $.map(pharmaClassNameList, function (acItem) {
                        if ((acItem.label).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#pharmaclass").val(ui.item.label);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#pharmaclass").val(ui.item.label);
                }

            });
            $("#pharmaclass2").autocomplete({
                source: function (request, response) {

                    var matches = $.map(pharmaClassNameList, function (acItem) {
                        if ((acItem.label).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#pharmaclass2").val(ui.item.label);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#pharmaclass2").val(ui.item.label);
                }

            });
            $("#pharmaclass3").autocomplete({
                source: function (request, response) {

                    var matches = $.map(pharmaClassNameList, function (acItem) {
                        if ((acItem.label).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#pharmaclass3").val(ui.item.label);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#pharmaclass3").val(ui.item.label);
                }

            });
            $("#imsclass").autocomplete({
                source: function (request, response) {

                    var matches = $.map(pharmaClassNameList, function (acItem) {
                        if ((acItem.label).trim().toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                            return acItem;
                        }
                    });
                    response(matches);
                },
                minLength: 1,
                select: function (event, ui) {
                    $("#imsclass").val(ui.item.label);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#imsclass").val(ui.item.label);
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
                        element.innerHTML = data;
                        PHARMAACE.FORECASTAPP.UTILITY.loadScriptsFromPartialView(element);
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

          /*  $('input[type="checkbox"]').on('change', function () {
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
            }); */

            $('input[type="checkbox"]').on('change', function () {
                var searchText = $("#searchInput").val();
                var selectedButtonstatus = $("#SearchResult   #example").length;
                var chkinline = document.getElementById("chkInline").checked
                var chkpipeline = document.getElementById("chkPipeline").checked;
                if (searchText != "" || selectedButtonstatus != 0 && ((chkinline) || (chkpipeline))) {

                    getDrugs($("#searchInput").val(), 1);

                    return false;
                }
                else if (!(chkinline) && !(chkpipeline)) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("please select drug type..");
                }
                else {
                    pharmaace.forecastapp.utility.popalert("Please enter search text..");
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
                } else {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter search text..");
                    return false;
                }
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

            function format(d) {
                return '<table class="table table-striped"  cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;"><tr >' +
                           '<th> 505(j)/505(B2)</th>' +
                           '<th >PIV/PIII</th>' +
                   '<th>PIV Strategy</th>' +
                       '</tr>' +
                  '<tr >' +
              '<td>test</td>' +
              '<td >ContentSearch0</td>' +
      '<td >ContentSearch7</td>' +
          '</tr>'
                '</table>';
            }

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
            else {
                PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select drug type..");
                $('#SearchResult').show();
            }
                
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
        //});
       
        function addInlineDurgs()
        {
           
            //$('#validationdurgs').click();
            var applicationshortno = document.getElementById('applicationshortno').value;
            var productid = document.getElementById('productid').value;
            var productndc = document.getElementById('productndc').value;
            var productcode = document.getElementById('productcode').value;
           var codeandndc = productcode.concat(productndc);
            var productname = document.getElementById('productname').value;
            var companyname = document.getElementById('companyname').value;
            var marketingPartner = document.getElementById('marketingpartner').value;
            var productcategory = document.getElementById('productcategory').value;
            //var molecule = document.getElementById('molecule').value;
            var molecule = [];
            $('#moleculearray').find('ul').find('li.tagging_tag').each(function () {
                molecule.push($(this).text().slice(0, -1));
            });
            var substance = document.getElementById('substance').value;
            var form = document.getElementById('form').value;
            var strength = document.getElementById('strength').value;
            var routeofadministration = document.getElementById('routeofadministration').value;
            //var diseasearea = document.getElementById('diseasearea').value;
            var diseasearea = [];
            $('#diseaseareaarray').find('ul').find('li.tagging_tag').each(function () {
                diseasearea.push($(this).text().slice(0,-1));
            });
            //var indication = document.getElementById('indication').value;
            var indication = [];
            $('#indicationarray').find('ul').find('li.tagging_tag').each(function () {
                indication.push($(this).text().slice(0, -1));
            });
            //var subindication = document.getElementById('subindication').value;
            var subindication = $('#subindicationdiv .note-editable').html();
            //var dosageadult = document.getElementById('dosageadult').value;
            var dosageadult = $('#dosageadultdiv .note-editable').html();
            //var dosagepediatric = document.getElementById('dosagepediatric').value;
            var dosagepediatric = $('#dosagepediatricdiv .note-editable').html();
            var price = document.getElementById('price').value;
            var pricingunit = document.getElementById('pricingunit').value;
            var pricesource = document.getElementById('pricesource').value;
            var pharmaclass = document.getElementById('pharmaclass').value;
            var pharmaclass2 = document.getElementById('pharmaclass2').value;
            var pharmaclass3 = document.getElementById('pharmaclass3').value;
            var imsclass = document.getElementById('imsclass').value;
            var moa = document.getElementById('moa').value;
            var approval = document.getElementById('approval').value;
            var startmarketingdate = document.getElementById('startmarketingdate').value;
            var producttype = document.getElementById('producttype').value;
            var durgstype = document.getElementById('durgstype').value;
            var marketStatus = document.getElementById('marstatus').value;
            var latestLabelDate = document.getElementById('latestlabeldate').value;
            var rld =  $('input[name="rld"]:checked').val();
            var teCode = document.getElementById('tecode').value;
            //if (pharmaclass == pharmaclass2 || pharmaclass == pharmaclass3 || pharmaclass == imsclass || pharmaclass2 == pharmaclass3 || pharmaclass2 == imsclass || pharmaclass3 == imsclass) {
            //    PHARMAACE.FORECASTAPP.UTILITY.popalert("Do not enter same class name");
            //}
            //else
            //if (pharmaclass != undefined || pharmaclass.trim() != ""  ) {
            //    if (pharmaclass == pharmaclass2 || pharmaclass == pharmaclass3 || pharmaclass == imsclass)
            //       PHARMAACE.FORECASTAPP.UTILITY.popalert("Do not enter same class name");
            //}
                if (!productid || !productndc || !productcode || !codeandndc || !productname || !companyname || !productcategory || !molecule || !substance || !form || !strength || !routeofadministration || !diseasearea || !indication || !subindication,
               !dosageadult || !dosagepediatric || !price || !pricingunit || !pricesource || !pharmaclass|| !moa || !approval || !startmarketingdate || !producttype || !durgstype  || !latestLabelDate || !rld ) {
                $('#validationdurgs').click();
             
            }
            else {
                var inlineDurgsData = inlineDurgsDataObj(applicationshortno, productid, productndc, productcode, codeandndc, productname, companyname,marketingPartner, productcategory, molecule, substance, form, strength, routeofadministration,diseasearea, indication, subindication,
                    dosageadult, dosagepediatric, price, pricingunit, pricesource, pharmaclass, pharmaclass2, pharmaclass3, imsclass, moa, approval, startmarketingdate, producttype, durgstype, marketStatus, latestLabelDate, rld, teCode);
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Saving your data", 'kmoverlayid', "15", "");
                var postData = JSON.stringify({ "dr": inlineDurgsData });
                PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Drugs/AddInlineDurgs", postData,
                     function (result) {
                         if (result.success) {
                             if (result.result == 1) {
                                 PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully added inline drugs");
                                 $('#cancelpopoup').click();
                             }
                             else if (result.result == 2) {
                                 PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Inline drug already added");
                                 $('#cancelpopoup').click();
                             }
                            
                         }
                         else {
                             PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                             PHARMAACE.FORECASTAPP.UTILITY.popalert("Fail to add inline drugs");
                         }

                     },
                      function (result) {
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed! " + result.responseText, '');

                      });
            }
        }
        function inlineDurgsDataObj(applicationshortno, productid, productndc, productcode,codeandndc, productname,companyname,marketingPartner, productcategory, molecule, substance, form, strength, routeofadministration,diseasearea, indication, subindication,
                dosageadult, dosagepediatric, price, pricingunit, pricesource, pharmaclass, pharmaclass2, pharmaclass3, imsclass, moa, approval, startmarketingdate, producttype, durgstype ,marketStatus, latestLabelDate, rld, teCode)
        {
                    var inlineDurgsObject = {
                        Application_Short_Number: applicationshortno,
                        Product_ID: productid,
                        Product_NDC: productndc,
                        Product_Code: productcode,
                        Code_and_NDC: codeandndc,
                        ProductName: productname,
                        CompanyName: companyname,
                        MarketingPartner: marketingPartner,
                        ProductCategory: productcategory,
                        Molecule: molecule,
                        Substance: substance,
                        FormName: form,
                        Strength: strength,
                        ROAType: routeofadministration,
                        Disease_Area: diseasearea,
                        IndicationName: indication,
                        Sub_Indication: subindication,
                        Dosage_Adult: dosageadult,
                        Dosage_Pediatric: dosagepediatric,
                        NADAC_Price: price,
                        NADAC_PricingUnit: pricingunit,
                        Price_Source: pricesource,
                        PHARMA_CLASSES: pharmaclass,
                        PHARMA_CLASSES2: pharmaclass2,
                        PHARMA_CLASSES3: pharmaclass3,
                        IMSClass: imsclass,
                        MOA: moa,
                        Approval_Date: approval,
                        StartMarketingDate: startmarketingdate,
                        Product_Type: producttype,
                        Drug_Type: durgstype,
                        MarketingStatus: marketStatus,
                        LatestLabelDate: latestLabelDate,
                        RLD: rld,
                        TECode: teCode
                    }
                    return inlineDurgsObject;
        }
        function clearInputField()
        {
            
            $('#applicationshortno').val('');
            $('#productid').val('');
            $('#productndc').val('');
            $('#productcode').val('');
            $('#productname').val('');
            $('#companyname').val('');
            $('#productcategory').val('');
            $('#molecule').val('');
            $('#substance').val('');
            $('#form').val('');
            $('#strength').val('');
            $('#routeofadministration').val('');
            $('#diseasearea').val('');
            $('#indication').val('');
            $('#subindication').val('');
            $('#dosageadult').val('');
            $('#dosagepediatric').val('');
            $('#price').val('');
            $('#pricingunit').val('');
            $('#pricesource').val('');
            $('#pharmaclass').val('');
            $('#pharmaclass2').val('');
            $('#pharmaclass3').val('');
            $('#imsclass').val('');
            $('#moa').val('');
            $('#approval').val('');
            $('#startmarketingdate').val('');
            $('#producttype').val('');
            $('#durgstype').val('');
        }
        
        function addApiData()
        {
            
             var submissionDate=document.getElementById("submissiondate").value;
             var dmfholdername=document.getElementById("dmfholdername").value;
             var dmfStatus=document.getElementsByName("dmfstatus").value;
           var andaHolder = document.getElementsByName("andaholder").value;
            var orgComm = document.getElementsByName("orgcomm").value;
            var apiData = '<tr><td>' + submissionDate +'</td>'+
                               '<td>' + dmfholdername + '</td>' +
                                '<td>' + dmfStatus +'</td>'+
                                 '<td>' + andaHolder + '</td>'+
                             '<td>' + orgComm + '</td>'
            +
                 '<td class="kmBox54"><a class="btn" onclick="delCurrentRow(this)" href="#"><i title="Remove" class="fa fa-times kmBox55"></i></a></td>' +           
            '</tr>';
            $("#apitable tr:first").after(apiData);
            

        }

        function delCurrentRow(numrow) {

            $(numrow).parent().parent().remove();
            var regulatoryrow = $(numrow).parent().parent();
            var rowVal= regulatoryrow.attr('rowno');
            $('#regulatorytable').find('tr').each(function () {
                
                if ($(this).attr('rowno') == rowVal) {
                    $(this).remove();
                }
            });
        }
        function addExlusivityInfo() {
            var Exclusivity = document.getElementById("exclusivitydrop").value;
            var Description = document.getElementById("description").value;
            var expiryDate = document.getElementById("expirydate1").value;
            var exclusiveData = '<tr><td>' + Exclusivity + '</td>' +
                                           '<td>' + expiryDate + '</td>' +
                                         '<td>' + Description + '</td>' +
                                         '<td class="kmBox54"><a class="btn" onclick="delCurrentRow(this)" href="#"><i title="Remove" class="fa fa-times kmBox55"></i></a></td>' +
                                         '</tr>';
            $("#exclusiveinfoable tr:first").after(exclusiveData);
        }
        var i = 0;
        function addPatentInfo() {
                    
            var patentNo = document.getElementById("patentno").value;
            var typeofpatent = document.getElementById("typeofpatent").value;
            var patentusecode = document.getElementById("patentusecode").value;
            var expirydate = document.getElementById("expirydate").value;
            var ptegranted = "Yes";
           
            if ($('input[name=ptegranted]').filter(':checked').val() == "1")
            {
                 ptegranted = "Yes";
            }
            else {
                ptegranted = "No";
            }
                //document.getElementsByName("ptegranted").value;

            var independentclaims = document.getElementById("independentclaims").value;

            var delistrequested = "Yes";
                //document.getElementsByName("delistrequested").value;

            if ($('input[name=delistrequested]').filter(':checked').val() == "1") {
                delistrequested = "Yes";
            }
            else {
                delistrequested = "No";
            }

            i++;
            var patentlicensinginfo = document.getElementById("patentlicensinginfo").value;
            
            var patentData = '<tr rowno='+i+'><td>' + patentNo + '</td>' +
                                           '<td>' + typeofpatent + '</td>' +
                                            '<td>' + patentusecode + '</td>' +
                                            '<td>' + expirydate + '</td>' +
                                            '<td>' + ptegranted + '</td>' +
                                            '<td>' + independentclaims + '</td>' +
                                            '<td>' + delistrequested + '</td>' +
                                         '<td>' + patentlicensinginfo + '</td>' +
            '<td class="kmBox54"><a class="btn" onclick="delCurrentRow(this)" href="#"><i title="Remove" class="fa fa-times kmBox55"></i></a></td>' + '</tr>';
            $("#patentinfotable tr:first").after(patentData);
            var addedrow=dt.row.add([
            '',
            patentNo,
            typeofpatent,
            patentusecode,
            expirydate
            ]).draw(false);
           
            dt.rows(addedrow).nodes().to$().attr("rowno", i);
           
           
        }
        function summerEditor(divname) {
            var $placeholder = $('.placeholder');
            $('#' + divname).summernote({
                height: 130,
                codemirror: {
                    mode: 'text/html',
                    htmlMode: true,
                    lineNumbers: true,
                    theme: 'monokai'
                },
                callbacks: {
                    onInit: function () {
                        $placeholder.show();
                    },
                    onFocus: function () {
                        $placeholder.hide();
                    },
                    onBlur: function () {
                        var $self = $(this);
                        setTimeout(function () {
                            if ($self.summernote('isEmpty') && !$self.summernote('codeview.isActivated')) {
                                $placeholder.show();
                            }
                        }, 100);
                    }
                }

            });
        }

       
 
    </script>

     
   
</asp:Content>
