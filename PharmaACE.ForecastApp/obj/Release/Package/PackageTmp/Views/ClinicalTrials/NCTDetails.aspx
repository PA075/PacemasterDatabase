<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/KMSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Clinical Trials
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="contentbox">
        <div class="row" style="width: 100%;">
            <%if (ViewData["NCT"] != null && ViewData["NCT"].ToString() != "")
                { %>
            <iframe src="https://clinicaltrials.gov/ct2/show/<%: ViewData["NCT"].ToString()%>" style="width: 100%; height: auto; min-height: 800px;" id="iframe"></iframe>
            <%}
            else
            { %>
            <iframe src="http://www.clinicalTrials.gov" style="width: 100%; height: auto; min-height: 800px;" id="iframe"></iframe>
            <%} %>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
   
</asp:Content>