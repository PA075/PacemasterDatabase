<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.DiseaseListModel>" %>
<!DOCTYPE html>
<script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
<html>
<body>
    <div>
            <%: Html.LabelFor(model=> model.DiseaseList) %>
            <%: Html.DropDownListFor(model => model.DiseaseList, Model.DiseaseList.OrderBy(model=>model.Text), new {@id = "DiseaseList", onchange = "diseaseSelected()", style = "Text-align:left; padding:0px 5px 0px 5px; border:1px solid #7D7D7D; border-radius:5px;" })%>
    </div>
</body>
</html>
<script type="text/javascript">
    function diseaseSelected() {
        var ele = document.getElementById('DiseaseList');
        var DiseaseName = ele.options[ele.selectedIndex].value;
        PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/IndicationList/Index", { DiseaseName: DiseaseName },
            function (data) {
                document.getElementById('IndicationListDiv').innerHTML = data;
            },
            function (status) {
                alert(status);
            });
        return false;
    }
</script>