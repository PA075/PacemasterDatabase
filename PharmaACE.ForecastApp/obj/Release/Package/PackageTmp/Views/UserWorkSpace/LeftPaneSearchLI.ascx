<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<ul>
   <%foreach (var folders in ViewBag.ContentFolderList)
      {  %>
   <li id=<%=folders.ObjectId%>>
      <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderView(<%=folders.ObjectId%>,<%=folders.Lineage%>,0)" ></span>
      <a href="#"><%=folders.Name.Trim()%></a>
   </li>
   <%}%>
</ul>