<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.LinkDetail>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    InvalidLink
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <%if (Model.errorcode ==1)                                
    { %>
<h2> Reset password link has expired.It was for one time use only</h2>
     <% }
       else
      { %>
    <h2> Reset password link is invalid</h2>

    <% }  %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
