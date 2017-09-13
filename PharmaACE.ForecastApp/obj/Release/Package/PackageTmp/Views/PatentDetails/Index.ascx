<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<PharmaACE.ForecastApp.Models.PatentDetail>>" %>
<%--<script src="../../Scripts/lib/bootstrap/jquery.dataTables.min.js"></script>
<script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>--%>
<%: Scripts.Render("~/Scripts/DrugsPatentDetailsScript") %>
<div class="" id="">
        <div class="dataTables_wrapper form-inline dt-bootstrap">
                    <table id="example" class="table table-bordered table-responsive  dataTable table-striped box-shadow--6dp table-hover" role="grid" aria-describedby="example_info" style="display:inline-block;">
                        <thead>
                            <tr role="row">
                                <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                    <%: Html.DisplayNameFor(model => model.ProductCode) %>
                                </th>
                                <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                    <%: Html.DisplayNameFor(model => model.PatentCode) %>
                                </th>
                                <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                    <%: Html.DisplayNameFor(model => model.ExclusivityCode) %>
                                </th>
                                <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                    <%: Html.DisplayNameFor(model => model.PatentNo) %>
                                </th>
                                <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                    <%: Html.DisplayNameFor(model => model.PatentExpireDate) %>
                                </th>
                                <th class="sorting_asc" tabindex="0" aria-controls="example" aria-sort="ascending" style="text-align: center;">
                                    <%: Html.DisplayNameFor(model => model.ExclusivityDate) %>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <% foreach (var item in Model)
                               { %>
                            <tr>
                                <td class="catlogo sorting_1">
                                    <%: Html.DisplayFor(modelItem => item.ProductCode ) %>
                                </td>
                                <td class="catlogo sorting_1">
                                 <%if(item.PatentDefinition!=null && item.PatentDefinition!=""){ %>
                                     <button data-content='   <%: Html.DisplayFor(modelItem =>item.PatentDefinition) %>' title="" data-rel="popover" class="btn btn-default btn-xs" data-original-title=""  onmousemove="popup()">   <%: Html.DisplayFor(modelItem =>item.PatentCode ) %></button>
                                <%}else{ %>
                                    <%: Html.DisplayFor(modelItem =>item.PatentCode ) %>
                                    <%} %>
                                </td>
                                <td class="catlogo sorting_1">
                                    <%if(item.ExclusivityDefinition!=null && item.ExclusivityDefinition!=""){ %>
                                    <button data-content='<%: Html.DisplayFor(modelItem => item.ExclusivityDefinition) %>' title="" data-rel="popover" class="btn btn-default btn-xs" data-original-title=""  onmousemove="popup()">   <%: Html.DisplayFor(modelItem => item.ExclusivityCode) %></button>
                                   <%}else{ %> 
                                    <%: Html.DisplayFor(modelItem => item.ExclusivityCode) %>
                                    <%} %>
                                </td>
                                <td class="catlogo sorting_1">
                                    <%: Html.DisplayFor(modelItem => item.PatentNo) %>
                                </td>
                                <td class="catlogo sorting_1">
                                    <%: Html.DisplayFor(modelItem => item.PatentExpireDate, "Date") %>
                                </td>
                                <td class="catlogo sorting_1">
                                    <%: Html.DisplayFor(modelItem => item.ExclusivityDate, "Date") %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
        </div>
</div>
