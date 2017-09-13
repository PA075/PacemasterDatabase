<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<PharmaACE.ForecastApp.Models.UserInfo>>" %>


<%--<link type="text/css" href="../../Content/CSS/adminuserbootstrap.min.css" rel="stylesheet" />
<link type="text/css" href="../../Content/CSS/adminuseranimate.min.css" rel="stylesheet" />
<!-- Custom styling plus plugins -->
<link type="text/css" href="../../Content/CSS/adminusercustom.css" rel="stylesheet" />
<link type="text/css" href="../../Content/CSS/green.css" rel="stylesheet" />--%>
 <%: Styles.Render( "~/Content/AdminCSS")  %>

<link type="text/css" href="../../Content/CSS/adminuserfont-awesome.min.css" rel="stylesheet" />

   
<%--<script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js"></script>
<script type="text/javascript" src="../../Scripts/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
<script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
<!-- bootstrap progress js -->
<script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
<!-- icheck -->
<script src="../../Scripts/lib/jquery/icheck.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- daterangepicker -->
<script src="../../Scripts/lib/jquery/custom.js"></script>
<script src="../../Scripts/custom/bootbox.js"></script>
<script src="../../Scripts/lib/jquery/jquery.dataTables.js"></script>--%>
<%: Scripts.Render ( "~/Scripts/UserListScript") %>
<%--<div id="UserProfile" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">User Profile</h4>
            </div>
            <div class="modal-body">
                <form role="form" id="profileform">
                    <div class="modal-body">
                        <div class="" style="margin: 0px auto; float: none;">
                            <table class="table table-user-information" id="user_table" data-toggle="table" data-click-to-select="true">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>--%>
<style type="text/css">

    .text-left{text-align:left !important;}
body .container.body .right_col {
    background: #F3F3F3 ;
}
</style>
<table class="table table-user-information table-striped table-condensed" id="user_table11" data-toggle="table" data-click-to-select="true">
<tbody>
<tr class="headings" style="width: 20%" id="hiee">
    <th>
        <%: Html.DisplayNameFor(model => model.UserId) %>
    </th>
    <th class="text-left">
        <%: Html.DisplayNameFor(model => model.FirstName) %>
    </th>
    <th class="text-left">
        <%: Html.DisplayNameFor(model => model.LastName) %>
    </th>
    <th class="text-left">
        <%: Html.DisplayNameFor(model => model.Email) %>
    </th>
    <th>
        <%: Html.DisplayNameFor(model => model.IsAdmin) %>
    </th>
    <th>
        <%: Html.DisplayNameFor(model => model.IsActive) %>
    </th>
    <th></th>
</tr>
<% foreach (var item in Model)
   { %>
<tr>
    <td class="abcd">
        <%: Html.DisplayFor(modelItem => item.UserId) %>
    </td>
    <td class="text-left">
        <%: Html.DisplayFor(modelItem => item.FirstName) %>
    </td>
    <td class="text-left">
        <%: Html.DisplayFor(modelItem => item.LastName) %>
    </td>
    <td class="text-left">
        <%: Html.DisplayFor(modelItem => item.Email) %>
    </td>
    <td>
        <%: Html.DisplayFor(modelItem => item.IsAdmin) %>
    </td>
    <td>
        <%: Html.DisplayFor(modelItem => item.IsActive) %>
    </td>
    <td>
        <a id="profile" href="javascript:addRowHandlers(<%: Html.DisplayFor(modelItem => item.UserId) %>)" class="btn  btn-md"><i class="fa fa-folder" title="My Profile"></i> </a>
        <a href="javascript:addRowHandlersforedit(<%: Html.DisplayFor(modelItem => item.UserId) %>);" class="btn  btn-md"><i class="fa fa-pencil" title="Edit Profile"></i> </a>
        <a href="javascript:DeleteUserById(<%: Html.DisplayFor(modelItem => item.UserId) %>);" class="btn  btn-md"><i class="fa fa-trash-o" title="Delete User"></i> </a>
    </td>
</tr>
<% } %>
   </tbody>
</table>
<script type="text/javascript">
</script>
