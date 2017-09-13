<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
        <ul class="nav navbar-nav" id="options"">
            <li id="Home"  ><%: Html.ActionLink("Home", "Index", "KM") %></li>
            <li id="Generic" >Generic</li>
            <li id="Hospital" >Hospital</li>
            <li id="ARD">ARD</li>
            <li id="OTHERS">OTHERS</li>
        </ul>
