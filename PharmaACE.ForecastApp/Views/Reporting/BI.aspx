<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.BIReportPageModel>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    BI
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">    
    <link href="../../Content/CSS/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="../../Scripts/lib/bootstrap/bootstrap-multiselect.js"></script>
    <script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <div class="container">
        <div class="row">
            <h2>Report</h2>
        </div>
        <div>
            <div>
                <select id="versions_multiselect" class="form-control" multiple="multiple"></select>
            </div>
             <div id="ParameterList">
              </div>
            <div>
                 <input type="button" id="generateReport" value="Generate Report" onclick ="generateReport();" /> 
            </div>
        </div>
        <div>
            <div>
                <% if (Model.ReportList != null && Model.ReportList.Count > 0)
                   { %>
                    <select id="ReportList" name="ReportList" >
                    <option value="0">Select</option>
                    <% foreach (var item in Model.ReportList)
                       { %>
                    <option value="<%= item.embedUrl %>" ><%= item.name %></option>
                    <%} %>
                </select>
                <%} %>
            </div>
        </div>
        <div>
            <br />
            <asp:Panel ID="PanelEmbed" runat="server" Visible="true">
                <table>
                    <tr>
                        <td>
                            <iframe id="iFrameEmbedReport" src="" height="600px" width="1024px" frameborder="1" seamless></iframe>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <br />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        var model = JSON.parse('<%=Html.Raw(Json.Encode(Model))%>');
        window.onload = function () {
            populateVersionsDropdown();
            $('#versions_multiselect').multiselect();            
        }
        function postActionLoadReport() {
            if ("" === accessToken)
                return;
            var m = { action: "loadReport", accessToken: accessToken };
            message = JSON.stringify(m);
            iframe = document.getElementById('iFrameEmbedReport');
            iframe.contentWindow.postMessage(message, "*");
        }
        function populateVersionsDropdown() {
            for (var i = 0; i < model.VersionList.length; i++) {
                $('#versions_multiselect').append("<option value=" + model.VersionList[i].id + ">" + model.VersionList[i].versionName + "</option>");
            }
        }
        function generateReport() {
            var versionListVal = null;
            versionListVal = getSelectedVersions();
            versionNamesList = getSelectedVersionNames();
            getParameters(versionNamesList);
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Reporting/SaveVersions", { SelectedVersions: versionListVal },
               function (result) {
                   if (result.success) {
                       var iFrame = document.getElementById('iFrameEmbedReport');                       
                       accessToken = result.pageModel.AccessToken;
                       iFrame.src = "https://app.powerbi.com/reportEmbed?reportId=87fa9c35-731f-449a-b030-c960ea2f1818";
                       iFrame.onload = postActionLoadReport;
                   }
               },
               function (result) {
               });
        }
        function getSelectedVersions() {
            var select1 = document.getElementById('versions_multiselect');
            var selected1 = [];
            for (var i = 0; i < select1.options.length; i++) {
                if (select1.options[i].selected) selected1.push(select1.options[i].value);
            }
            getParameters(selected1.join(','));
            return selected1.join(',');
        }
        function getSelectedVersionNames() {
            var select2 = document.getElementById('versions_multiselect');
            var selected2 = [];
            for (var i = 0; i < select2.options.length; i++) {
                if (select2.options[i].selected) selected2.push( select2.options[i].text);
            }
            getParameters(selected2.join(','));
            return selected2.join(',');
        }
        function getParameters(versionNamesList) {
            var versions = versionNamesList;
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Reporting/getParametersList", { versions: versions },
                function (data) {
                    document.getElementById('ParameterList').innerHTML = data;
                },
                function (status) {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert(status);
                });
        }
    </script>
</asp:Content>
