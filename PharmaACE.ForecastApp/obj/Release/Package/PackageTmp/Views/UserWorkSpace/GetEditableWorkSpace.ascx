<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<table id="userworkspaceTable" class="table table-striped select" cellspacing="0" width="100%">
   <thead>
      <tr>
         <th><input type="checkbox" name="select_all" value="1" id="example-select-all"></th>
         <th>Index</th>
         <th>Name</th>
         <th>Size</th>
         <th>Type</th>
         <th>Created Date</th>
         <th>Last modified</th>
         <th>Shared with</th>
      </tr>
   </thead>
   <tbody>
      <%int i = 1; %>
      <%foreach (var ContentFolder in ViewBag.ContentFolderList){ %>
      <tr>
         <td>
            1.<%=i%>
         </td>
         <td><%=ContentFolder.Name%></td>
         <td><%=ContentFolder.creationDate%></td>
         <td><%=ContentFolder.Size%></td>
         
         <td>
            <%=ContentFolder.Type%> 
         </td>
         
         <td><%=ContentFolder.Moddate%></td>
         <td><%=ContentFolder.permission%>
           
            <%i = i + 1; %>
      </tr>
      <% }
         %>
   </tbody>
</table>