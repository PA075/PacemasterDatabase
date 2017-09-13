<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<% ViewBag.Title = "file";   %>
<table>
    <tr>
        <td>Select Image <% using (Html.BeginForm ("file", "upload",  FormMethod.Post,new { enctype = "multipart/form-data" }))  %>
            <input type="file" name="file" id="file"  runat=server/>
            </td>
    </tr>
    <tr>
    </tr>
</table>
<br>
<br>
