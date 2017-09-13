<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Login
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2>Login</h2>
    <a href="#" class="button"  onclick="Redirect();">Continue</a>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script>
        function Redirect() {
            var baseURL = window.location.protocol + "//" + window.location.host;
            window.location.href = baseURL + "/Home/Index";
        }
    </script>
</asp:Content>
