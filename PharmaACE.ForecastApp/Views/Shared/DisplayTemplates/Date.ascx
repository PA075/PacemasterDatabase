<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.DateTime?>" %>

<%= Html.Encode(Model.HasValue ? Model.Value.ToString("MM/dd/yyyy") : string.Empty) %>