<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<PharmaACE.ForecastApp.Models.Indications>>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Indication Search
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="contentbox">
        <div class="row">
            <div class="kmBox5">
                <h2><span class="kmBox6"><%= ViewData["DiseaseName"] %> </span></h2>
            </div>
            <div>
                <h3><b>Result found: <span style="color: red;"><%=Model.Count() %> </span></b></h3>
            </div>
            <br />
            <div class="mw-body" id="SearchResult">
                <table>
                    <tr>
                        <th>
                            <%: Html.DisplayNameFor(model => model.Indication) %>
                        </th>
                    </tr>
                    <% foreach (var item in Model)
                       { %>
                    <tr>
                        <td>
                             <%: Html.ActionLink(item.Indication , "DiseaseDetail", "DiseaseArea", new { DiseaseName = item.Indication,SearchType=1 }, null) %> 
                        </td>
                    </tr>
                    <% } %>
                    <tr>
                        <td>
                            <p>
                                
                            

                                <% if (Session["DSearchPage"].ToString() == "DiseaseAreaIndex")
                                    {%>
                              <%--   <%: Html.ActionLink("Back to Search", "Index", new { ReturnBack = true }) %>--%>
                                  <a href="<%=Url.Action("Index", "DiseaseArea", new { returnBack = true ,searchType=1})%>">
                        <button type="button" class="btn btn-primary btn-arrow-left">Back</button></a>
                                <%  }
                                    else
                                    { %>
                                    <a href="<%=Url.Action("Index", "KM", new { returnBack = true ,searchType=1})%>">
                        <button type="button" class="btn btn-primary btn-arrow-left">Back</button></a>
                         
                                <%} %>
                            </p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%-- <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js" defer></script>--%>
    <%: Scripts .Render ("~/Scripts/bootboxScript") %>
</asp:Content>
