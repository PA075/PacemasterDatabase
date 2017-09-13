<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Web.Mvc.HandleErrorInfo>" %>
<asp:Content ID="errorTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Error - PharmaACE KM 
</asp:Content>
<asp:Content ID="errorContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
    <hgroup class="title">
        <h1 class="error">Error.</h1>
        <h2 class="error">&nbsp; An error occurred while processing your request.</h2>
    </hgroup>
        <br />
        <br />
        </div>
    <style>
  #customBox  {height: 540px;}
  body{margin:0px; overflow-x: hidden;}
  #footer{height:30px;}
  #hmpage{text-align:center !important;margin-left:0px !important;}
        @media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
            #customBox  {height: 551px;}
        }

    </style>
    <script>
        $(function () {

            $("#top-link-block").css("display", "none");
        });
       
        
    </script>
</asp:Content>
