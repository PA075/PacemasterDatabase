<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<PharmaACE.ForecastApp.Models.Parameter>>" %>
<div>
    <%: Html.DropDownListFor(model => model.ParameterName, Model.ParameterName , new {@id = "ParameterList",  style = "Text-align:left; padding:0px 5px 0px 5px; border:1px solid #7D7D7D; border-radius:5px;" })%>
</div>
