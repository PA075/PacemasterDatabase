<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.SubscriberRegistrationInfo>" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin </title>
    <!-- Bootstrap core CSS -->
    <%--<link type="text/css" href="../../Content/CSS/adminuserbootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="../../Content/CSS/adminuseranimate.min.css" rel="stylesheet" />
    <link type="text/css" href="../../Content/CSS/adminusercustom.css" rel="stylesheet" />--%>
     <%: Styles.Render( "~/Content/AdminCSS")  %>
     <link type="text/css" href="../../Content/CSS/adminuserfont-awesome.min.css" rel="stylesheet" />
   <%-- <link href="../../Scripts/lib/bootstrap/bootstrap-datetimepicker.css" rel="stylesheet" />--%>

   <%-- <script type="text/javascript" src="../../Scripts/lib/jquery/jquery.min.js"></script>
    <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>    
    <script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
    <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js"></script>
    <script src="../../Scripts/lib/jquery/custom.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
    <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
    <script src="../../Scripts/lib/modernizr/moment-with-locales.js"></script>
    <script src="../../Scripts/lib/bootstrap/bootstrap-datetimepicker.js"></script>--%>
   <script src="<%: Url.Content("~/Scripts/jquery-1.8.2.min.js") %>"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.unobtrusive.min.js") %>"></script>
      <%: Scripts.Render ( "~/Scripts/SubscriberRegistrationScript") %>

</head>

<%Html.RenderPartial("_Notification"); %>
<body class="nav-md">
    <div class="header navbar navbar-inverse ">
        <div class="navbar-inner">
            <div class="header-seperation">
                <div class="navbar nav_title" style="border: 0;">
                    <a href="<%=Url.Action("Index", "Home")%>" class="site_title">
                        <img src="../../Content/img/logos.png" /></a>
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
                            <div id="popalert" class="alert-info" style="display: none; margin-bottom: 0px !important; padding-top: 0px;"><span class="close" data-dismiss="alert">&times;</span><p style="text-align: center"></p>
                            </div>
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
                        <div class="profile-wrapper">
                            <img width="69" height="69" data-src-retina="../../Content/img/AdminUser/user.png" data-src="../../Content/img/AdminUser/user.png" alt="" src="../../Content/img/AdminUser/user.png">
                        </div>
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
                                <li>
                                    <a href="../home/index"><i class="fa fa-home"></i>Home </a>

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

                 <form action="#" method="post" class="form-horizontal form-label-left" role="form" id="EditSubscriber">
                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                            Subscriber Name <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input class="form-control" id="subscribername" type="text" placeholder=""  title="Subscriber Name should not be blank" value="" required />
                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                            Is active <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">

                            <input name="radioGroup" id="radio1" value="true" type="radio" >
                            Yes
						   <input name="radioGroup" id="radio2" value="false"  type="radio">
                            No
                        </div>


                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                            Subscription Start Date <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12 date" id=''>
                            <div class="form-group">
                                <div class='input-group date' id='datetimepicker'>
                                    <input class="form-control" id="subscriptionstartdate" type="datetime" title="Subscription Start Date should not be blank" required />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">
                            Subscription End Date <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12" id=''>

                            <div class="form-group">
                                <div class='input-group date' id='datetimepicker1'>
                                    <input class="form-control" id="subscriptionenddate" type="datetime" title="Subscription End Date should not be blank" required />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="number">
                            Max User No <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="number" class="form-control" id="maxusernumber" placeholder="" pattern="[a-z,A-Z]{1,15}" title="User Number should not be blank" required />
                        </div>
                    </div>

                    <%-- <div class="item form-group">
                      <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">DB Connection String <span class="required">*</span>
                      </label>
                      <div class="col-md-6 col-sm-6 col-xs-12">
                        <input type="text" id="dbconnection" name="dbconnection"  title="Connection string should not be blank" placeholder="" class="form-control" required>
                      </div>
                    </div>--%>

                   <%-- <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">
                            DataBase Name <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="DataBaseName" name="DataBaseName" placeholder="" title="Database name should not be blank" class="form-control" required>
                        </div>
                    </div>--%>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="occupation">
                            DB Server <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input id="dbserver" type="text" name="dbserver" placeholder="" title="DB server name should not be blank" class="form-control" required>
                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">
                            DB User <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="dbuser" name="dbuser" title="DB User should not be blank" placeholder="" class="form-control" required>
                        </div>
                    </div>

                    <div class="item form-group">
                        <label for="password" class="control-label col-md-3">DB Password</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input id="password" type="password" name="password" class="form-control" title="DB Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])">
                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">
                            SP Account <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="spAccount" name="spAccount" title="Sp Account should not be blank" placeholder="" class="form-control" required>
                        </div>
                    </div>

                    <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">
                            SP Password <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="password" id="spPassword" name="spPassword" title="Sp password should not be blank" placeholder="" class="form-control" required>
                        </div>
                    </div>

                  <%--  <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">
                            Archive <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="archive" name="archive" title="Archive should not be blank" placeholder="" class="form-control" required>
                        </div>
                    </div>--%>

                     <div class="item form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="website">
                            Feed Keyword's <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <input type="text" id="feedKeyword" name="feedKeyword" title="Feed Keyword should not be blank" placeholder="" class="form-control" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-6 col-md-offset-3">
                            <input type="submit" id="signupid" class="btn btn-primary" value="Submit" />
                          <%--  <input type="submit" id="createdb" class="btn btn-primary" value="CreateDatabase" />--%>
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
        <div class="modal-dialog" style="width: 480px;">
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
                    <button id="btnEdit" type="button" class="btn btn-primary" onclick="EditProfile();" style="display: none; float: right;">Edit</button>
                    <button id="btnSave" type="button" class="btn btn-primary" onclick="SaveProfile();" style="display: none; float: right; margin-right: 10px;">Save</button>
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
                                    <input class="form-control " placeholder="Current Password" type="password" id="CurrentPassword" title="" required />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="control-label">New Password:</label>
                                </div>
                                <div class="col-md-8">

                                    <input class="form-control ,required " placeholder="New Password" type="password" id="NewPassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,15})" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="control-label">Confirm Password:</label>
                                </div>
                                <div class="col-md-8">
                                    <input class="form-control " placeholder="Confirmed Password" type="password" id="ConfirmedPassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,15})" />
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

    <%--<link href="../../Content/CSS/bootstrap-select.min.css" rel="stylesheet" />
<script src="../../Scripts/lib/bootstrap/bootstrap-select.min.js" defer></script>--%>
     <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
     <%: Styles.Render( "~/Content/BootstrapselectCSS")  %>
  <%: Scripts.Render("~/Scripts/BootstrapselectScript") %>
    <script type="text/javascript">

        /*Subscriber Registration Implementation*/

        $('#EditSubscriber').submit(function () {
            var subscriberId = <%:Model.Id%>;
            var isActive =false;
            if($('#radio1').is(':checked'))
                isActive =true;
            var subscriptionStartDate = $('#subscriptionstartdate').val();
            var subscriptionEndDate = $('#subscriptionenddate').val();
            var maxUserNumber = $('#maxusernumber').val();
            var dbServer = $('#dbserver').val();
            var dbUser = $('#dbuser').val();
            var dbPassword = $('#password').val();
            var feedKeyword = $('#feedKeyword').val();
            var spPassword = $('#spPassword').val();
            var spAccount = $('#spAccount').val();
           
           
            // subscriberId, isActive, subscriptionStartDate, subscriptionEndDate, maxUserNumber,dbServer, dbUser, dbPassword, feedKeyword,  spAccount, spPassword
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/UpdateSubscriberDetails", {subscriberId:subscriberId, isActive: isActive,
                subscriptionStartDate: subscriptionStartDate, subscriptionEndDate: subscriptionEndDate, maxUserNumber: maxUserNumber, dbServer: dbServer, 
                dbUser: dbUser, dbPassword: dbPassword,feedKeyword: feedKeyword , spPassword: spPassword,spAccount: spAccount },
                    function (result) {

                        if (result.success) {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Subscriber Details updated Successfully", '');      
                            $('#subscribername').val('');
                            $('#subscriptionstartdate').val('');
                            $('#subscriptionenddate').val('');
                            $('#maxusernumber').val('');
                            $('#dbserver').val('');
                            $('#dbuser').val('');
                            $('#password').val('');
                            $('#feedKeyword').val('');
                            $('#spPassword').val('');
                            $('#spAccount').val('');
                            $('#radio1').attr('checked', false);
                          
                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("update failed", '');
                            //alert("failed");
                        }
                    },
                     function (result) {
                         PHARMAACE.FORECASTAPP.UTILITY.popalert("update failed", '');
                         //alert("failed");

                     });
            return false;

        });

        $('#createdb').submit(function () {

        });

        $(document).ready(function () {
         //start Notification code
         //window.setInterval(function () {
         //       GetNotifications()
         //   }, 5000);
        //Ends Notification code

            $('#datetimepicker').datetimepicker();
            $('#datetimepicker1').datetimepicker();

             $('#subscribername').val('<%:Model.SubscriberName%>');
            $('#subscriptionstartdate').val('<%:Model.SubscriptionStartDate%>');
            $('#subscriptionenddate').val('<%:Model.SubscriptionEndDate%>');
            $('#maxusernumber').val('<%:Model.MaxUserNumber%>');
            $('#DataBaseName').val('<%:Model.DatabaseName%>');
            $('#dbserver').val('<%:Model.DbServer%>');
            $('#dbuser').val('<%:Model.DbUser%>');
            $('#password').val('<%:Model.DbPassword%>');
            $("input[name='radioGroup']:checked").val();
            $('#spAccount').val('<%:Model.SPAccount%>');
            $('#spPassword').val('<%:Model.SPPassword%>');
            $('#archive').val('<%:Model.Archive%>');
            $('#feedKeyword').val('<%:Model.FeedKeyword%>');
            var isActive='<%:Model.IsActive%>';
            if(isActive=='True')
                $("input[name=radioGroup][value='true']").prop("checked",true);
           else
                $("input[name=radioGroup][value='false']").prop("checked",true);
        });

        //function GetNotifications()
        //{
        //    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
        //        function (result) {
        //            if (result.success) {
        //                PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
        //            }
        //        });
        //}
    </script>
</body>
</html>

