<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

  <ul class="nav navbar-nav" id="options"">
            <li id="Home"  style="display:none;" class="" ><%: Html.ActionLink("Home", "Index", "LiveFeed") %></li>
            <li id="Generic" style="display:none;" ><%: Html.ActionLink("Generic", "Index", "LiveFeed") %></li>
            <li id="Hospital" style="display:none;" ><%: Html.ActionLink("Hospital", "Index", "LiveFeed") %></li>
            <li id="ARD" style="display:none;"><%: Html.ActionLink("ARD", "Index", "LiveFeed") %></li>
            <li id="OTHERS" style="display:none;"><%: Html.ActionLink("Others", "Index", "LiveFeed") %></li>
        </ul>
