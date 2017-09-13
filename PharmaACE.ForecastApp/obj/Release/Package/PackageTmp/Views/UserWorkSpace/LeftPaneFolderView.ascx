<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<PharmaACE.ForecastApp.Models.UWObject>" %>
<ul>
   <%
      int j = 1;
      
      foreach (var folders in ViewBag.ContentFolderList)
      {
      
      if (folders.permString == "ContetFileShare")
      { %>
   <li id=<%=folders.ObjectId%> IsDefaultFolder="<%=folders.isDefaultFolder%>" permission="<%=folders.permission%>" lineageString="<%=folders.Lineage%>" sequence= <%=folders.Index%> >
      <span class="glyphicon glyphicon glyphicon-folder-close" id='<%="SpanFirst" + folders.ObjectId.ToString().Trim()%>' aria-hidden="true" title="Create New"></span>
      <%
         if (folders.FolderCounts==0)
         { 
         %>
      &nbsp;
      <span style="visibility:hidden" class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>','<%=folders.Index%>',false);" ></span>
      <% }
         else
         { %>
      <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>','<%=folders.Index%>',false);" ></span> 
      <% }
         %>
      <input type="checkbox" class="searchcheckbox" />
      <a title="<%=folders.Name %>" onclick="callEditableWorkSpaceJSON(<%=folders.ObjectId%>, '<%=folders.Lineage%>');"><%=folders.Index%> <%=folders.Name.Trim()%></a>
      <span class="badge" id='<%= "SpnFCount" + folders.ObjectId%>'><%=folders.FileCounts%></span>
   </li>
   <% }
      else
      { %>
   <li id=<%=folders.ObjectId%> IsDefaultFolder="<%=folders.isDefaultFolder%>" permission="<%=folders.permission%>" lineageString="<%=folders.Lineage%>" sequence= <%=folders.Index%> class="applycontextmenu">
      <span class="glyphicon glyphicon glyphicon-folder-close" id='<%="SpanFirst" + folders.ObjectId.ToString().Trim()%>' aria-hidden="true" title="Create New"></span>
      <%
         if (folders.FolderCounts==0)
         { 
         %>
      &nbsp;
      <span style="visibility:hidden" class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>','<%=folders.Index%>',false);" ></span>
      <% }
         else
         { %>
      <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>','<%=folders.Index%>',false);" ></span> 
      <% }
         %>
      <input type="checkbox" class="searchcheckbox" />
      <a title="<%=folders.Name %>" onclick="callEditableWorkSpaceJSON(<%=folders.ObjectId%>, '<%=folders.Lineage%>');"><%=folders.Index%> <%=folders.Name.Trim()%></a>
      <span class="badge" id='<%= "SpnFCount" + folders.ObjectId%>'><%=folders.FileCounts%></span>
   </li>
   <% }
      %> 
   <%
      j = j + 1;
      
      }%>
</ul>