<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ProductDetail>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Product Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
   <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>--%>
    <%: Scripts.Render("~/Scripts/DrugsProductDetailsScript") %>
     <script src="../../Scripts/lib/jquery/jquery-ui.js"></script>
    <script src="../../Scripts/lib/jquery/typeahead.bundle.min.js"></script>
    <script src="../../Scripts/lib/jquery/typeahead.tagging.js"></script>
    <link href="../../Content/CSS/typeahead.tagging.css" rel="stylesheet" />
<script src="../../Scripts/custom/summernote.js"></script>
<link href="../../Content/CSS/summernote.css" rel="stylesheet" />


    <style>
        .textareasize{resize:none;}
         ul.tagging_ul li.tagging_tag:hover{cursor:pointer;}
        
    .ui-autocomplete{background-color:#ddd !important; z-index:9999;}
.ui-autocomplete li:hover{color: #ffffff!important;background-color:#0097cf!important;}
.ui-autocomplete li:focus, .ui-autocomplete li:active{color: #ffffff!important;background-color:#0097cf!important;}
.nav-tabs>li>a{
    padding:6px 23px;
}
.divd2{width:960px;}
    </style>
    <div id="EPDetailsDialoge" class="modal" tabindex="-1">
        <div class="modal-dialog" style="height: auto;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Patent Details</h4>
                </div>
                <div id="modal-body" class="modal-body">
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <div class="container" id="contentbox">
        <div class="">
            <div class="kmBox5">
                <h2><span class="kmBox6"><%= ViewData["productName"] %> Details</span>
                   
<%--                    <span><button type="button" class="btn btn-default" data-toggle="modal" role="button" id="addDurgs1"  data-target='#addDurgs' onclick="addDrugsDetails()" >Edit Drugs</button></span>--%>
                    <span>
                        <a title="Edit Drugs" href="#" data-toggle="modal"  id="addDurgs1" data-target='#addDurgs' onclick="addDrugsDetails()" style="color:#000;">
                             <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                        </a>
                    </span>
</h2>
            </div>
            <div class="table-responsive" id="SearchResult">
                <table id="" class="table table-bordered table-striped box-shadow--6dp table-hover" role="grid" aria-describedby="example_info">
                    <tr>
                        <th colspan="2">
                            <div class="display-label catlogo vbar kmBox8">
                                <div class="btbar kmBox9" >
                                    <%: Html.DisplayFor(model => model.ProductName ) %>
                                    <% var Category = Model.ProductCategory.ToString(); %>&nbsp;&nbsp;
                                    <%if (Category == "Generic")
                                      { %>
                                   <input type="button" class="btn btn-info btn-circle" value="G" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey = Category , searchParam = 6, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %>    '" />
                                    <%}
                                      else if (Category == "Brand")
                                      {%>
                                    <%--<input type="button" class="btn btn-default btn-circle" value="B" onclick="location.href='<%: Url.Action("Details", "Category",new { CategoryName = Category }, null) %>    '" />--%>
                                  <input type="button" class="btn btn-default btn-circle" value="B" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =Category , searchParam = 6, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %>    '" />
                                    <%}
                                      else if (Category == "Biologic")
                                      {%>
                                  <input type="button" class="btn btn-danger btn-circle" value="BL" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =  Category, searchParam = 6, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %>    '" />
                                    <%}
                                      else if (Category == "Biosimilar")
                                      {%>
                                   <input type="button" class="btn btn-warning btn-circle" value="Bs" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey = Category , searchParam = 6, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %>    '" />
                                    <% }%>
                                </div>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.MoleculeName) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%: Html.ActionLink(Model.MoleculeName, "GetDrugs", "Drugs", new { searchKey = Model.MoleculeName.Trim(), searchParam = 2, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.PHARMA_CLASSES) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                               <% if(Model.PHARMA_CLASSES != null)
                          
                                 { %>
                                <%  foreach (var pharmaclass in Model.PHARMA_CLASSES.Split(','))
                                    {%>
                                <span>
                                     <% if (String.IsNullOrEmpty(pharmaclass))
                                            continue; %>
                                    <%: Html.ActionLink(pharmaclass.Trim(), "GetDrugs", "Drugs", new { searchKey =pharmaclass.Trim(), searchParam = 3, searchCondition = 4,switchView=true  ,searchModule=Model.Module.ToString()}, null) %><br />
                                </span>
                                <% } %>
                                <%} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.CompanyName) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%if (Model.CompanyName != null)
                                  { %>
                                <%: Html.ActionLink(Model.CompanyName, "GetDrugs", "Drugs", new { searchKey =Model.CompanyName, searchParam = 5, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %>
                                <%} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.Indication) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%  foreach (var indication in Model.Indication.Split(','))
                                    {%>
                                <span>
                                    <% if (String.IsNullOrEmpty(indication))
                                            continue; %>
                                    <%: Html.ActionLink(indication.Trim(), "GetDrugs", "Drugs", new { searchKey =indication.Trim(), searchParam = 4, searchCondition = 4,switchView=true ,searchModule=Model.Module.ToString() }, null) %><br />
                                </span>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.Dosage_Adult) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <table>
                                    <tr class="kmBox11">
                                        <td class="kmBox10">
                                            <%if (Model.Dosage_Adult != null)
                                              { %>
                                            <% string ADosage = Model.Dosage_Adult; %>
                                            <button data-content="<%: Html.Raw(ADosage) %>" title="" data-rel="popover" class="btn btn-default btn-xs" data-original-title="" onmousemove="popup()">Adult</button>
                                            <%} %>
                                        </td>
                                        <td class="kmBox10">
                                            <%if (Model.Dosage_Pediatric != null)
                                              { %>
                                            <button data-content="<%: Html.Raw(Model.Dosage_Pediatric) %>" title="" data-rel="popover" class="btn btn-default btn-xs" data-original-title="" onmousemove="popup()">Pediatric</button></td>
                                        <%} %>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.FormName) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%: Html.DisplayFor(model => model.FormName) %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.StartMarketingDate) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%if (Model.StartMarketingDate.ToString().Contains("1/1/1900"))
                                  { %>
                                <%: Html.Raw(PharmaACE.ForecastApp.Business.GenUtil.StartMarketingDateNotAvailable) %>
                                <%}
                                  else
                                  {%>
                                <%: Html.DisplayFor(model => Model.StartMarketingDate) %>
                                <%} %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.Sub_Indication) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <% string Sub_Indication = Model.Sub_Indication.ToString().Replace("|^|", "<li>").Replace("|", "<br/>"); %>
                                <%: Html.Raw(Sub_Indication) %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.Strength ) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%: Html.DisplayFor(model => model.Strength) %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.NADAC_Price) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-label">
                               <%  string NADACPrice = string.Empty;
                                    string[] prices = Model.NADAC_Price.Split(',');
                                    for (int i = 0; i < prices.Length; i++)
                                    {
                                        NADACPrice += prices[i] +  " (" + Model.NADAC_PricingUnit.ToString() + ") ,";
                                        if (NADACPrice.Contains("(Not Available)"))
                                            NADACPrice = NADACPrice.Replace("(Not Available)", string.Empty);
                                    }%>
                                <%:Html.Raw(NADACPrice.TrimEnd(',')) %>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.ROAType) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <%: Html.DisplayFor(model => model.ROAType) %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                              <%: Html.DisplayNameFor(model => model.MOA) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <% string MOA = Model.MOA.ToString().Replace("|^|", "\n").Replace("|", "<li>"); %>
                                <%: Html.Raw(MOA.TrimStart ('\n')) %>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <div class="display-label">
                                <%: Html.DisplayNameFor(model => model.EPDetails) %>
                            </div>
                        </th>
                        <td>
                            <div class="display-field">
                                <a id="EPDetails" data-original-title="EPD Detail" title="EPD Detail" data-placement="bottom" href="#" data-title="Share" data-target="#EPDetailsDialoge" data-toggle="modal" class="ctooltip" onclick="showEPDDialoge();">
                                    <%:Model.EPDetails %></a>
                            </div>
                        </td>
                    </tr>
                </table>
                <br />
               <%-- <div style="text-align:right">
                 <a  href="<%=Url.Action("Index", "Drugs")%>"><button type="button" class="btn btn-primary" >Back</button></a>
                    </div  <div style="text-align:right">--%>
               <div class="kmBox12">
                  <a href="https://www.goodrx.com" target="_blank"><img class="kmBox13" src="../../Content/img/powered-by-goodrx.png"/></a>&nbsp &nbsp&nbsp &nbsp&nbsp &nbsp &nbsp&nbsp &nbsp&nbsp &nbsp&nbsp &nbsp&nbsp &nbsp&nbsp &nbsp &nbsp&nbsp &nbsp&nbsp &nbsp
                    <% if (Session["searchPage"].ToString() == "DrugsIndex")
                        {%>
                    <a href="<%=Url.Action("Index", "Drugs", new { returnBack = true })%>">
                        <button type="button" class="btn btn-primary btn-arrow-left" style="margin-top:0px;">Back</button></a>
                    <%  }
                        else
                        { %>
                    <a href="<%=Url.Action("Index", "KM", new { returnBack = true ,searchType=0})%>">
                        <button type="button" class="btn btn-primary btn-arrow-left" style="margin-top:0px;">Back</button></a>

                    <%} %>
                    </div>
            </div>
            <div id="dialog"></div>
            <br />
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
                                    <input class="form-control" id="marketingpartner" type="text" />
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
                               <div> <label class="control-label col-md-2">Dosage Adult</label></div>
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
                        <button type="button" class="btn btn-default" data-dismiss="modal" id="cancelpopoup">Cancel</button>
                         <input type="submit" class="btn btn-primary" id="validationdurgs"  style="display:none" />
                        <input type="button" class="btn btn-primary" id="editinlined" onclick="editInlineDurgs();" value="Save" />
                    </div>
                </form>
                    </div>
            </div>
        <!-- /.modal-content -->
    </div>
                  <!-- /.modal-dialog -->
               </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        var autocompleteListData;
        var productNameList = [];
        var pharmaClassNameList = [];
        var indicationNameList = [];
        var indicationNameList1 = [];
        var moleculeNameList = [];
        var moleculeNameList1 = [];
        var companyNameList = [];
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
           
        });
        function autoComplete(inputid,autoCompleteList)
        {
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
                    $("#"+inputid).val(ui.item.value);
                },
                focus: function (event, ui) {
                    event.preventDefault();
                    $("#"+inputid).val(ui.item.value);
                }
                
            });}
        function popup() {
            $('[data-rel=popover]').popover({
                placement: 'top',
                html: true,
                title : '<a href="#" class="close" data-dismiss="alert">×</a>'
            });
            //$(".popover").niceScroll({
            //    cursorfixedheight: 70
            //});
        }
        function showEPDDialoge() {
            var ProductCode="<%:Model.EPDetails %>";
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/PatentDetails/Index", { ProductCode:ProductCode },
                function (result) {
                    populateSharePopup(result);
                },
                function (result) {
                });
        }
        $(document).on("click", ".popover .close" , function(){
            $(this).parents(".popover").popover('hide');
        });
        function populateSharePopup(result) {
            var modalbody = document.getElementById('modal-body');
            modalbody.innerHTML = result;
            $("#modal-body").niceScroll({
                cursorfixedheight: 70
            });
        }
       
        function  addDrugsDetails()
        {
             $('#productname').val("<%=Model.ProductName%>"); 
            $('#companyname').val("<%=Model.CompanyName%>"); 
            $('#productcategory').val("<%=Model.ProductCategory%>"); 
           <%-- $('#molecule').val("<%=Model.MoleculeName%>"); --%>
            var imoleculeString="<%=Model.MoleculeName%>";
            var moleculeName=imoleculeString.split(",");
            for (var i = 0; i < moleculeName.length; i++)
            {
                $('#moleculearray').find('ul').append($("<li class='tagging_tag' title='"+ moleculeName[i] +"'>" +  moleculeName[i] + "<span class='tag_delete'>x</span></li>"));
            }
             $('#form').val("<%=Model.FormName%>"); 
            $('#strength').val("<%=Model.Strength%>");
            var indicationString="<%=Model.Indication%>";
            var indicationName=indicationString.split(",");
            for (var i = 0; i < indicationName.length; i++)
            {
                $('#indicationarray').find('ul').append($("<li class='tagging_tag' title='"+ indicationName[i] +"'>" +  indicationName[i] + "<span class='tag_delete'>x</span></li>"));
            }          
            $('#subindicationdiv .note-editable.panel-body').html("<%=Model.Sub_Indication%>");
            $('#dosageadultdiv .note-editable.panel-body').html("<%=Model.Dosage_Adult%>");
         $('#dosagepediatricdiv .note-editable.panel-body').html("<%=Model.Dosage_Pediatric%>");
<%--          $('#dosagepediatric').val("<%=Model.Dosage_Pediatric%>");--%>
             $('#routeofadministration').val("<%=Model.ROAType%>"); 
            $('#pharmaclass').val("<%=Model.PHARMA_CLASSES%>"); 
            $('#pharmaclass2').val("<%=Model.PHARMA_CLASSES2%>"); 
            $('#pharmaclass3').val("<%=Model.PHARMA_CLASSES3%>");
            $('#imsclass').val("<%=Model.IMSClass%>");
            var startDate=dateTimeToDate(new Date("<%=Model.StartMarketingDate%>"));
            $('#startmarketingdate').val(startDate); 
            $('#moa').val("<%=Model.MOA%>"); 

            $('#applicationshortno').val("<%=Model.Application_Short_Number%>"); 
            $('#productid').val("<%=Model.Product_ID%>"); 
            $('#productndc').val("<%=Model.Product_NDC%>"); 
            $('#productcode').val("<%=Model.Product_Code%>");
            $('#substance').val("<%=Model.Substance%>");
            <%-- var price="<%=Model.NADAC_Price%>";
           
            $('#price').val( price.substring(price.indexOf("$") + 1));--%> 
            $('#price').val("<%=Model.Price%>"); 
            $('#pricingunit').val("<%=Model.NADAC_PricingUnit%>"); 
            $('#pricesource').val("<%=Model.Price_Source%>"); 
            $('#marketingpartner').val("<%=Model.MarketingPartner%>");
             var approveDate=dateTimeToDate(new Date("<%=Model.Approval_Date%>"));
            $('#approval').val(approveDate); 
            
            $('#producttype').val("<%=Model.Product_Type%>");
            $('#durgstype').val("<%=Model.Drug_Type%>"); 
            <%--            $("#marstatus").val("<%=Model.MarketingStatus%>");--%>
            if ("<%=Model.MarketingStatus%>"!=-1) {
                $("#marstatus").val("<%=Model.MarketingStatus%>");
            }
         
           
             var latestLabelDate=dateTimeToDate(new Date("<%=Model.LatestLabelDate%>"));
            $('#latestlabeldate').val(latestLabelDate); 
     var rld= "<%=Model.RLD%>";
            if (rld=="False") {
                $('input[name=rld][value=0]').prop('checked', true);
            }
            else
            {
                $("[name=rld]").val(["1"]);
                $('input:radio[name="rld"]').prop('checked', true);
            }
            $('#tecode').val("<%=Model.TECode%>");

            <%foreach(var item in Model.Disease_Area)
              {%>
            var disease="<%=item%>";
            $('#diseaseareaarray').find('ul').append($("<li class='tagging_tag' title='"+disease +"'>" +disease+ "<span class='tag_delete'>x</span></li>"));
       <% }
            %>
            
        }
        function dateTimeToDate(date){
            var pad = function(num) {
                var s = '0' + num;
                return s.substr(s.length - 2);
            }
            var Result = date.getFullYear() + '-' + pad((date.getMonth() + 1)) + '-' + pad(date.getDate());
            return Result;
        }
        function summerEditor(divname) {
            var $placeholder = $('.placeholder');
            $('#'+divname).summernote({
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
        function editInlineDurgs()
        {
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
            var inlineTransactionId="<%=Model.InlineTransactionId%>";
            //if (pharmaclass == pharmaclass2 || pharmaclass == pharmaclass3 || pharmaclass == imsclass || pharmaclass2 == pharmaclass3 || pharmaclass2 == imsclass || pharmaclass3 == imsclass) {
            //    PHARMAACE.FORECASTAPP.UTILITY.popalert("Do not enter same class name");
            //}
            //else 
                if (!productid || !productndc || !productcode || !codeandndc || !productname   || !productcategory || !molecule || !substance || !form || !strength || !routeofadministration  || !indication || !subindication,
               !dosageadult || !dosagepediatric || !price || !pricingunit || !pricesource || !pharmaclass|| !moa || !approval || !startmarketingdate || !producttype || !durgstype || !latestLabelDate || !rld ) {
                $('#validationdurgs').click();
             
            }
            else {
                var inlineDurgsData = inlineDurgsDataObj(applicationshortno, productid, productndc, productcode, codeandndc, productname, companyname,marketingPartner, productcategory, molecule, substance, form, strength, routeofadministration,diseasearea, indication, subindication,
                    dosageadult, dosagepediatric, price, pricingunit, pricesource, pharmaclass, pharmaclass2, pharmaclass3, imsclass, moa, approval, startmarketingdate, producttype, durgstype, marketStatus, latestLabelDate, rld, teCode,inlineTransactionId);
                PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Saving your data", 'kmoverlayid', "15", "");
                var postData = JSON.stringify({ "dr": inlineDurgsData });
                PHARMAACE.FORECASTAPP.SERVICE.postJsonData("/Drugs/EditInlineDurgs", postData,
                     function (result) {
                         if (result.success) {
                             if (result.result == 1) {
                                 $('#cancelpopoup').click();
                                 PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                                             PHARMAACE.FORECASTAPP.UTILITY.popalert("Successfully updated inline drugs");
                                    
                                // window.location.href = "/Drugs";
                             }
                        
                         }
                         else {
                             PHARMAACE.FORECASTAPP.UTILITY.hideOverlay('kmoverlayid');
                             PHARMAACE.FORECASTAPP.UTILITY.popalert("Fail to update inline drugs");
                         }

                     },
                      function (result) {
                          PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed! " + result.responseText, '');

                      });
            }

        }
        function inlineDurgsDataObj(applicationshortno, productid, productndc, productcode,codeandndc, productname,companyname,marketingPartner, productcategory, molecule, substance, form, strength, routeofadministration,diseasearea, indication, subindication,
               dosageadult, dosagepediatric, price, pricingunit, pricesource, pharmaclass, pharmaclass2, pharmaclass3, imsclass, moa, approval, startmarketingdate, producttype, durgstype ,marketStatus, latestLabelDate, rld, teCode,inlineTransactionId)
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
                TECode: teCode,
                InlineTransactionId:inlineTransactionId
            }
            return inlineDurgsObject;
        }
    </script>
</asp:Content>
