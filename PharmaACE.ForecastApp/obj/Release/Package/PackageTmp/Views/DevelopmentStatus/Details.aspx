<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<PharmaACE.ForecastApp.Models.DevelopmentStatus>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Development Status Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="contentbox">
        <div class="row">
            <div class="kmBox35">
                <h2><%= ViewData["Status"] %> Details</h2>
            </div>
            <%--<div>
                <h3><b>Result found: <span style="color: red;"><%=Model.Count() %></span></b></h3>
            </div>--%>
              <div id="tblsummury">
         <div class="kmBox28"><h5 style="font-weight:bold; margin-bottom:0px;">Search Result for: <span class="rcount" ><%= ViewData["searchKey"] %></span></h5></div>
         <div class="kmBox28"><h5 style="font-weight:bold;">Result found: <span class="rcount"><%=Model.Count() %></span></h5></div><br /><br />
       <div class="kmBox29"><h5 style="font-weight:bold;">Inline: <span class="rcount"><%= ViewData["searchKey"] %></span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5></div><div style="float:left;"><h5>Generic: <span class="rcount"><%=Model.Count() %></span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5></div><div style="float:left;"><h5>Brand: <span class="rcount"><%=Model.Count() %></span></h5></div><br />
        <div class="kmBox28"><h5 style="font-weight:bold;">Pipeline: <span class="rcount"><%=Model.Count() %></span></h5></div>
    </div>
               <div class="kmBox36" id="summurySlider">
            <div class="SliderSidebar isCollapsed" style="">
                <div class="SliderSidebarContent isCollapsed kmBox37">
                    <div class="form-wrapper_right">
                              <div class="fkmBox28"><h5 class="kmBox38">Search Result for: <span class="rcount" ><%= ViewData["searchKey"] %></span></h5></div>
         <div class="kmBox28"><h5 class="kmBox31">Result found: <span class="rcount"><%=Model.Count() %></span></h5></div><br /><br />
       <div class="kmBox29"><h5 class="kmBox31">Inline: <span class="rcount"><%= ViewData["searchKey"] %></span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5></div><div style="float:left;"><h5>Generic: <span class="rcount"><%=Model.Count() %></span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5></div><div style="float:left;"><h5>Brand: <span class="rcount"><%=Model.Count() %></span></h5></div><br />
        <div class="kmBox28"><h5 class="kmBox31">Pipeline: <span class="rcount"><%=Model.Count() %></span></h5></div>
                       </div>
                </div>
                 <div onclick="toggleSliderSidebar();" class="toggleText isCollapsed " ><span>Search Result</span></div>
            </div>    
     </div>










            <br />
           <div class="dataTables_wrapper form-inline dt-bootstrap" id="SearchResult">
                <div class="row">
                    <div class="col-sm-12">
                       <table id="example" class=" table table-bordered  dataTable table-striped box-shadow--6dp table-hover drugsearch hidecolumn" role="grid" aria-describedby="example_info">
                           <thead style="display: none;">
                               <tr role="row">
                                   <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                       Sr.No.
                                   </th>
                                    <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                        <%: Html.DisplayNameFor(model => model.ProductName) %>
                                    </th>
                                    <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                        <%: Html.DisplayNameFor(model => model.PHARMA_CLASSES) %>
                                    </th>
                                    <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                        <%: Html.DisplayNameFor(model => model.CompanyName) %>
                                    </th>
                                    <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                        <%: Html.DisplayNameFor(model => model.FormName) %>
                                    </th>
                                    <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                        <%: Html.DisplayNameFor(model => model.StartMarketingdate) %>
                                    </th>
                                    <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                        <%: Html.DisplayNameFor(model => model.LoE) %>
                                    </th>
                                </tr>
                            </thead>
                             <tfoot style="position:absolute;width:100%; display:none;" id="tbltfoot">
                                <tr>
                        <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;width:3.0% !important;;">
                                       Sr.No. 
                                   </th>
                                   <th>
                                       <%: Html.DisplayNameFor(model => model.ProductName) %>
                                   </th>
                                   <th>
                                       <%: Html.DisplayNameFor(model => model.PHARMA_CLASSES) %>
                                   </th>
                                   <th>
                                       <%: Html.DisplayNameFor(model => model.CompanyName) %>
                                   </th>
                                   <th>
                                       <%: Html.DisplayNameFor(model => model.FormName) %>
                                   </th>
                                   <th>
                                       <%: Html.DisplayNameFor(model => model.StartMarketingdate) %>
                                   </th>
                                </tr>
                    </tfoot>
                            <tbody style="position: relative; float:left; width:100%;  border-top:2px solid #808080;" id="tblbody" class="tblbodyclass">
                                 <%int counter = 0; %>
                                <% foreach (var item in Model)
                                    { %>
                                <tr>
                                     <td>
                                        <%:Html.Raw(++counter)%>
                                    </td>
                                    <td>
                                        <%: Html.ActionLink(item.ProductName  , "ProductDetail", "Drugs", new { productName = item.ProductName, companyName = item.CompanyName }, null) %>
                                    </td>
                                    <td>
                                <%if (item.PHARMA_CLASSES.ToString() != null)
                                    { %>
                                <%  foreach (var x in item.PHARMA_CLASSES.Split(','))
                                    {%>
                                <%if (x.ToString() != "")
                                    { %>
                                <%: Html.ActionLink(x, "Details", "PharmaClass", new { ClassName =x.Trim()}, null) %><br />
                                <% } %>
                                <% } %>
                                <% } %>
                                <%if (item.PHARMA_CLASSES2.ToString() != null)
                                    { %>
                                <%if (item.PHARMA_CLASSES2 != null)
                                    { %>
                                <%  foreach (var x2 in item.PHARMA_CLASSES2.Split(','))
                                    {%>
                                <%if (x2.ToString() != "")
                                        { %>
                                <%: Html.ActionLink(x2, "Details", "PharmaClass", new { ClassName =x2.Trim()}, null) %><br />
                                <% } %>
                                <% } %>
                                <% }%>
                                <% } %>
                                <%if (item.PHARMA_CLASSES3.ToString() != null)
                                    { %>
                                <%if (item.PHARMA_CLASSES3 != null)
                                    { %>
                                <%  foreach (var x3 in item.PHARMA_CLASSES3.Split(','))
                                    {%>
                                <%if (x3.ToString() != "")
                                        { %>
                                <%: Html.ActionLink(x3, "Details", "PharmaClass", new { ClassName =x3.Trim()}, null) %><br />
                                <% } %>
                                <% } %>
                                <% }%>
                                <% } %>
                                <%if (item.IMSClass.ToString() != null)
                                    { %>
                                <%if (item.IMSClass != null)
                                    { %>
                                <%  foreach (var x4 in item.IMSClass.Split(','))
                                    {%>
                                <%if (x4.ToString() != "")
                                        { %>
                                <%: Html.ActionLink(x4, "Details", "PharmaClass", new { ClassName =x4.Trim()}, null) %><br />
                                <% } %>
                                <% } %>
                                <% }%>
                                <% } %>
                                          </td>
                                    <td>
                                        <%: Html.ActionLink(item.CompanyName , "Details", "Manufacturer", new { CompanyName = item.CompanyName }, null) %>
                                    </td>
                                    <td>
                                        <%: Html.DisplayFor(modelItem => item.FormName) %>
                                    </td>
                                    <td>
                                        <%: Html.DisplayFor(modelItem => item.StartMarketingdate) %>
                                    </td>
                                    <td>
                                        <%: Html.DisplayFor(modelItem => item.LoE) %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script>
        function toggleSliderSidebar() {
            $('.SliderSidebar .toggleText').toggleClass("isCollapsed", 800);
            $('.SliderSidebar').toggleClass("isCollapsed", 800);
            $('.SliderSidebar .SliderSidebarContent').toggleClass("isCollapsed", 800);
        }
        jQuery(document).ready(function () {
            $('#example').DataTable();
            $('#example_filter').addClass('pull-right');
            var tbltfoot = $("#tbltfoot");
            var thead = tbltfoot[0]
            var theadHtml = thead.innerHTML;
            PHARMAACE.FORECASTAPP.UTILITY.filteration(theadHtml);
        });
     </script>
</asp:Content>
