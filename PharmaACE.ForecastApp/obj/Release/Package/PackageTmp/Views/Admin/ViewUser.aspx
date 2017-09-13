<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>Admin</title>
  <!-- Bootstrap core CSS -->
<%-- <link type="text/css" href="../../Content/CSS/adminuserbootstrap.min.css" rel="stylesheet" />
  <link type="text/css" href="../../Content/CSS/adminuseranimate.min.css" rel="stylesheet" />
  <!-- Custom styling plus plugins -->
  <link type="text/css" href="../../Content/CSS/adminusercustom.css" rel="stylesheet" />
  <link type="text/css" href="../../Content/CSS/green.css" rel="stylesheet" />--%>
 <%: Styles.Render( "~/Content/AdminCSS")  %>
<link  type="text/css" href="../../Content/CSS/adminuserfont-awesome.min.css" rel="stylesheet" />
<%--<script type="text/javascript" src="../../Scripts/lib/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js"></script>  
  <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
  <script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
  <!-- bootstrap progress js -->
<script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
  <!-- icheck -->
 <script src="../../Scripts/lib/jquery/icheck.min.js"></script>
  <!-- daterangepicker -->
 <script src="../../Scripts/lib/jquery/custom.js"></script>
 <script src="../../Scripts/custom/bootbox.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>--%>
  <%: Scripts.Render ( "~/Scripts/ViewUserScript") %>
<script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
<%Html.RenderPartial("_Notification"); %>
<body class="nav-md">
<div id="popalert" class="alert-info" style="display: none; margin-bottom:0px !important;padding-top:0px;"><span class="close" data-dismiss="alert">&times;</span><p style="text-align: center"></p></div>

<div class="header navbar navbar-inverse ">
<div class="navbar-inner">
<div class="header-seperation">
<div class="navbar nav_title" style="border: 0;">
            <a href="<%=Url.Action("Index", "Home")%>" class="site_title"><img src="../../Content/img/logos.png"/></a>
          </div>
</div>
<div class="header-quick-nav">
	 <div class="">
          <nav class="" role="navigation">
		  <div class="pull-left">
            <div class="nav toggle">
              <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>
		</div>
<div class="pull-right">
                 <%Html.RenderPartial("ProfileLogoForAdmin"); %> 
        </div> 
		 </nav>
        </div>

</div>
</div>
</div>
  <div class="container body">
    <div class="main_container page-content">
      <div class="left_col page-sidebar ">
        <div class="left_col scroll-view">
          <div class="clearfix"></div>
<div class="user-info-wrapper">
<div class="profile-wrapper"> <img width="69" height="69" data-src-retina="../../Content/img/AdminUser/user.png" data-src="../../Content/img/AdminUser/user.png" alt="" src="../../Content/img/AdminUser/user.png"/> </div>
<div class="user-info">
<div class="greeting">Welcome</div>
<div class="username"> <%:Session["FirstName"].ToString()%></div>
<div class="status">Administrator</div>
</div>
</div>
          <br />
          <!-- sidebar menu -->
          <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
            <div class="menu_section">
              <ul class="nav side-menu">
                <li><a href="../home/index"><i class="fa fa-home" title=""></i> Home</a>
                </li>
                </ul>
            </div>
            <div class="menu_section">
                <ul class="nav side-menu">
                    <li><a><i class="fa fa-user"></i>Manage Users <span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" style="display: none">
                            <li><a href="../Admin/ViewUser">View Users</a>
                            </li>
                            <li><a href="../Admin/SignUpAdminUser">Add New User</a>
                            </li>
                            <%if (Session["RoleId"].ToString() == "3")
                              {%>
                            <li><a href="../Admin/ViewSubscribers">View Subscribers</a></li>
                            <li><a href="../Admin/SubscriberRegistration">Subscriber Registration</a></li>
                            <%} %>
                        </ul>
                    </li>
                </ul>
            </div>
          </div>
          <!-- /sidebar menu -->
        </div>
      </div>
      <!-- top navigation -->
      <div class="top_nav">
      </div>
      <!-- /top navigation -->
      <!-- page content -->
      <div class="right_col content sm-gutter" role="main">
       <div class="x_content">
                  <!-- start project list -->
                  <table class="table table-user-information" id="user_table1" data-toggle="table" data-click-to-select="true">
                    <thead>
                        <tr>
                            <td><%if (Session["RoleId"].ToString() == "3")
                                  {%>
                                <% Html.RenderAction("Index", "SubscriberList"); %>
                                <%} %></td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                  </table>
                  <!-- end project list -->
                </div>
          <div id="UserListDiv">
          </div>
        </div>
        <div id="ViewUserProfile" class="modal" tabindex="-1">
    <div class="modal-dialog" style="width:480px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">User Profile</h4>
            </div>
                <form role="form" id="profileform1">
                  <div class="modal-body">
                <div style="margin: 0px auto; float: none;">
                    <table class="table table-user-information" id="viewuser_table" data-toggle="table" data-click-to-select="true">
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
                </form>
        </div>
    </div>
</div>
        <form role="form" id="form2" method="post">
    <div id="UserProfileEdit" class="modal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Edit Profile</h4>
                </div>
                    <div class="modal-body">
                        <div class="  " style="margin: 0px auto; float: none;">
                            <table class="table table-user-information table-striped" id="user_tableedit" data-toggle="table" data-click-to-select="true" style="width:100%;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <div class="modal-footer">
                    <button id="btnShowPermissionModel" type="button" class="btn btn-default pull-left"  style="display:inline; margin-right:10px;" onclick="viewpermissionmodel();">Edit Permissions</button>
                    <button type="button" class="btn btn-default" onclick="addRowHandlersForSave();">Save</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</form>
        <footer id="footer">
          <div class="copyright-info">
            <p class="pull-right">
© 2016 <a href="https://pacehomepage.com " target="_blank">PharmaACE</a>. All Rights Reserved. 
            </p>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
      </div>
      <!-- /page content -->
    </div>
  <%--</div>--%>
  <div id="custom_notifications" class="custom-notifications dsp_none">
    <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
    </ul>
    <div class="clearfix"></div>
    <div id="notif-group" class="tabbed_notifications"></div>
  </div>
    <!-- myprofile and change password content -->
   <div id="UserProfile" class="modal" tabindex="-1">
    <div class="modal-dialog" style="width:480px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">User Profile</h4>
            </div>
                <form role="form" id="profileform">
                  <div class="modal-body">
                <div style="margin: 0px auto; float: none;">
                    <table class="table table-user-information" id="user_table" data-toggle="table" data-click-to-select="true">
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
                </form>
            <div class="modal-footer">
                <button id="btnEdit" type="button" class="btn btn-primary"  onclick="EditProfile();" style="display:none; float:right;">Edit</button>
                <button id="btnSave" type="button" class="btn btn-primary"  onclick="SaveProfile();" style="display:none; float:right; margin-right:10px;">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="modal" id="edit1" tabindex="-1" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>--%>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title custom_align" id="Heading">Change Password</h4>
            </div>
            <form class="form" role="form" id="updatepasswordid" name="form1">
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="control-label">Current Password:</label>
                            </div>
                            <div class="col-md-8">
                                <input class="form-control " placeholder="Current Password:" type="password" id="CurrentPassword" title="" required  />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="control-label">New Password:</label>
                            </div>
                            <div class="col-md-8">
                                <input class="form-control ,required " placeholder="New Password:" type="password" id="NewPassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,15})" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="control-label">Confirm Password:</label>
                            </div>
                            <div class="col-md-8">
                                <input class="form-control " placeholder="Confirmed Password:" type="password" id="ConfirmedPassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,15})" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer ">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <input type="submit" class="btn btn-primary" style="float: right;" value="Update" />
                </div>
            </form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
     <style>
        .modelLable{
            width:200px;
        }
        .accessTypeLable{
            width:70px;
        }
    </style>
 <!-- /.modal dialog for User Permission Start -->
     <div id="EditPermission" class="modal" tabindex="-1">
        <div class="modal-dialog" style="width: 480px;">
            <div class="modal-content">
                <div class="modal-header" style="text-align:center">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Edit User Permission</h4>
                </div>
                <form role="form" id="Permissitionform">
                    <div class="modal-body">
                        <div style="margin: 0 auto; display:inline-table; ">
                            <div id="page-wrap">

                               <table class="table table-striped" style="width: 100%;">
                                   
                                    <tbody>
                                        <tr class="KMDiv" id="KMDiv">
                                            <td>
                                                <input type="checkbox" name="KnowledgeManagement" value="KnowledgeManagement"><label class="modelLable">KnowledgeManagement</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeKM" value="1" id="KM1"><label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeKM" value="2" id="KM2"><label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeKM" value="3" id="KM3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="BIDiv">
                                            <td>
                                                <input type="checkbox" name="BusinessIntelligence" value="BusinessIntelligence"><label class="modelLable">Business Intelligence</label></td>

                                            <td>
                                                <input type="radio" name="AccessTypeBI" value="1" id="BI1"><label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeBI" value="2" id="BI2"><label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeBI" value="3" id="BI3"><label>Read Only </label>
                                            </td>


                                        </tr>
                                        <tr class="UTDiv">

                                            <td>
                                                <input type="checkbox" name="Utilities" value="Utilities"><label class="modelLable">Utilities</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeUT" value="1" id="UT1">
                                                <label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeUT" value="2" id="UT2">
                                                <label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeUT" value="3" id="UT3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="CFDiv">
                                            <td>
                                                <input type="checkbox" name="CustomFeed" value="CustomFeed"><label class="modelLable">CustomFeed</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeCF" value="1" id="CF1">
                                                <label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeCF" value="2" id="CF2">
                                                <label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeCF" value="3" id="CF3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="CPDiv">
                                            <td>
                                                <input type="checkbox" name="CommunityOfPractice" value="CommunityOfPractice"><label class="modelLable">CommunityOfPractice</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeCP" value="1" id="CP1">
                                                <label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeCP" value="2" id="CP2">
                                                <label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeCP" value="3" id="CP3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="UWDiv">
                                            <td>
                                                <input type="checkbox" name="UserWorkspace" value="UserWorkspace"><label class="modelLable">UserWorkspace</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeUW" value="1" id="UW1"><label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeUW" value="2" id="UW2"><label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeUW" value="3" id="UW3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="HDDiv">
                                            <td>
                                                <input type="checkbox" name="HelpDesk" value="HelpDesk"><label class="modelLable">HelpDesk</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeHD" value="1" id="HD1">
                                                <label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeHD" value="2" id="HD2">
                                                <label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeHD" value="3" id="HD3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="FCDiv">
                                            <td colspan="4">
                                                <input type="checkbox" name="ForecastPlatform" value="ForecastPlatform"><label class="modelLable">ForecastPlatform</label></td>
                                        </tr>
                                        <tr class="FCGen" >

                                            <td>
                                                <input type="checkbox" name="GenericTool" value="GenericTool"><label class="modelLable">GenericTool</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeGT" value="1" id="GT1"><label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeGT" value="2" id="GT2"><label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeGT" value="3" id="GT3"><label>Read Only </label>
                                            </td>
                                           <%-- <script>
                                                var AccessTypeGT = 1;
                                                $('FCGen').find("input[value=" + AccessTypeGT + "]").prop('checked', false);
                                            </script>--%>

                                        </tr>
                                        <tr class="FCGen">
                                        <td>
                                                <label class="modelLable">AccessAllProjects</label></td>
                                           
                                                <td>
                                                <input type="radio" name="AccessTypeGTforproject" value="1" id="GT4"><label>Yes</label></td>
                                           
                                                <td>
                                                <input type="radio" name="AccessTypeGTforproject" value="0" id="GT5"><label>No</label></td>
                                            
                                                </tr>
                                        <tr class="FCBDL">
                                            <td>
                                                <input type="checkbox" name="BDLTool" value="BDLTool"><label class="modelLable">BDLTool</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeBDL" value="1" id="BDL1"><label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypeBDL" value="2" id="BDL2"><label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypeBDL" value="3" id="BDL3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="FCBDL">
                                            <td>
                                                <label class="modelLable">AccessAllProjects</label></td>
                                           
                                                <td>
                                                <input type="radio" name="AccessTypeBDLforproject" value="1" id="BDL4"><label>Yes</label></td>
                                           
                                                <td>
                                                <input type="radio" name="AccessTypeBDLforproject" value="0" id="BDL5"><label>No</label></td>
                                            
                                                </tr>
                                        <tr class="FCPF">
                                            <td>
                                                <input type="checkbox" name="PatientFlow" value="PatientFlow"><label class="modelLable">PatientFlow</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypePF" value="1" id="PF1"><label>Complete</label></td>
                                            <td>
                                                <input type="radio" name="AccessTypePF" value="2" id="PF2"><label>Edit </label>
                                            </td>
                                            <td>
                                                <input type="radio" name="AccessTypePF" value="3" id="PF3"><label>Read Only </label>
                                            </td>
                                        </tr>
                                        <tr class="FCPF">
                                        <td>
                                               <label class="modelLable">AccessAllProjects</label></td>
                                           
                                                <td>
                                                <input type="radio" name="AccessTypePFforproject" value="1" id="PF4"><label>Yes</label></td>
                                           
                                                <td>
                                                <input type="radio" name="AccessTypePFforproject" value="0" id="PF5"><label>No</label></td>
                                            
                                                </tr>

                                    </tbody>
                                </table>


                               <%-- <div class="KMDiv" id="KMDiv">

                                <input type="checkbox" name="KnowledgeManagement" value="KnowledgeManagement"><label class="modelLable">KnowledgeManagement</label>
                                     <input type="radio" name="AccessTypeKM" value="1" id="KM1" ><label>Complete</label>
                                    <input type="radio" name="AccessTypeKM" value="2" id="KM2" ><label>Edit </label>
                                    <input type="radio" name="AccessTypeKM" value="3" id="KM3"><label>Read Only </label>

                                </div>
                                <div class="BIDiv">
                                    
                                    <input type="checkbox" name="BusinessIntelligence" value="BusinessIntelligence"><label class="modelLable">Business Intelligence</label>
                                   
                                    <input type="radio" name="AccessTypeBI" value="1" id="BI1"  ><label>Complete</label>
                                    <input type="radio" name="AccessTypeBI" value="2" id="BI2"  ><label>Edit </label>
                                    <input type="radio" name="AccessTypeBI" value="3" id="BI3" ><label>Read Only </label>
                                  
                                </div>

                                 <div class="UTDiv">
                                    <input type="checkbox" name="Utilities" value="Utilities"  ><label class="modelLable">Utilities</label>
                                    <input type="radio" name="AccessTypeUT" value="1" id="UT1" >
                                    <label>Complete</label>
                                    <input type="radio" name="AccessTypeUT" value="2" id="UT2">
                                    <label>Edit </label>
                                    <input type="radio" name="AccessTypeUT" value="3" id="UT3" ><label>Read Only </label>
                                </div>
                                <div class="CFDiv">
                                    <input type="checkbox" name="CustomFeed" value="CustomFeed"><label class="modelLable">CustomFeed</label>
                                    <input type="radio" name="AccessTypeCF" value="1" id="CF1" >
                                    <label>Complete</label>
                                    <input type="radio" name="AccessTypeCF" value="2" id="CF2" >
                                    <label>Edit </label>
                                    <input type="radio" name="AccessTypeCF" value="3" id="CF3"><label>Read Only </label>
                                </div>
                                <div class="CPDiv">
                                    <input type="checkbox" name="CommunityOfPractice" value="CommunityOfPractice" ><label class="modelLable">CommunityOfPractice</label>
                                    <input type="radio" name="AccessTypeCP" value="1" id="CP1" >
                                    <label>Complete</label>
                                    <input type="radio" name="AccessTypeCP" value="2" id="CP2" >
                                    <label>Edit </label>
                                    <input type="radio" name="AccessTypeCP" value="3" id="CP3"><label>Read Only </label>
                                </div>
                                 <div class="UWDiv">
                                    <input type="checkbox" name="UserWorkspace" value="UserWorkspace" ><label class="modelLable">UserWorkspace</label>
                                    <input type="radio" name="AccessTypeUW" value="1" id="UW1" ><label>Complete</label>
                                    <input type="radio" name="AccessTypeUW" value="2" id="UW2" ><label>Edit </label>
                                    <input type="radio" name="AccessTypeUW" value="3" id="UW3"><label>Read Only </label>
                                </div>
                                <div class="HDDiv">
                                    <input type="checkbox" name="HelpDesk" value="HelpDesk" ><label class="modelLable">HelpDesk</label>
                                    <input type="radio" name="AccessTypeHD" value="1" id="HD1" >
                                    <label>Complete</label>
                                    <input type="radio" name="AccessTypeHD" value="2" id="HD2">
                                    <label>Edit </label>
                                    <input type="radio" name="AccessTypeHD" value="3" id="HD3" ><label>Read Only </label>
                                </div>
                                <div class="FCDiv">
                                    <input type="checkbox" name="ForecastPlatform" value="ForecastPlatform" ><label class="modelLable">ForecastPlatform</label>
                                    <div class="FCGen">
                                        <input type="checkbox" name="GenericTool" value="GenericTool" ><label class="modelLable">GenericTool</label>
                                        <input type="radio" name="AccessTypeGT" value="1" id="GT1" ><label>Complete</label>
                                        <input type="radio" name="AccessTypeGT" value="2" id="GT2" ><label>Edit </label>
                                        <input type="radio" name="AccessTypeGT" value="3" id="GT3" ><label>Read Only </label>
                                      <script>
                                          var AccessTypeGT = 1;
                                          $('FCGen').find("input[value=" + AccessTypeGT + "]").prop('checked', false);
                                    </script>
                                        
                                         </div>
                                    <div class="FCBDL">
                                        <input type="checkbox" name="BDLTool" value="BDLTool" ><label class="modelLable">BDLTool</label>
                                        <input type="radio" name="AccessTypeBDL" value="1" id="BDL1" ><label>Complete</label>
                                        <input type="radio" name="AccessTypeBDL" value="2" id="BDL2" ><label>Edit </label>
                                        <input type="radio" name="AccessTypeBDL" value="3" id="BDL3" ><label>Read Only </label>
                                    </div>
                                     <div class="FCPF">
                                        <input type="checkbox" name="PatientFlow" value="PatientFlow" ><label class="modelLable">PatientFlow</label>
                                        <input type="radio" name="AccessTypePF" value="1" id="PF1" ><label>Complete</label>
                                        <input type="radio" name="AccessTypePF" value="2" id="PF2" ><label>Edit </label>
                                        <input type="radio" name="AccessTypePF" value="3" id="PF3" ><label>Read Only </label>
                                    </div>
                                </div>--%>

                            </div>
                        </div>
                    </div>
                     <div class="modal-footer">
                    <button id="btnSetPermission" type="button" class="btn btn-primary" onclick="SetUserPermission();" style="display: inline; float: right; margin-right: 10px;">Set User Permission</button>
                </div>
                </form>
               
            </div>
        </div>
    </div>
     <!-- /.modal dialog for User Permission End -->
  <script>

      // var selectedvalues = {};
      var permission = {
          KnowledgeManagement: false, AccessTypeKM: "", BusinessIntelligence: false, AccessTypeBI: "", Utilities: false, AccessTypeUT: "",
          CustomFeed: false, AccessTypeCF: "", CommunityOfPractice: false, AccessTypeCP: "", UserWorkspace: false, AccessTypeUW: "", HelpDesk: false,
          AccessTypeHD: "", ForecastPlatform: false, AccessTypeFP: "", GenericTool: false, AccessTypeGT: "",AccessTypeGTforproject:"", BDLTool: false, AccessTypeBDL: "",AccessTypeBDLforproject : "",
          PatientFlow: false, AccessTypePF: "" , AccessTypePFforproject : ""
      };
      var UserDetails = { firstName: "", lastName: "", email: "", isadmin: "", roleId: "", SubscriberId: "", permission: "" };
     
      var EditUserDetails = { id: "", status: "", admin: "", permission: "" ,roleId :""};
       var currentPermissions = {};
      function SetUserPermission() {
          permission = {};
          var allmodelcheckbox = $("#page-wrap > table>tbody>tr").find("input[type='checkbox']")
          for (var i = 0; i < allmodelcheckbox.length; i++) {
              var modelchek = allmodelcheckbox[i];
              //alert(modelchek.value + ' ' + modelchek.checked);
              if (modelchek.checked) {
                  if (modelchek.value == "KnowledgeManagement") {
                      permission.KnowledgeManagement = true;
                      permission.AccessTypeKM = $("input:radio[name='AccessTypeKM']:checked").val();
                  }
                  else if (modelchek.value == "BusinessIntelligence") {
                      permission.BusinessIntelligence = true;
                      permission.AccessTypeBI = $("input:radio[name='AccessTypeBI']:checked").val();
                  }
                  else if (modelchek.value == "CommunityOfPractice") {
                      permission.CommunityOfPractice = true;
                      permission.AccessTypeCP = $("input:radio[name='AccessTypeCP']:checked").val();
                  }
                  else if (modelchek.value == "CustomFeed") {
                      permission.CustomFeed = true;
                      permission.AccessTypeCF = $("input:radio[name='AccessTypeCF']:checked").val();
                  }
                  else if (modelchek.value == "Utilities") {
                      permission.Utilities = true;
                      permission.AccessTypeUT = $("input:radio[name='AccessTypeUT']:checked").val();
                  }
                  else if (modelchek.value == "UserWorkspace") {
                      permission.UserWorkspace = true;
                      permission.AccessTypeUW = $("input:radio[name='AccessTypeUW']:checked").val();
                  }
                  else if (modelchek.value == "HelpDesk") {
                      permission.HelpDesk = true;
                      permission.AccessTypeHD = $("input:radio[name='AccessTypeHD']:checked").val();
                  }
                  else if (modelchek.value == "GenericTool") {
                      permission.GenericTool = true;
                      permission.AccessTypeGT = $("input:radio[name='AccessTypeGT']:checked").val();
                      permission.ForecastPlatform = true;
                      permission.AccessTypeGTforproject = $("input:radio[name='AccessTypeGTforproject']:checked").val();
                  }
                  else if (modelchek.value == "BDLTool") {
                      permission.BDLTool = true;
                      permission.AccessTypeBDL = $("input:radio[name='AccessTypeBDL']:checked").val();
                      permission.ForecastPlatform = true;
                      permission.AccessTypeBDLforproject = $("input:radio[name='AccessTypeBDLforproject']:checked").val();
                  }
                  else if (modelchek.value == "PatientFlow") {
                      permission.PatientFlow = true;
                      permission.AccessTypePF = $("input:radio[name='AccessTypePF']:checked").val();
                      permission.ForecastPlatform = true;
                      permission.AccessTypePFforproject = $("input:radio[name='AccessTypePFforproject']:checked").val();
                  }
              }
          }
          $("#EditPermission").modal('hide');
      }

      function addRowHandlers(id) {
          PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/GetUserInformationByUserId", { id: id },
          function (result) {
              if (result.success) {
                  var tableRef = document.getElementById('viewuser_table').getElementsByTagName('tbody')[0];
                  var str = '';
                  str += '<tr data-index="0" class="">';
                  str += '<td class="Lable" >FirstName:</td>';
                  str += '<td id="fname"> ' + result.userInfo.userInfo.FirstName + ' </td></tr>';
                  str += '<tr data-index="0" class="">';
                  str += '<td class="Lable">LastName:</td>';
                  str += '<td id="lname"> ' + result.userInfo.userInfo.LastName + '</td></tr>';
                  str += '<tr data-index="0" class="">';
                  str += '<td class="Lable">Email:</td>';
                  str += '<td id="emailid" style = ""> ' + result.userInfo.userInfo.Email + '</td></tr>';
                  str += '<tr data-index="0" class="Lable">';
                  str += '<td class="Lable" >Status:</td>';
                  str += '<td id="isstatus"> ' + "<input type='checkbox' placeholder='{0}' disabled/>".replace(result.userInfo.userInfo.IsActive) + ' </td></tr>';
                  str += '<tr data-index="0" class="Lable">';
                  str += '<td class="Lable" >Admin:</td>';
                  str += '<td id="isadmin"> ' + "<input type='checkbox' placeholder='{0}' disabled/>".replace(result.userInfo.userInfo.IsAdmin); + ' </td></tr>';
                  str += '<tr data-index="0" class="">';
                  tableRef.innerHTML = str;
                  $('#isstatus>input').attr('checked', result.userInfo.userInfo.IsActive);
                  $('#isadmin>input').attr('checked', result.userInfo.userInfo.IsAdmin);
                  $('#ViewUserProfile').modal('show');
                  $('.modal-backdrop').css("display", "none");
              }
              else {
                  PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
              }
          },
          function (result) {
              PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
          });
      }
      function addRowHandlersforedit(id) {
          PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/GetUserInformationByUserId", { id: id },
           function (result) {
               if (result.success) {
                   var tableRef = document.getElementById('user_tableedit').getElementsByTagName('tbody')[0];
                   var str = '';

                   str += '<td id="roleId"> ' + "<input type='hidden' placeholder='{0}' name='roleId' />".replace('{0}', $.trim((result.userInfo.userInfo.RoleId))) + '</td></tr>';
                   str += '<tr data-index="0" class="">';
                   str += '<td class="Lable"  >UserId:</td>';
                   str += '<td id="userid"> ' + result.userInfo.userInfo.UserId + ' </td></tr>';
                   str += '<tr data-index="0" class="">';
                   str += '<td class="Lable" >FirstName:</td>';
                   str += '<td id="fname1"> ' + result.userInfo.userInfo.FirstName + ' </td></tr>';
                   str += '<tr data-index="0" class="">';
                   str += '<td class="Lable">LastName:</td>';
                   str += '<td id="lname1"> ' + result.userInfo.userInfo.LastName + '</td></tr>';
                   str += '<tr data-index="0" class="">';
                   str += '<td class="Lable">Email:</td>';
                   str += '<td id="emailid1" style = ""> ' + result.userInfo.userInfo.Email + '</td></tr>';
                   str += '<tr data-index="0" class="">';
                   //str += '<td class="Lable">Admin:</td>';
                   //str += '<td id="isadmin1"> ' + "<input type='checkbox' placeholder='{0}' name='isadmin1' />".replace('{0}', $.trim((result.userInfo.userInfo.IsAdmin))) + '</td></tr>';
                   str += '<tr data-index="0" class="">';
                   str += '<td class="Lable">Active:</td>';
                   str += '<td id="isstatus1"> ' + "<input type='checkbox' placeholder='{0}' name='isstatus1' />".replace('{0}', $.trim((result.userInfo.userInfo.IsActive))) + '</td></tr>';
                   tableRef.innerHTML = str;
                   if(result.userInfo.userInfo.IsAdmin)
                       $("input[name='isadmin1']").prop('checked', result.userInfo.userInfo.IsAdmin);
                   if (result.userInfo.userInfo.IsActive)
                       $("input[name='isstatus1']").prop('checked', result.userInfo.userInfo.IsActive);
                   $('#fname1>input').val($.trim($('#fname1>input').attr('placeholder')));
                   $('#lname1>input').val($.trim($('#lname1>input').attr('placeholder')));
                   $('#isstatus1>input').val($.trim($('#isstatus1>input').attr('checked', result.userInfo.IsActive)));
                   $('#isadmin1>input').val($.trim($('#isadmin1>input').attr('checked', result.userInfo.IsAdmin)));
                   $('#UserProfileEdit').modal('show');
                   $('.modal-backdrop').css("display", "none");
                   currentPermissions = result.userInfo.userPermission;
               }
               else {
                   PHARMAACE.FORECASTAPP.UTILITY.popalert("failed");
               }
           },
       function (result) {
           PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
       });
      }
      function addRowHandlersForSave() {
          var id = $('#userid').text();
          var isstatus = $('#isstatus1>input').is(':checked');
          var status = isstatus ? 1 : 0;
          //var isadmin = $('#isadmin1>input').is(':checked');
          //var admin = isadmin ? 1 : 0;
          var roleId = $('#roleId>input').attr('placeholder');
          
          EditUserDetails.id = id;
          EditUserDetails.status = status;
          //EditUserDetails.admin = admin;
          EditUserDetails.permission = permission;
          EditUserDetails.roleId = roleId;
          var postData = JSON.stringify(EditUserDetails);

          PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Admin/UpdateUserProfileByUserId", postData,
                      function (result) {
                          if (result.success) {
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Profile Updated Successfully");
                              $('#UserProfileEdit').modal('hide');
                          }
                          else {
                              PHARMAACE.FORECASTAPP.UTILITY.popalert("Updation Failed", "UserProfile");
                          }
                      },
                           function (result) {
                               PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
                           });
      }
      function DeleteUserById(id) {
          bootbox.dialog({
              message: "Are You Sure Want To Delete ?",
              title: "",
              closeButton: true,
              size: 'small',
              className: "custom-dialogue",
              buttons: {
                  success: {
                      label: "Yes",
                      className: "btn-diabox",
                      callback: function (result) {
                          if (result) {
                              PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/DeleteUserById", { id: id },
                                         function (result) {
                                             if (result.success) {
                                                 if (result.outparam == 1) {
                                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("User Deleted Successfully", '');
                                                 }
                                                 else if (result.outparam == 0)
                                                 {
                                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not delete user , please try again..", '');
                                                 }
                                                 else if (result.outparam == 2)
                                                 {
                                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Invalid User", '');
                                                 }
                                                 else
                                                 {
                                                     PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not delete user , please try again..", '');
                                                 }
                                                 refreshUsersList();
                                             }
                                             else {
                                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not delete user , please try again..", '');
                                             }
                                         },
                                              function (result) {
                                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not delete user , please try again..", '');
                                              });
                          }
                      }
                  },
                  danger: {
                      label: "No",
                      className: "btn-default",
                  },
                  main: {
                      label: "Cancel",
                      className: "btn-dacancel",
                      callback: function () {
                          bootbox.hideAll();
                      }
                  }
              }
          });
      }


      function refreshUsersList()
      {
          var SubscriberId;
          <%if (Session["RoleId"].ToString() == "3") {%>
          var ele = document.getElementById('SubscriberId');
          selectedIndex = ele.options[ele.selectedIndex];
          if (selectedIndex != 0) {
              SubscriberId = ele.options[ele.selectedIndex].value;
          }
          <%} else{%>
          SubscriberId = '<%= Session["CompanyId"].ToString() %>';
          <%}%>
          var SubscriberIds = [];
          SubscriberIds.push(SubscriberId);
          var postData = JSON.stringify({ 'SubscriberIds': SubscriberIds, });
          PHARMAACE.FORECASTAPP.SERVICE.postHtmlData("/Admin/UserList", postData,
             function (data) {
                 document.getElementById('UserListDiv').innerHTML = data;
             },
             function (status) {
                 alert(status);
             });
          return false;
      }
      function getUsersList(subscriberId) {
          if (!subscriberId)
              subscriberId = '<%= Session["CompanyId"].ToString() %>';
          var SubscriberIds = [];
          SubscriberIds.push(subscriberId);
          var postData = JSON.stringify({ 'SubscriberIds': SubscriberIds, });
          PHARMAACE.FORECASTAPP.SERVICE.postHtmlData("/Admin/UserList", postData,
        function (data) {
            document.getElementById('UserListDiv').innerHTML = data;
        },
        function (status) {
            alert(status);
        });
    return false;
}

    

      function viewpermissionmodel(permision) {
          $("#EditPermission").modal();
}
     
     
      $(window).on('shown.bs.modal', function () {
          //if( typeof currentPermissions !== 'undefined'){
          if (currentPermissions !== null) {
              
                  if (currentPermissions.KnowledgeManagement == true) {
                      $("input[name='KnowledgeManagement']").prop('checked', currentPermissions.KnowledgeManagement);
                      if (currentPermissions.AccessTypeKM == 1) {
                          $("input[id=KM1][value=" + currentPermissions.AccessTypeKM + "]").attr('checked', 'checked');
                      }
                      else if(currentPermissions.AccessTypeKM == 2)
                      {
                          $("input[id=KM2][value=" + currentPermissions.AccessTypeKM + "]").attr('checked', 'checked');
                      }
                      else if(currentPermissions.AccessTypeKM == 3)
                      {
                          $("input[id=KM3][value=" + currentPermissions.AccessTypeKM + "]").attr('checked', 'checked');
                      }

              }
              
                  if (currentPermissions.BusinessIntelligence == true) {
                      $("input[name='BusinessIntelligence']").prop('checked', currentPermissions.BusinessIntelligence);
                      if (currentPermissions.AccessTypeBI == 1) {
                          $("input[id=BI1][value=" + currentPermissions.AccessTypeBI + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeBI == 2) {
                          $("input[id=BI2][value=" + currentPermissions.AccessTypeBI + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeBI == 3) {
                          $("input[id=BI3][value=" + currentPermissions.AccessTypeBI + "]").attr('checked', 'checked');
                      }

              }
                  if (currentPermissions.CommunityOfPractice == true) {
                      $("input[name='CommunityOfPractice']").prop('checked', currentPermissions.CommunityOfPractice);
                      if (currentPermissions.AccessTypeCP == 1) {
                          $("input[id=CP1][value=" + currentPermissions.AccessTypeCP + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeCP == 2) {
                          $("input[id=CP2][value=" + currentPermissions.AccessTypeCP + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeCP == 3) {
                          $("input[id=CP3][value=" + currentPermissions.AccessTypeCP + "]").attr('checked', 'checked');
                      }
                  }
                  if (currentPermissions.CustomFeed == true) {
                      $("input[name='CustomFeed']").prop('checked', currentPermissions.CustomFeed);
                      if (currentPermissions.AccessTypeCF == 1) {
                          $("input[id=CF1][value=" + currentPermissions.AccessTypeCF + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeCF == 2) {
                          $("input[id=CF2][value=" + currentPermissions.AccessTypeCF + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeCF == 3) {
                          $("input[id=CF3][value=" + currentPermissions.AccessTypeCF + "]").attr('checked', 'checked');
                      }
                  }
                  if (currentPermissions.Utilities == true) {
                      $("input[name='Utilities']").prop('checked', currentPermissions.Utilities);
                      if (currentPermissions.AccessTypeUT == 1) {
                          $("input[id=UT1][value=" + currentPermissions.AccessTypeUT + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeUT == 2) {
                          $("input[id=UT2][value=" + currentPermissions.AccessTypeUT + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeUT == 3) {
                          $("input[id=UT3][value=" + currentPermissions.AccessTypeUT + "]").attr('checked', 'checked');
                      }
                  }
                  if (currentPermissions.UserWorkspace == true) {
                      $("input[name='UserWorkspace']").prop('checked', currentPermissions.UserWorkspace);
                      if (currentPermissions.AccessTypeUW == 1) {
                          $("input[id=UW1][value=" + currentPermissions.AccessTypeUW + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeUW == 2) {
                          $("input[id=UW2][value=" + currentPermissions.AccessTypeUW + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeUW == 3) {
                          $("input[id=UW3][value=" + currentPermissions.AccessTypeUW + "]").attr('checked', 'checked');
                      }
                  }
                  if (currentPermissions.HelpDesk == true) {
                      $("input[name='HelpDesk']").prop('checked', currentPermissions.HelpDesk);
                      if (currentPermissions.AccessTypeHD == 1) {
                          $("input[id=HD1][value=" + currentPermissions.AccessTypeHD + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeHD == 2) {
                          $("input[id=HD2][value=" + currentPermissions.AccessTypeHD + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeHD == 3) {
                          $("input[id=HD3][value=" + currentPermissions.AccessTypeHD + "]").attr('checked', 'checked');
                      }
                  }
              if (currentPermissions.ForecastPlatform) {
                  $("input[name='ForecastPlatform']").prop('checked', currentPermissions.ForecastPlatform);
                  if (currentPermissions.GenericTool == true) {
                      $("input[name='GenericTool']").prop('checked', currentPermissions.GenericTool);
                      if (currentPermissions.AccessTypeGT == 1) {
                          $("input[id=GT1][value=" + currentPermissions.AccessTypeGT + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeGT == 2) {
                          $("input[id=GT2][value=" + currentPermissions.AccessTypeGT + "]").attr('checked', 'checked');
                      }
                     else if (currentPermissions.AccessTypeGT == 3) {
                         $("input[id=GT3][value=" + currentPermissions.AccessTypeGT + "]").attr('checked', 'checked');
                      }
                  }

                  if (currentPermissions.BDLTool == true) {
                      $("input[name='BDLTool']").prop('checked', currentPermissions.BDLTool);
                      if (currentPermissions.AccessTypeBDL == 1) {
                          $("input[id=BDL1][value=" + currentPermissions.AccessTypeBDL + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeBDL == 2) {
                          $("input[id=BDL2][value=" + currentPermissions.AccessTypeBDL + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeBDL == 3) {
                          $("input[id=BDL3][value=" + currentPermissions.AccessTypeBDL + "]").attr('checked', 'checked');
                      }
                  }

                  if (currentPermissions.PatientFlow == true) {
                      $("input[name='PatientFlow']").prop('checked', currentPermissions.PatientFlow);
                      if (currentPermissions.AccessTypePF == 1) {
                          $("input[id=PF1][value=" + currentPermissions.AccessTypePF + "]").attr('checked', 'checked');
                      }
                     else if (currentPermissions.AccessTypePF == 2) {
                         $("input[id=PF2][value=" + currentPermissions.AccessTypePF + "]").attr('checked', 'checked');
                      }
                     else if (currentPermissions.AccessTypePF == 3) {
                         $("input[id=PF3][value=" + currentPermissions.AccessTypePF + "]").attr('checked', 'checked');
                      }
                  }

                  if (currentPermissions.GenericTool == true) {
                      if (currentPermissions.AccessTypeGTforproject == 1) {
                          $("input[name='GenericTool']").prop('checked', currentPermissions.GenericTool);
                          $("input[name=AccessTypeGTforproject][value=" + currentPermissions.AccessTypeGTforproject + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeGTforproject == 0) {
                          //$("input[name='GenericTool']").prop('checked', currentPermissions.GenericTool);
                          $("input[id=GT5][value=" + currentPermissions.AccessTypeGTforproject + "]").attr('checked', 'checked');
                      }
                  }

                  if (currentPermissions.BDLTool == true) {
                      if (currentPermissions.AccessTypeBDLforproject == 1) {
                          $("input[name='BDLTool']").prop('checked', currentPermissions.BDLTool);
                          $("input[name=AccessTypeBDLforproject][value=" + currentPermissions.AccessTypeBDLforproject + "]").attr('checked', 'checked');
                      }
                      else if (currentPermissions.AccessTypeBDLforproject == 0) {
                         // $("input[name='BDLTool']").prop('checked', currentPermissions.BDLTool);
                          $("input[id=BDL5][value=" + currentPermissions.AccessTypeBDLforproject + "]").attr('checked', 'checked');
                      }
                  }

                  if (currentPermissions.PatientFlow == true) {
                      if (currentPermissions.AccessTypePFforproject == 1) {
                          $("input[name='PatientFlow']").prop('checked', currentPermissions.PatientFlow);
                          $("input[name=AccessTypePFforproject][value=" + currentPermissions.AccessTypePFforproject + "]").attr('checked', 'checked');
                      }
                     else if (currentPermissions.AccessTypePFforproject == 0) {
                          //$("input[name='PatientFlow']").prop('checked', currentPermissions.PatientFlow);
                          $("input[id=PF5][value=" + currentPermissions.AccessTypePFforproject + "]").attr('checked', 'checked');
                      }
                  }


              }
          }
     // }
          
      });

      $(document).ready(function () {

       //start Notification code
         //window.setInterval(function () {
         //       GetNotifications()
         //   }, 5000);
        //Ends Notification code
         var SubscriberId;
          <%if (Session["RoleId"].ToString() == "3") {%>
          var ele = document.getElementById('SubscriberId');
          selectedIndex = ele.options[ele.selectedIndex];
          if (selectedIndex != 0) {
              SubscriberId = ele.options[ele.selectedIndex].value;
          }
          <%} else{%>
          SubscriberId = '<%= Session["CompanyId"].ToString() %>';
          <%}%>
          var SubscriberIds = [];
          SubscriberIds.push(SubscriberId);
          var postData = JSON.stringify({ 'SubscriberIds': SubscriberIds, });
          PHARMAACE.FORECASTAPP.SERVICE.postHtmlData("/Admin/UserList", postData,
             function (data) {
                 document.getElementById('UserListDiv').innerHTML = data;
             },
             function (status) {
                 alert(status);
             });
          return false;
          PHARMAACE.FORECASTAPP.UTILITY.loadScript("../../Scripts/lib/jquery/jquery.nicescroll.min.js", function () {
              $("#flyerInnerbox").niceScroll({
                  cursorfixedheight: 70
              });
          });

         
      });

      $(function () {

          $('input[type="radio"]').change(radioboxChanged);

          function radioboxChanged() {
              var $this = $(this),
                  checked = $this.prop("checked"),
                  container = $this.parent().parent();
              container.find("input[type='checkbox']").prop('checked', true);
              if (container.hasClass('FCGen') || container.hasClass('FCBDL') || container.hasClass('FCPF'))
                  $("input[name='ForecastPlatform']").prop('checked', true);
          }

          $('input[type="checkBox"]').change(checkboxChanged);

          function checkboxChanged() {
              var $this = $(this),
                  checked = $this.prop("checked"),
                  container = $this.parent().parent();
              container.find("input[type='radio']").prop('checked', false);
              container.find("input[type='checkbox']").prop('checked', false);
              if ($this.val() == "ForecastPlatform")
              {
                  $("input[name='ForecastPlatform']").prop('checked', false);
                  $("input[name='GenericTool']").prop('checked', false);
                  $("input[name='BDLTool']").prop('checked', false);
                  $("input[name='PatientFlow']").prop('checked', false);
                  $("tr[class='FCGen']").find("input[type='radio']").prop('checked', false);
                  $("tr[class='FCBDL']").find("input[type='radio']").prop('checked', false);
                  $("tr[class='FCPF']").find("input[type='radio']").prop('checked', false);
              }
          }
      });

      //function GetNotifications() {
      //    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
      //        function (result) {
      //            if (result.success) {
      //                PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
      //            }
      //        });
      //}
  </script>
</body>


