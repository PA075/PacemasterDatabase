<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%--<link href="../../Content/CSS/NewsFeedStatic.css" rel="stylesheet" />--%>
<link href="../../Content/CSS/NewsFeed.css" rel="stylesheet" />
<div>
    <%: Html.Raw(ViewBag.Mydata) %>                                        
</div>