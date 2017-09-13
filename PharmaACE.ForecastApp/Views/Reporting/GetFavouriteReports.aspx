<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CFSite.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<PharmaACE.ForecastApp.Models.BIReport>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
 Favourite Reports
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Favourite Reports</h2>
    <div id="drugsid" class="dataTables_wrapper form-inline dt-bootstrap">
        <div class="row">
            <div class="col-sm-12">
                <table id="example" class=" table table-bordered  dataTable table-striped box-shadow--6dp table-hover drugsearch hidecolumn" role="grid" aria-describedby="example_info">
                    <tbody id="tblthead" style="position: relative; float: left; width: 100%;">
                        <tr role="row">
                            <th style="width:30%;height:300px;padding:10px; border-color :red;border-style :solid;">
                                 <% foreach (var item in Model)
                               { %>
                            <%} %>
                            </th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
