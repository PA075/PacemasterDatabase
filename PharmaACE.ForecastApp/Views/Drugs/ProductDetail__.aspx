<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ProductDetail>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Product Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
   <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>--%>
    <%: Scripts.Render("~/Scripts/DrugsProductDetailsScript") %>

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
                    <span><button type="button" class="btn btn-default" data-toggle="modal" role="button" id="addDurgs1"  data-target='#addDurgs' onclick="addDrugsDetails()" >Edit Drugs</button></span>
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
     <div class="modal" id="addDurgs" tabindex="-1" style="display: none;">
        <div class="modal-dialog">
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
                                <label class="col-md-4">Application Short No.</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="applicationshortno" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Product ID</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="productid" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Product NDC</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="productndc" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Product Code</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="productcode" type="text" required />
                                </div>
                            </div>
                        </div>
                   <%--     <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Code and NDC</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="codeandndc" type="text" />
                                </div>
                            </div>
                        </div>--%>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Product Name</label>
                                <div class="col-md-8">
                                    <div class="ui-widget">
                                    <input class="form-control" id="productname" type="text"  required />
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Company Name</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="companyname" type="text" required/>
                                </div>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Marketing Partner</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="marketingpartner" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Product Category</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="productcategory" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Molecule</label>
                                <div class="col-md-8">
                                    <input class="form-control" type="text" id="molecule" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Substance</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="substance" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Form</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="form" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Strength</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="strength" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Route of Administration</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="routeofadministration" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Disease Area</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="diseasearea" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Indication</label>
                                <div class="col-md-8">
                                    <input class="form-control tags-input" id="indication" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Sub Indication</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="subindication" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Dosage Adult</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="dosageadult" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Dosage Pediatric</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="dosagepediatric" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Price</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="price" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Pricing Unit</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pricingunit" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Price Source</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pricesource" type="text" required />
                                </div>
                            </div>
                        </div>
                     <%--   <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">PI Link</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pilink" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">PI Date</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pidate" type="text" />
                                </div>
                            </div>
                        </div>--%>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Pharma Class</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pharmaclass" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Pharma Class 2</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pharmaclass2" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Pharma Class 3</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="pharmaclass3" type="text" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">IMS Class</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="imsclass" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">MoA</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="moa" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Approval Date</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="approval" type="date" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Start Marketing Date</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="startmarketingdate" type="date" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Product Type</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="producttype" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Drug Type</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="durgstype" type="text" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Marketing Status</label>
                                <div class="col-md-8">
<%--                                    <input class="form-control" id="marstatus" type="text" />--%>

                                    <select id="marstatus" style="width:100%;">
                                        <option>Please Select</option>
                                        <option value="0">Prescription</option>
                                        <option value="1">Discontinued</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">Latest Label Date</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="latestlabeldate" type="date" />
                                </div>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">RLD</label>
                                <div class="col-md-8">
                                    <input  name="rld"  value="1" type="radio" checked>Yes
                                     <input name="rld" value="0" type="radio">No
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-md-4">TE Code</label>
                                <div class="col-md-8">
                                    <input class="form-control" id="tecode" type="text" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer ">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                          <input type="submit" class="btn btn-primary" id="validationdurgs"  style="display:none" />
                        <input type="button" class="btn btn-primary" onclick="addInlineDurgs();" value="Save" />
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
        function  addDrugsDetails()
        {
            $('#applicationshortno').val("<%=Model.CompanyName%>"); 
            $('#productid').val("<%=Model.ProductName%>"); 
            $('#productndc').val("<%=Model.CompanyName%>"); 
            $('#productcode').val("<%=Model.CompanyName%>"); 
            $('#productname').val("<%=Model.ProductName%>"); 
            $('#companyname').val("<%=Model.CompanyName%>"); 

            $('#marketingPartner').val("<%=Model.CompanyName%>"); 
            $('#productcategory').val("<%=Model.ProductCategory%>"); 
            $('#molecule').val("<%=Model.MoleculeName%>"); 
            $('#substance').val("<%=Model.Module%>"); 
            $('#form').val("<%=Model.FormName%>"); 
            $('#strength').val("<%=Model.CompanyName%>"); 

            $('#routeofadministration').val("<%=Model.CompanyName%>"); 
            $('#diseasearea').val("<%=Model.ProductName%>"); 
            $('#indication').val("<%=Model.CompanyName%>"); 
            $('#subindication').val("<%=Model.CompanyName%>"); 
            $('#dosageadult').val("<%=Model.ProductName%>"); 
            $('#dosagepediatric').val("<%=Model.CompanyName%>");

            $('#price').val("<%=Model.CompanyName%>"); 
            $('#pricingunit').val("<%=Model.ProductName%>"); 
            $('#pricesource').val("<%=Model.CompanyName%>"); 
            $('#pharmaclass').val("<%=Model.CompanyName%>"); 
            $('#pharmaclass2').val("<%=Model.ProductName%>"); 
            $('#pharmaclass3').val("<%=Model.CompanyName%>");
            
            $('#imsclass').val("<%=Model.CompanyName%>"); 
            $('#moa').val("<%=Model.ProductName%>"); 
            $('#approval').val("<%=Model.CompanyName%>"); 
            $('#startmarketingdate').val("<%=Model.CompanyName%>"); 
            $('#durgstype').val("<%=Model.ProductName%>"); 
            $('#marketStatus').val("<%=Model.CompanyName%>");


            $('#latestLabelDate').val("<%=Model.CompanyName%>"); 
            $('#rld').val("<%=Model.ProductName%>"); 
            $('#teCode').val("<%=Model.CompanyName%>");
          

           
            

            
        }
    </script>
</asp:Content>
