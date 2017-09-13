<%@ Control Language="C#"  Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.DrugSearchList>" %>
<div id="tblsummury" class="margin-top">
      <div class="kmBox26">
        <h5 class="kmBox27">Search Result for: <span class="rcount"><%= ViewData["searchKey"] %></span></h5>
    </div>
    <div class="kmBox28">
        <h5 class="kmBox30">Result found: <span id="total_count" class="rcount">
            <%=Model.DrugsList.Count() %></span></h5>
    </div>
    <br />
    <br />
    <div class="kmBox29">
        <h5 class="kmBox31">Inline: <span id="inline_count" class="rcount"><%=Model.Summary.InlineEntries.Count() %></span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5>
    </div>
    <div class="kmBox32">
        <h5>Generic: <span id="generic_count" class="rcount">
            <%=Model.Summary.GenericEntries.Count() %></span>&nbsp;&nbsp;&nbsp;<span class="summurrySep">/</span>&nbsp;&nbsp;&nbsp;</h5>
    </div>
    <div class="kmBox32">
        <h5>Brand: <span id="brand_count" class="rcount"><%=Model.Summary.BrandEntries.Count() %></span></h5>
    </div>
    <br />
    <div class="kmBox28">
        <h5 style="font-weight: bold;">Pipeline: <span id="pipeline_count" class="rcount"><%=Model.Summary.PipelineEntries.Count() %></span></h5>
    </div>
</div>

<div id="drugsid" class="dataTables_wrapper form-inline dt-bootstrap margin-tablsummary">
    <div class="row">
        <div class="col-sm-12">
            <table id="example" class=" table table-bordered  dataTable table-striped box-shadow--6dp table-hover drugsearch " role="grid" aria-describedby="example_info">
                <thead id="tblthead">
                     <tr role="row" id="drgfirstrow">
                        <th onclick="return false;">SNo.</th>                       
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).ProductName) %> 
                        </th>
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).MoleculeName) %>
                        </th>
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).PHARMA_CLASSES) %>
                        </th>
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).CompanyName) %>
                        </th>
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).Indication) %>
                        </th>
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).ROAType) %>
                        </th>
                        <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).Phase) %>
                        </th>
                         <th>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).FormName) %>
                         </th>
                    </tr>
                   
                </thead>
                <tfoot class="kmBox33" id="tbltfoot">
                    <tr>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending" style="width: 3.3% !important;">SNo. 
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending" s>
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).ProductName) %> 
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending" >
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).MoleculeName) %>
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending" >
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).PHARMA_CLASSES) %>
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending" >
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).CompanyName) %>
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending">
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).Indication) %>
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending">
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).ROAType) %>
                        </th>
                        <th class="sorting_asc kmBox34" tabindex="0" aria-controls="example" aria-sort="ascending" >
                            <%: Html.DisplayNameFor(model => model.DrugsList.ElementAt(0).Phase) %>
                        </th>
                    </tr>
                </tfoot>
                <tbody class="open" id="tblbody">
                    <%int counter = 0; %>
                    <% foreach (var item in Model.DrugsList)
                       { %>
                  <tr rowType='<%=item.Phase%>' moleculeList='<%=item.MoleculeName %>'
                       <%if (item.InlineId != 0)
                        { %>inlineId="<%=item.InlineId %>" <%} %>
                      >
                        <td >
                            <%:Html.Raw(++counter)%>
                        </td>
                        <td class="catlogo sorting_1">
                            <%if (item.Module == 1)
                              { %>
                                  <input type="button" class="btn btn-default btn-circle" style="margin-left:1px" value="P" id="adddrugpat"  data-toggle="modal"  data-target='#addPatent' onclick="fillPatentPopup(this);"/>
                            <%: Html.ActionLink(item.ProductName  , "ProductDetail", "Drugs", new { productName = item.ProductName, companyName = item.CompanyName ,searchModule=item.Module.ToString(),dosageForm=item.FormName.ToString()}, null) %>
                            <%}
                              else
                              { %>
                            <%: Html.ActionLink(item.ProductName  , "PipeLineProductDetail", "Drugs", new { productName = item.ProductName, companyName = item.CompanyName ,phase=item.Phase,searchModule=item.Module.ToString() }, null) %>
                            <%} %>
                             <div class="btbar">
                                <%if (item.ProductCategory == "Generic")
                                  { %>
                                <input type="button" class="btn btn-info btn-circle" value="G" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =  ViewData["searchKey"]  , searchParam = ViewData["searchParam"], searchCondition = 2,switchView=true,searchModule=item.Module.ToString(),category=5 }, null) %>    '" />
                                <%}
                                  else if (item.ProductCategory == "Brand")
                                  {%>
                                <input type="button" class="btn btn-default btn-circle" value="B" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =  ViewData["searchKey"] , searchParam = ViewData["searchParam"], searchCondition = 2,switchView=true,searchModule=item.Module.ToString(),category=3 }, null) %>    '" />
                                <%}
                                  else if (item.ProductCategory == "Biologic")
                                  {%>
                                <input type="button" class="btn btn-danger btn-circle" value="BL" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =  ViewData["searchKey"], searchParam = ViewData["searchParam"], searchCondition = 2,switchView=true,searchModule=item.Module.ToString(),category=1 }, null) %>    '" />
                                <%}
                                  else if (item.ProductCategory == "Biosimilar")
                                  {%>
                                <input type="button" class="btn btn-warning btn-circle" value="BS" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =  ViewData["searchKey"] , searchParam = ViewData["searchParam"], searchCondition = 2,switchView=true,searchModule=item.Module.ToString(),category=2 }, null) %>    '" />
                                <% }
                                 else if (item.ProductCategory == "Branded Generic")
                                  {%>
                                <input type="button" class="btn btn-warning btn-circle" value="BG" onclick="location.href='<%: Url.Action("GetDrugs", "Drugs", new { searchKey =  ViewData["searchKey"] , searchParam = ViewData["searchParam"], searchCondition = 2,switchView=true,searchModule=item.Module.ToString(),category=4 }, null) %>    '" />
                                <% }%>
                            </div>
                        </td>
                        <td>
                        <%if (!String.IsNullOrEmpty(item.MoleculeName))
                              { %>
                            <%  foreach (var molecule in item.MoleculeName.Split(','))
                                {%>
                            <%if (!String.IsNullOrEmpty(molecule))
                              { %>
                            <%: Html.ActionLink(molecule, "GetDrugs", "Drugs", new { searchKey =molecule, searchParam = 2, searchCondition = 4,switchView=true,searchModule=item.Module.ToString() }, null) %>
                            <br />
                            <% } %>
                            <% } %>
                            <% } %>
                             </td>
                        <td>
                            <%if (!String.IsNullOrEmpty(item.PHARMA_CLASSES))
                              { %>
                            <%  foreach (var x in item.PHARMA_CLASSES.Split(','))
                                {%>
                            <%if (!String.IsNullOrEmpty(x))
                              { %>
                            <%: Html.ActionLink(x, "GetDrugs", "Drugs", new { searchKey =x, searchParam = 3, searchCondition = 4,switchView=true,searchModule=item.Module.ToString() }, null) %>
                            <br />
                             <br />
                            <% } %>
                            <% } %>
                            <% } %>
                            <%if (!String.IsNullOrEmpty(item.PHARMA_CLASSES2))
                              { %>                            
                            <%  foreach (var x2 in item.PHARMA_CLASSES2.Split(','))
                                {%>
                            <%if (!String.IsNullOrEmpty(x2))
                              { %>
                            <%: Html.ActionLink(x2, "GetDrugs", "Drugs", new { searchKey =x2, searchParam = 3, searchCondition = 4,switchView=true,searchModule=item.Module.ToString() }, null) %><br />
                            <% } %>
                            <% } %>
                            <% } %>                            
                            <%if (!String.IsNullOrEmpty(item.PHARMA_CLASSES3))
                              { %>
                            <%  foreach (var x3 in item.PHARMA_CLASSES3.Split(','))
                                {%>
                            <%if (!String.IsNullOrEmpty(x3))
                              { %>
                            <%: Html.ActionLink(x3, "GetDrugs", "Drugs", new { searchKey =x3, searchParam = 3, searchCondition = 4,switchView=true,searchModule=item.Module.ToString() }, null) %><br />
                            <% } %>
                            <% } %>
                            <% }%>
                        </td>
                        <td>
                            <% if (!String.IsNullOrEmpty(item.CompanyName))
                               {  %>
                            <%: Html.ActionLink(item.CompanyName, "GetDrugs", "Drugs", new { searchKey =item.CompanyName, searchParam = 5, searchCondition = 4,switchView=true ,searchModule=item.Module.ToString()}, null) %>
                            <% }
                               else
                               { %>
                            <%: Html.DisplayFor(modelItem => item.CompanyName) %>
                            <%}%>
                        </td>
                        <td class="kmBox42">
                            <%if (!String.IsNullOrEmpty(item.Indication))
                              { %>
                            <%  foreach (var ind in item.Indication.Split(','))
                                {%>
                            <%if (!String.IsNullOrEmpty(ind))
                              { %>
                            <%: Html.ActionLink(ind, "GetDrugs", "Drugs", new { searchKey =ind.Trim (), searchParam = 4, searchCondition = 4,switchView=true,searchModule=item.Module.ToString() }, null) %><br />
                            <% } %>
                            <% } %>
                            <% }%>
                        </td>
                        <td class="kmBox40">
                            <%: Html.DisplayFor(modelItem => item.ROAType ) %>
                        </td>
                        <%
                            if ((item.Phase).IndexOf("Phase")==-1)
                            {
                                %>
                            <td class="kmBox41">
                            <%: Html.DisplayFor(modelItem => item.Phase) %>
                            </td>
                                <%
                             }
                             else
                             {
                             %>
                        <td class="kmBox1">
                            <%: Html.DisplayFor(modelItem => item.Phase) %>
                        </td>
                             <%
                              }
                              %> 
                         <td class="kmBox34">
                            <%: Html.DisplayFor(modelItem => item.FormName) %>
                        </td>                       
                    </tr>
                    <% if (counter == Model.DrugsList.Count()) break;
                           } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%--<%: Scripts.Render("~/Scripts/jqueryLIB", "~/Scripts/bootstrapLIB") %>--%>
<%--<script src="../../Scripts/lib/bootstrap/jquery.dataTables.min.js"></script>--%>
<%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/css/bootstrap-select.min.css">--%>
<!-- Latest compiled and minified JavaScript -->
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/bootstrap-select.min.js"></script>--%>
<!-- (Optional) Latest compiled and minified JavaScript translation files -->
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.10.0/js/i18n/defaults-*.min.js"></script>--%>
<script id="get_drugs_script">
    var arrInline = <%=Html.Raw(Json.Encode(Model.Summary.InlineEntries))%>;
    var arrGeneric = <%=Html.Raw(Json.Encode(Model.Summary.GenericEntries))%>;
    var arrBranded = <%=Html.Raw(Json.Encode(Model.Summary.BrandEntries))%>;
    function populateSummary(displayedItems){
        var totalCount = displayedItems.length;
        var inlineCount = $(displayedItems).filter(arrInline).length;
        $('#total_count').text(totalCount);
        $('#inline_count').text(inlineCount);
        $('#pipeline_count').text(totalCount - inlineCount);
        $('#generic_count').text($(displayedItems).filter(arrGeneric).length);
        $('#brand_count').text($(displayedItems).filter(arrBranded).length);
    }
    
    $(document).ready(function () {
        $('#searchbar .selectBox').click( function(){
            if($('#searchbar .select-dropdown').hasClass('open'))
            {
                $('#SearchResult').css("z-index","0");
            }
            else{
                $('#SearchResult').css("z-index","-1");
            }
        });
        //This is for visible dtatable searchbox after dropdown select
        $(document).on('click', function (e) {
            if(!$('#searchbar div.select-dropdown').hasClass('open'))
            {
                $('#SearchResult').css("z-index","0");
            }
        });
      
    });
</script>
