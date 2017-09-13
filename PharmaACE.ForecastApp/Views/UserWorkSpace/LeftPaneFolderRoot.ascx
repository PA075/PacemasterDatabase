<%--<link href="../../Content/CSS/userworkspace.css" rel="stylesheet" />--%>
<style type="text/css">
   #treeforAdvSearch .leftBox:last-child{margin-top:6px !important;}
</style>
<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%
   int i = 1;
   
   
   %>
<%foreach (var folders in ViewBag.rootFolder)
   {
   if (folders.permString == "ContetFileShare")
   { %>
<li id=<%=folders.ObjectId%> permission="<%=folders.permission%>" lineageString="<%=folders.Lineage%>" sequence="<%=i%>" class="firstLi uwDiv38">
   <%--<span class="glyphicon-folder-open" id='<%="Span2" + folders.Id.ToString().Trim()%>'></span>--%>
   <span class="glyphicon glyphicon glyphicon-folder-close" id='<%="SpanFirst" + folders.ObjectId.ToString().Trim()%>' aria-hidden="true" title="Create New"></span>
   <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>',<%=i%>,true);" aria-hidden="true" title="Show"></span><a href="#" title="<%=folders.Name.Trim()%>" onclick="callEditableWorkSpaceJSON(<%=folders.ObjectId%>, ' ' + '<%=folders.Lineage%>');"><%=i%> <%=folders.Name.Trim()%></a>
   <span class="badge" id='<%= "SpnFCount" + folders.ObjectId%>'><%=folders.FileCounts%></span>
   <span id="editProductIcon">
   <a title="Edit Project" id="editproject" href="#" data-toggle="modal" onclick="setPopuptitle(<%=folders.ObjectId%>);" data-target='#addnewproduct'><i class="fa fa-edit uwDiv39"></i></a></span>
</li>
<% }
   else
   { %>
<li  id=<%=folders.ObjectId%> permission="<%=folders.permission%>" lineageString="<%=folders.Lineage%>" sequence="<%=i%>" class="firstLi applycontextmenu uwDiv38">
   <%--<span class="glyphicon-folder-open" id='<%="Span2" + folders.Id.ToString().Trim()%>'></span>--%>
   <span class="glyphicon glyphicon glyphicon-folder-close" id='<%="SpanFirst" + folders.ObjectId.ToString().Trim()%>' aria-hidden="true" title="Create New"></span>
   <span class="fa fa-chevron-down" id='<%="Span" + folders.ObjectId.ToString().Trim()%>' onclick="callLeftPaneFolderViewWithIndex(<%=folders.ObjectId%>,'<%=folders.Lineage%>',<%=i%>,true);" aria-hidden="true" title="Show"></span><a href="#" title="<%=folders.Name.Trim()%>" onclick="callEditableWorkSpaceJSON(<%=folders.ObjectId%>, ' ' + '<%=folders.Lineage%>');"><%=i%> <%=folders.Name.Trim()%></a>
   <span class="badge" id='<%= "SpnFCount" + folders.ObjectId%>'><%=folders.FileCounts%></span>
   <span  id="editProductIcon">
   <a title="Edit Project" id="editproject" href="#" data-toggle="modal" onclick="setPopuptitle(<%=folders.ObjectId%>);" data-target='#addnewproduct'><i class="fa fa-edit" style="font-size:16px;cursor: pointer;padding-left:7px;display:block;"></i></a></span>
</li>
<% }
   %>
<%
   i = i + 1;
   
   }%>