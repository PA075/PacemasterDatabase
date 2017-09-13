<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.SubscriberListModel>" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title> Admin </title>
    <!-- Bootstrap core CSS -->
  <%--  <link type="text/css" href="../../Content/CSS/adminuserbootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../../Content/CSS/adminuseranimate.min.css" rel="stylesheet" />
     <link type="text/css" href="../../Content/CSS/adminusercustom.css" rel="stylesheet" />--%>
      <%: Styles.Render( "~/Content/AdminCSS")  %>
    <link type="text/css" href="../../Content/CSS/adminuserfont-awesome.min.css" rel="stylesheet" />
    
    <%-- <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">--%>
<%--     <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.min.js"></script>
    <script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
        <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js"></script>
    <script src="../../Scripts/lib/jquery/custom.js"></script>
     <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script> --%>
    <%: Scripts.Render ( "~/Scripts/SignUpAdminUserScript") %>
    <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
     <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
</head>
    <%Html.RenderPartial("_Notification"); %>
<body class="nav-md">
    <div class="header navbar navbar-inverse ">
        <div class="navbar-inner">
            <div class="header-seperation">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="<%=Url.Action("Index", "Home")%>" class="site_title"><img src="../../Content/img/logos.png"/></a>
                </div>
            </div>
            <div class="header-quick-nav">
                <div class="">
                    <nav class="" role="navigation" style="position:relative;">
                        <div class="pull-left" style=" position:relative; width:57%">
                            <div class="nav toggle">
                                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                            </div>
                        </div>
                        <div class="pull-right" style=" position:relative; width:24%;">
                        <div id="popalert" class="alert-info" style="display: none; margin-bottom:0px !important;padding-top:0px;"><span class="close" data-dismiss="alert">&times;</span><p style="text-align: center"></p></div>
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
                        <div class="profile-wrapper"> <img width="69" height="69" data-src-retina="../../Content/img/AdminUser/user.png" data-src="../../Content/img/AdminUser/user.png" alt="" src="../../Content/img/AdminUser/user.png"> </div>
                        <div class="user-info">
                            <div class="greeting">Welcome</div>
                            <div class="username"><%:Session["FirstName"].ToString()%></div>
                            <div class="status">Administrator</div>
                        </div>
                    </div>
                    <br />
                    <!-- sidebar menu -->
                    <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
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
                        <div class="menu_section">
                          

                        </div>
                    </div>
                </div>
            </div>
            <!-- top navigation -->
            <div class="top_nav">
            </div>
            <!-- /top navigation -->
            <!-- page content -->
            <div class="right_col content sm-gutter" role="main" id="foroverlayid">
          <form id="signupid" class="form-horizontal form-label-left">
              <%if(Session["RoleId"].ToString ()=="3" ){%>  
              <div><% Html.RenderAction("Index", "SubscriberList"); %></div>
              <%} %>
                    <span class="section">Personal Info</span>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                            First-Name <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                           <input class="form-control" id="firstname"  placeholder="" type="text"  pattern="[a-z,A-Z]{1,15}" title="First Name should not be blank" required/>
                        </div>
                    </div>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                            Last-Name <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input class="form-control" id="lastname"  placeholder="" type="text" pattern="[a-z,A-Z]{1,15}" title="Last Name should not be blank" required/>
                        </div>
                    </div>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email">
                            Email <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="email" id="email" name="email" class="form-control col-md-7 col-xs-12" placeholder="" pattern="[^@\s]+@[^@\s]+\.[^@\s]+" title="Please enter a valid email address" required>
                        </div>
                    </div>
                     <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email">
                            Admin
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                        
                             <input type="checkbox" name="isadmincheck" id="isadmincheck" >
                        </div>
                    </div>
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email">
                            Send Email
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                         
                              <input type="checkbox" name="sendemailcheck" id="sendemailcheck" >
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-6 col-md-offset-3">
                            <button class="btn btn-primary">Cancel</button>
                            <%--<button id="signupid" type="submit" class="btn btn-primary" onclick="SignUp();">Submit</button>--%>
                            <input type="submit" class="btn btn-primary" value="Submit" />
                             <button id="btnShowPermissionModel" type="button" class="btn btn-primary"  style="display:inline; float:right; margin-right:10px;">Set Permissions</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
        <!-- footer content -->
        <footer id="footer">
          <div class="copyright-info">
            <p class="pull-right">
© 2016 <a href="https://pacehomepage.com" target="_blank">PharmaACE</a>. All Rights Reserved. 
            </p>
          </div>
          <div class="clearfix"></div>
        </footer>
        <!-- /footer content -->
    <div id="custom_notifications" class="custom-notifications dsp_none">
        <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group"></ul>
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
     <div id="Permission" class="modal" tabindex="-1">
        <div class="modal-dialog" style="width: 490px;">
            <div class="modal-content">
                <div class="modal-header" style="text-align:center">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">User Permission</h4>
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
                                                <%--<input type="checkbox" name="ForecastPlatform" value="ForecastPlatform">--%><label class="modelLable" style="font-weight: bold;">ForecastPlatform</label></td>
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
   
    <script type="text/javascript">        
        var isSetPermission = false;
        var permission = {
            KnowledgeManagement: false, AccessTypeKM: "", BusinessIntelligence: false, AccessTypeBI: "", Utilities: false, AccessTypeUT: "",
            CustomFeed: false, AccessTypeCF: "", CommunityOfPractice: false, AccessTypeCP: "", UserWorkspace: false, AccessTypeUW: "", HelpDesk: false,
            AccessTypeHD: "", ForecastPlatform: false, AccessTypeFP: "", GenericTool: false, AccessTypeGT: "", AccessTypeGTforproject:"", BDLTool: false, AccessTypeBDL: "",AccessTypeBDLforproject : "",
            PatientFlow: false, AccessTypePF: "" , AccessTypePFforproject : ""
        };
        var UserDetails = { firstName: "", lastName: "", email: "", isadmin: "", roleId: "", SubscriberId: "", permission: "", mailrequired: "",tenantName:"" };
        function SetUserPermission() {
            isSetPermission = true;
            var allmodelcheckbox = $("#page-wrap > table>tbody>tr").find("input[type='checkbox']")
            for (var i = 0; i < allmodelcheckbox.length; i++) {
                var modelchek = allmodelcheckbox[i];
                if(modelchek.checked)
                {
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
            $("#Permission").modal('hide');
        }


        $('#signupid').submit(function () {
           // PHARMAACE.FORECASTAPP.UTILITY.showOverlay("Getting your data", "foroverlayid", "15", "");
            var fname = $('#firstname').val();
            var lname = $('#lastname').val();
            var email = $('#email').val();
            var chkadmin = $('#isadmincheck').is(':checked');
            var mailrequired = $('#sendemailcheck').is(':checked');
            var isadmin = chkadmin ? 1 : 0;
            var roleId = chkadmin ? 2 : 1;
            var SubscriberId;
            var tenantName;
            SubscriberId = '<%= Session["CompanyId"].ToString() %>';
            tenantName = '<%= Session["SubscriberName"].ToString() %>';
            <%if (Session["RoleId"].ToString() == "3") {%>
            if (document.getElementById('SubscriberId')) {
                var ele = document.getElementById('SubscriberId');
                selectedIndex = ele.options[ele.selectedIndex];
                if (selectedIndex != 0) {
                    SubscriberId = ele.options[ele.selectedIndex].value;
                    tenantName = ele.options[ele.selectedIndex].text;
                }
                else
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Subscriber name  ");
            }
            <%}%>
            if (isSetPermission) {

                if (tenantName != '---------Select---------') {
                    UserDetails.firstName = fname;
                    UserDetails.lastName = lname;
                    UserDetails.email = email;
                    UserDetails.isadmin = isadmin;
                    UserDetails.roleId = roleId;
                    UserDetails.SubscriberId = SubscriberId;
                    UserDetails.permission = permission;
                    UserDetails.mailrequired = mailrequired;
                    UserDetails.tenantName = tenantName;
                    var postData = JSON.stringify(UserDetails);
                    PHARMAACE.FORECASTAPP.SERVICE.traditionalPostJsonData("/Admin/SignUp", postData,
                            function (result) {
                                if (result.success) {
                                    SignupResult(result.result, fname, lname);
                                    $('#firstname').val('');
                                    $('#lastname').val('');
                                    $('#email').val('');
                                    $('#isadmincheck').attr('checked', false);
                                    $('#sendemailcheck').attr('checked', false);
                                    isSetPermission = false;

                                }
                                else {
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not sign up! ");
                                }
                            },
                            function (err) {
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not sign up! ", '');
                            });
                    return false
                }
                else {
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please select Subscriber name..  ");
                }
            }
            else
            {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please Set Permissions for User..  ");
            }


        });

        function SignupResult(result, firstName, lastName) {
            if(result==1)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Registered " + firstName + " " + lastName + " successfully! ", '');
            else if(result==2)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("User already exists!", '');
            else if (result == 3)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("User has been deactivated already!", '');
            else if (result == 4)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Permissions updated for : " + firstName + " " + lastName + "!", '');
            else if (result == 5)
                //PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not register :" + firstName + " " + lastName + "!. Maximum user limit completed .", '');
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Maximum user limit completed. Please contact admin to increase allowed number of users .", '');
            else if (result == 6)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not register user: " + firstName + " " + lastName + ", Subscription expired.", '');
            else if(result==0)
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not register user: " + firstName + " " + lastName +    '');

            return false;
        }
        function SubscriberSelected() {
            var ele = document.getElementById('SubscriberId');
            var SubscriberId = ele.options[ele.selectedIndex].value;
            return false;
        }
        //$(document).ready(function () {
        //  //start Notification code
        // window.setInterval(function () {
        //        GetNotifications()
        //    }, 5000);
        //Ends Notification code

        $(document).ready(function () {
            $('.selectpicker').selectpicker({
                style: 'btn-default',
                size: 4
            });

            $("#btnShowPermissionModel").click(function () {
                $("#Permission").modal();
            });
        });
  

        //function GetNotifications() {
        //    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
        //        function (result) {
        //            if (result.success) {
        //                PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
        //            }
        //        });
        //}

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
            if ((this.name != 'isadmincheck') && (this.name != 'sendemailcheck')) {
                var $this = $(this),
                    checked = $this.prop("checked"),
                    container = $this.parent().parent();
                container.find("input[type='radio']").prop('checked', false);
                container.find("input[type='checkbox']").prop('checked', false);
                if ($this.val() == "ForecastPlatform") {
                    $("input[name='ForecastPlatform']").prop('checked', false);
                    $("input[name='GenericTool']").prop('checked', false);
                    $("input[name='BDLTool']").prop('checked', false);
                    $("input[name='PatientFlow']").prop('checked', false);
                    $("tr[class='FCGen']").find("input[type='radio']").prop('checked', false);
                    $("tr[class='FCBDL']").find("input[type='radio']").prop('checked', false);
                    $("tr[class='FCPF']").find("input[type='radio']").prop('checked', false);
                }
            }
        }
    });

        
  </script>
<%--    <link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />
<script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js" defer></script>--%>
     <%: Styles.Render( "~/Content/BootstrapselectCSS")  %>
  <%: Scripts.Render("~/Scripts/BootstrapselectScript") %>
</body>
</html>

