<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.DiseaseAreaSearchResult>" %>
<table>
    <tr>
        <th>
            Results Found: <span class="kmBox6"><%: Model.IndicationsList.Count + Model.TherapyAreasList.Count %></span>
        </th>
    </tr>
    <% if (Model.TherapyAreasList.Count > 0){ %>
    <tr>
        <th>
            <p>Therapy Areas</p>
        </th>
    </tr>
    <% foreach (var Therapy in Model.TherapyAreasList){ %>
    <tr>
        <td>
            <%: Html.ActionLink(Therapy.TherapyArea, "IndicationsSearch", "DiseaseArea", new { DiseaseName = Therapy.TherapyArea, SearchType = 1 }, null)%>
            <br />
        </td>
    </tr>
    <% }%>
    <% }%>
    <% if (Model.IndicationsList.Count > 0) { %>
    <tr>
        <th>
            <p>Indications</p>
        </th>
    </tr>
    <% foreach (var Ind in Model.IndicationsList){ %>
    <tr>
        <td>
          
            <%: Html.ActionLink(Ind.Indication, "DiseaseDetail", "DiseaseArea", new { DiseaseName = Ind.Indication, SearchType = 1 }, null) %> 
          
        </td>
    </tr>
    <% }%>
    <% }%>
</table>
