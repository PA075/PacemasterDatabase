<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<PharmaACE.ForecastApp.Models.Division>>" %>

<ul class="nav navbar-nav" id="options"">
     <li id="Home"  ><%: Html.ActionLink("Home", "Index", "LiveFeed") %></li>
     <% foreach (var item in Model){%>
     <li id="<%:item.DivisionName%>">
         <%: Html.ActionLink(item.DivisionName, "Index",  "LiveFeed" ) %>
     </li> 
      <% } %>
     <li id="OTHERS"><%: Html.ActionLink("OTHERS", "Index", "LiveFeed") %></li>
</ul>

