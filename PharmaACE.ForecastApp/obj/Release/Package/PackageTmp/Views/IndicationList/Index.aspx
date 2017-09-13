<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.IndicationListModel>" %>
<!DOCTYPE html>
<html>
<body>
    <div>
            <%: Html.LabelFor(model=> model.IndicationList) %>
            <%: Html.DropDownListFor(model => model.IndicationList, Model.IndicationList, new { style = "Text-align:left; padding:0px 5px 0px 5px; border:1px solid #7D7D7D; border-radius:5px;" })%>
    </div>
</body>
</html>
