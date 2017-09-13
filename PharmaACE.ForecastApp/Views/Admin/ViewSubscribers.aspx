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
<%Html.RenderPartial("_Notification"); %>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
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
          <nav class="" role="navigation">
		  <div class="pull-left">
            <div class="nav toggle">
              <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>
		</div>
<div class="pull-right">
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
          <div id="SubscriberListDiv">
          </div>
        </div>
       
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
   
  
     
 
  <script>
      $(document).ready(function () {
        //start Notification code
         //window.setInterval(function () {
         //       GetNotifications()
         //   }, 5000);
        //Ends Notification code

          PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Admin/SubscriberList", null,
             function (data) {
                 document.getElementById('SubscriberListDiv').innerHTML = data;
             },
             function (status) {
                 alert(status);
             });
          return false;
      });
      //function GetNotifications() {
      //    PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
      //        function (result) {
      //            if (result.success) {
      //                PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
      //            }
      //        });
      //}

      

      function DeleteSubscriberByName(subscriberName) {
          bootbox.dialog({
              message: "Are You Sure Want To Delete Subscriber?",
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
                              PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/DeleteSubscriberByName", { subscriberName: subscriberName },
                                         function (result) {
                                             if (result.success) {
                                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Subscriber Deleted Successfully", '');
                                                 refreshSubscribersList();
                                             }
                                             else {
                                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Please try again..", '');
                                             }
                                         },
                                              function (result) {
                                                  PHARMAACE.FORECASTAPP.UTILITY.popalert("Please try again..", '');
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

      function refreshSubscribersList()
      {
          PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Admin/SubscriberList", null,
             function (data) {
                 document.getElementById('SubscriberListDiv').innerHTML = data;
             },
             function (status) {
                 alert(status);
             });
          return false
      }
     
  </script>
</body>


