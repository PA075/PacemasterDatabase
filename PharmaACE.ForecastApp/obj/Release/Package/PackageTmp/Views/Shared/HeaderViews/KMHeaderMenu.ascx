<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
        <ul class="nav navbar-nav" id="options"">
                            <li id="Home"  ><%: Html.ActionLink("Home", "Index", "KM") %></li>
                            <li id="DiseaseArea" ><%: Html.ActionLink("Disease Area", "Index", "DiseaseArea") %></li>
                            <li id="Drugs" ><%: Html.ActionLink("Drugs", "Index", "Drugs") %></li>
                             <li><%: Html.ActionLink("Patent", "Index", "Patent") %></li>
                             <li><%: Html.ActionLink("Clinical Trials", "Index", "ClinicalTrials") %></li>
        </ul>
