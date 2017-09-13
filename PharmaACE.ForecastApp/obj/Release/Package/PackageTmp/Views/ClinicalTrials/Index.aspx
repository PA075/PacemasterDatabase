<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Clinical Trials
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="contentbox">
        <div class="row" style="width: 100%;">
            <iframe src="https://www.clinicalTrials.gov" style="width: 100%; height: auto; min-height: 800px;" id="iframe"></iframe>
           <%-- <iframe src=" https://clinicaltrials.gov/ct2/show/"+<%: ViewData["NCT"].ToString()%>+""  style="width: 100%; height: auto; min-height: 800px;" id="iframe"></iframe>--%>
            <%--testing by nilesh--%>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>