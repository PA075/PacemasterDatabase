<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    MediaManagement
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="contentbox">
        <div class="row">
            <div class="kmBox5">
                <h2><span class="kmBox6">Media Management</span></h2>
                <br />
            </div>
            <div class="mw-body" id="SearchResult">
                <div>
                    <table class="kmBox2">
                        <tr class="kmBox2">
                            <td  >
                                <div class="display-label">
                                    <% Html.RenderAction("Index", "DiseaseList"); %>
                                </div>
                                <br />
                                <div id="IndicationListDiv" class="display-label">
                                </div>
                                <div class="display-label">
                                    <% Html.RenderAction("Index", "SelectFile"); %>
                                </div>
                                <div class="display-label">
                                    <label class="control-label" for="videolink">video link</label>
                                    <input type="text" name="videolink" id="videolink">
                                </div>
                            </td>
                            <td > </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="kmBox16"><a data-dismiss="modal" class="btn" onclick="SaveMedia();">Save</a> </td>
                            <td class="kmBox17">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="kmBox16"> <label id="message" class="control-label" ></label> </td>
                            <td class="kmBox17">&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        function SaveMedia() {
            var formdata = new FormData();
            var ele = document.getElementById('DiseaseList');
            var DiseaseName = ele.options[ele.selectedIndex].value;
            var indicationName = $("#IndicationList option:selected").text();
            var videoLink = $('#videolink').val();
            //var videoLinkEncoded = encodeURIComponent(vedioLink);
            var fileInput = $('#file')[0];
            if (fileInput.files != null && fileInput.files.length > 0) {
                var fileStream = fileInput.files[0];
                formdata.append(fileInput.files[0].name, fileInput.files[0]);
            }
            var modelPath;
            var controllerUrl = "/DiseaseArea/SaveMedia?DiseaseName=" + DiseaseName + "&IndicationName=" + indicationName + "&VideoLink=" + videoLink;
            var xhr = new XMLHttpRequest();
            xhr.open('POST', controllerUrl);
            xhr.send(formdata);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    alert("Media details successfully saved.......");
                }
            }
            return false;
        }
    </script>
</asp:Content>
