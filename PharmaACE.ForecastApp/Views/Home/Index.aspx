<%@ Page Title="PACE Homepage" Language="C#" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="initial-scale=1, maximum-scale=1.5">
 <%: Styles.Render("~/Content/HomeIndexCSS") %>
<%--<script src="../../Scripts/lib/jquery/jquery.min.js"></script>
<script src="../../Scripts/lib/jquery/jquery.cookie.js"></script>
<script src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Validator.js"></script>
 <script src="../../Scripts/lib/bootstrap/bootbox.js"></script>
 <script src="../../Scripts/lib/bootstrap/bootstrap.min.js"></script>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
 <script src="../../Scripts/custom/lib/jquery/jquery.dataTables.min.js"></script>--%>
<%--<%: Scripts.Render ("~/Scripts/jqueryLIB") %>--%>
<%: Scripts.Render("~/Scripts/HomeIndexScript") %>
<%--<script src="../../Scripts/lib/jquery/jquery.dragsort-0.5.2.min.js"></script>--%>
 <%--<script type="text/javascript" src="../../Scripts/lib/jquery/jquery.easy-overlay.js"></script>
<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>--%>
     <%: Styles.Render("~/Content/KMHomeLoggedCSS") %>
<header id="header"  class="homeheader abc">
   <nav class="navbar navbar-inverse fixed affix-top" role="banner" id="headerbar">
      <div class="container-fluid">
         <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
               <div class="col-md-3 col-xs-3 col-sm-3 logo">
                  <div class="pull-left left-bar">
                     <a href="<%=Url.Action("Index", "Home")%>">
                     <img class="user-image img-responsive-logo" src="../../Content/img/logos.png">
                     </a>
                  </div>
               </div>
               <div class="col-md-6 col-sm-6 col-xs-6 tagline">
                  <div id="mid-tablet">
                     <h2 id="hmpage"><span>PACE Homepage</span></h2>
                     <div id="beta" class="wow fadeInDown">
                        <div class="hiDiv1">Beta</div>
                     </div>
                  </div>
               </div>
               <div class="col-md-3 col-sm-3 col-xs-3" id="avtar">
                  <div class="pull-right top-menu">
                     <button id="btnlogin" data-title="Login Form" data-target="#loginform" data-toggle="modal" class="btn  btn-sm mubutton" type="button">Login</button>
                  </div>
               </div>
               <div id="popalert" class="alert-info" style="display: none;">
                  <span class="close" data-dismiss="alert">&times;</span>
                  <p class="hiDiv2"></p>
               </div>
               <!-- This ul is for Button profile(VS/MS) option -->
               <ul class="nav navbar-nav navbar-right" >
                  <div class="pull-right top-menu">
                     <button id="btnprofile" value='' type="button" data-toggle="dropdown" class=" profile-ava btn-circle" title="" style="display:none">
                     </button>
                     <ul class="dropdown-menu" id="myprofileid">
                        <li class="eborder-top"><a role="button" id="profile" href="#UserProfile"><i class="icon_profile"></i>My Profile</a> </li>
                        <li class="eborder-top"><a data-toggle="modal" role="button" href="#edit1"><i class="icon_profile" id="liid">
                           </i>Change Password</a>
                        <li>
                           <%if(Session["RoleId"] != null)%>
                           <%if(int.Parse(Session["RoleId"].ToString())== 3 || int.Parse(Session["RoleId"].ToString()) == 2){ %>
                        <li id="manageuser" class="eborder-top"><a href="../Admin/index"><i class="icon_profile"></i> Manage Users </a></li>
                        <% } %>
                        <li><a id="logout" href="../Home/logout" onclick="return false"><i class="icon_key_alt"></i>Log Out</a></li>
                     </ul>
                  </div>
               </ul>
               <!-- This div is for Change Paddword option -->
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
                                       <input class="form-control " placeholder="Current Password" type="password" id="CurrentPassword" title="" required  />
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
                                       <input class="form-control " placeholder="Confirm Password" type="password" id="ConfirmedPassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,15})" />
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div class="modal-footer ">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                              <input type="submit" class="btn btn-primary hiDiv3" value="Update" />
                           </div>
                        </form>
                     </div>
                     <!-- /.modal-content -->
                  </div>
                  <!-- /.modal-dialog -->
               </div>
               <!-- This div is for MY PROFIL option -->
               <div id="UserProfile" class="modal" tabindex="-1">
                  <div class="modal-dialog hiDiv4">
                     <div class="modal-content">
                        <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                           <h4 class="modal-title">User Profile</h4>
                        </div>
                        <form role="form" id="profileform">
                           <div class="modal-body">
                              <div class="hiDiv5">
                                 <table class="table table-user-information" id="user_table" data-toggle="table" data-click-to-select="true">
                                    <tbody>
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                        </form>
                        <div class="modal-footer">
                           <button id="btnEdit" type="button" class="btn btn-primary hiDiv6"  onclick="EditProfile();" style="display:none;">Edit</button>
                           <button id="btnSave" type="button" class="btn btn-primary hiDiv7"  onclick="SaveProfile();" style="display:none; ">Save</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!--/.container-->
      </div>
   </nav>
   <!--/nav-->
</header>
<%--<body id="pacehomepage">--%>
<div id="page-content-wrapper">
   <div class="container">
      <div class="row">
         <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 app-bar wow fadeInDown">
            <div class="row">
               <div class="row" data-wow-duration="4s">
                  <ul id="list1">
                     <li class="col-xs-6  col-sm-4 col-md-3   brick small" >
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["ForecastPlatform"]) == true) {
                           %>
                        <div id="ForecastBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">Forecast Platform</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "Forecast" )%>">
                              <img title="Forecast Platform" width="144" alt="Forecast Platform" src="../../Content/img/lforecast.png" />
                              </a>
                           </p>
                        </div>
                        <% }
                           else
                             {
                                 %>
                        <div id="ForecastBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Forecast Platform</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "Forecast" )%>" onclick="return false;">
                              <img title="Forecast Platform" width="144" alt="Forecast Platform" src="../../Content/img/lforecast.png" />
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%> 
                        <div id="ForecastBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Forecast Platform</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "Forecast" )%>" onclick="return false;">
                              <img title="Forecast Platform" width="144" alt="Forecast Platform" src="../../Content/img/lforecast.png" />
                              </a>
                           </p>
                        </div>
                        <%} %>  
                     </li>
                     <li class="col-xs-6  col-sm-4 col-md-3  brick small">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["KnowledgeManagement"]) == true) {
                           %>
                        <div  id="KMBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">Knowledge Base</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index","KM")%>"> 
                              <img title="Knowledge Base" alt="Knowledge Management" src="../../Content/img/lknowledge.png">
                              </a>
                           </p>
                        </div>
                        <% }
                           else
                            {
                                %>
                        <div  id="KMBox" class="panel panel-default img-zoom box-shadow--8dp opac ">
                           <p class="panel-heading">Knowledge Base</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index","KM")%>" onclick="return false;"> 
                              <img title="Knowledge Base" alt="Knowledge Management" src="../../Content/img/lknowledge.png">
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%> 
                        <div  id="KMBox" class="panel panel-default img-zoom box-shadow--8dp opac ">
                           <p class="panel-heading">Knowledge Base</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index","KM")%>" onclick="return false;"> 
                              <img title="Knowledge Base" alt="Knowledge Management" src="../../Content/img/lknowledge.png">
                              </a>
                           </p>
                        </div>
                        <%} %> 
                     </li>
                     <li class="col-md-3 brick small col-sm-4 col-xs-6">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["BusinessIntelligence"]) == true) {
                           %>
                        <div id="ReportingBox" class="panel panel-default img-zoom box-shadow--8dp">
                           <p class="panel-heading">Business Intelligence</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "Reporting")%>">
                              <img title="Business Intelligence" width="144" alt="Business Intelligence" src="../../Content/img/lbi.png">
                              </a>
                           </p>
                        </div>
                        <% }
                           else
                            {
                                %>
                        <div id="ReportingBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Business Intelligence</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "Reporting")%>" onclick="return false;">
                              <img title="Business Intelligence" width="144" alt="Business Intelligence" src="../../Content/img/lbi.png">
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%> 
                        <div id="ReportingBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Business Intelligence</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "Reporting")%>" onclick="return false;">
                              <img title="Business Intelligence" width="144" alt="Business Intelligence" src="../../Content/img/lbi.png">
                              </a>
                           </p>
                        </div>
                        <%} %>                                                                        
                     </li>
                     <li class="col-md-3 brick small col-sm-4 col-xs-6">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["Utilities"]) == true) {
                           %>
                        <div id="UtilitiesBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">Utilities</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Utilities", "Forecast" )%>">
                              <img title="Utilities" alt="Utilities" width="144" src="../../Content/img/settings.jpg"></a>
                           </p>
                        </div>
                        <% }
                           else
                            {
                                %>
                        <div id="UtilitiesBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Utilities</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Utilities", "Forecast" )%>" onclick="return false;">
                              <img title="Utilities" alt="Utilities" width="144" src="../../Content/img/settings.jpg"></a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%>
                        <div id="UtilitiesBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Utilities</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Utilities", "Forecast" )%>" onclick="return false;">
                              <img title="Utilities" alt="Utilities" width="144" src="../../Content/img/settings.jpg"></a>
                           </p>
                        </div>
                        <%} %>   
                     </li>
                     <li class="col-md-3 brick small col-sm-4 col-xs-6">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["CustomFeed"]) == true) {
                           %>
                        <div id="CustomFeedBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">Market Monitor</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "LiveFeed" )%>">                                                 
                              <img title="Market Monitor" alt="Market Monitor" width="144" src="../../Content/img/lfeed.png">
                              </a>
                           </p>
                        </div>
                        <% }
                           else
                            {
                                %>
                        <div id="CustomFeedBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Market Monitor</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "LiveFeed" )%>" onclick="return false;">                                                 
                              <img title="Market Monitor" alt="Market Monitor" width="144" src="../../Content/img/lfeed.png">
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%>
                        <div id="CustomFeedBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Market Monitor</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "LiveFeed" )%>" onclick="return false;">                                                 
                              <img title="Market Monitor" alt="Market Monitor" width="144" src="../../Content/img/lfeed.png">
                              </a>
                           </p>
                        </div>
                        <%} %>
                     </li>
                     <li class="col-md-3 brick small col-sm-4 col-xs-6">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["CommunityOfPractice"]) == true) {
                           %>
                        <div id="CommunityPracticeBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">Community of Practice</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "CommunityPractice" )%> ">
                              <img title="Community of Practice" alt="Community of Practice" width="144" src="../../Content/img/commun.png">
                              </a>
                           </p>
                        </div>
                        <% }
                           else
                           {
                               %>
                        <div id="CommunityPracticeBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Community of Practice</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "CommunityPractice" )%> "onclick="return false;">
                              <img title="Community of Practice" alt="Community of Practice" width="144" src="../../Content/img/commun.png">
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%>
                        <div id="CommunityPracticeBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Community of Practice</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "CommunityPractice" )%> "onclick="return false;">
                              <img title="Community of Practice" alt="Community of Practice" width="144" src="../../Content/img/commun.png">
                              </a>
                           </p>
                        </div>
                        <%} %>
                     </li>
                     <li class="col-md-3 brick small col-sm-4 col-xs-6">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["UserWorkspace"]) == true) {
                           %>
                        <div id="UserWorkspaceBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">User Workspace</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "UserWorkSpace" )%> ">
                              <img title="User Workspace" alt="User Workspace" width="144" src="../../Content/img/lbusiness.png">
                              </a>
                           </p>
                        </div>
                        <% }
                           else
                            {
                                %>
                        <div id="UserWorkspaceBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">User Workspace</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "UserWorkSpace" )%> "onclick="return false;">
                              <img title="User Workspace" alt="User Workspace" width="144" src="../../Content/img/lbusiness.png">
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%>
                        <div id="UserWorkspaceBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">User Workspace</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("Index", "UserWorkSpace" )%> "onclick="return false;">
                              <img title="User Workspace" alt="User Workspace" width="144" src="../../Content/img/lbusiness.png">
                              </a>
                           </p>
                        </div>
                        <%} %>
                     </li>
                     <li class="col-md-3 brick small col-sm-4 col-xs-6">
                        <%if (Session["user"] != null)
                           {if ((Boolean)(Session["HelpDesk"]) == true) {
                           %>
                        <div id="HelpDeskBox" class="panel panel-default img-zoom box-shadow--8dp ">
                           <p class="panel-heading">Help Desk</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("HelpDesk", "Home")%>">
                              <img title="Help Desk" alt="Help Desk" width="144" src="../../Content/img/call.png">
                              </a>
                           </p>
                        </div>
                        <% }else
                           {
                               %>
                        <div id="HelpDeskBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Help Desk</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("HelpDesk", "Home")%>" onclick="return false;">
                              <img title="Help Desk" alt="Help Desk" width="144" src="../../Content/img/call.png">
                              </a>
                           </p>
                        </div>
                        <%
                           }
                           }
                           else
                           {%>
                        <div id="HelpDeskBox" class="panel panel-default img-zoom box-shadow--8dp opac">
                           <p class="panel-heading">Help Desk</p>
                           <p class="panel-body">
                              <a class="enableanchor" href="<%=Url.Action("HelpDesk", "Home")%>" onclick="return false;">
                              <img title="Help Desk" alt="Help Desk" width="144" src="../../Content/img/call.png">
                              </a>
                           </p>
                        </div>
                        <%} %>
                     </li>
                  </ul>
                  <input name="list1SortOrder" type="hidden" />
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<div id="loginform" class="modal" tabindex="-1">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-body">
            <label id="register" style="display: none;"><span class="hiDiv8">You are registered succesfully</span></label>
            <ul class="nav nav-tabs">
               <li class="active"><a href="#signin" data-toggle="tab">Sign In</a></li>
               <li class="hiDiv9"><a href="#forgot" data-toggle="tab">Forgot Password</a></li>
            </ul>
            <div class="tab-content">
               <div id="forgot" class="tab-pane fade in">
                  <form class="form-horizontal" id="formForgotPassword" role="form">
                     <div class="modal-body">
                        <div class="control-group">
                           <label class="control-label" for="EmailForgot">Email</label>
                           <div class="controls">
                              <input name="_csrf" id="token" type="hidden" value="mF6ZtUPf-m2lfaLiWS1HrA35svEnokb-CzcI">
                              <input type="email" name="email" id="EmailForgot" class="form-control" placeholder="you@youremail.com" required="">
                              <span class="help-block"><small>Enter the email address you used to sign-up.</small></span>
                           </div>
                        </div>
                     </div>
                     <div class="modal-footer pull-center">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-primary hiDiv10"  value="Send Mail" />
                     </div>
                  </form>
               </div>
               <div id="signin" class="tab-pane fade in active">
                  <form role="form" id="signinid" method="post">
                     <div class="modal-body">
                        <div class="form-group">
                           <label for="recipient-name" class="control-label">Email:</label>
                           <input type="email" class="form-control" id="recipient-name" title="Please enter a valid email address" pattern="(.+)@(.+)\.(.+)" required>
                        </div>
                        <div class="form-group">
                           <label for="message-text" class="control-label">Password:</label>
                           <input type="password" class="form-control" id="message-text" required />
                        </div>
                     </div>
                     <div>
                        <input type="checkbox" name="remember" id="remember" class="custom" checked="true" />
                        <label for="remember">Remember me</label>
                     </div>
                     <div class="modal-footer">
                        <div>
                           <label id="validationSummary" class="control-label"></label>
                        </div>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <input type="submit" class="btn btn-primary hiDiv11" value="Sign In" />
                     </div>
                  </form>
               </div>
            </div>
         </div>
         <div id="overlaysigninId" style="display:none;">&nbsp;</div>
      </div>
   </div>
</div>
<%--<%: Scripts.Render("~/Scripts/commonLIB") %>--%>
<%--</body>--%>
<footer class="midnight-blue" id="footer">
   <div class="container-fluid">
      <div class="row">
         <div class="col-sm-12">
            © 2016 <a title="PharmaAce" href="#" target="_blank">PharmaACE</a>. All Rights Reserved.
         </div>
      </div>
   </div>
</footer>
<script>
   var emailid = '<%= Session["User"] %>';
   var fname = '<%= Session["FirstName"] %>';
   var lname = '<%= Session["LastName"] %>';
   var ForecastAccess = '<%= Session["ForecastPlatform"]%>';
   var KMAccess = '<%= Session["KnowledgeManagement"]%>';
   var ReportingAccess = '<%= Session["BusinessIntelligence"]%>';
   var UtilitiesAccess = '<%= Session["Utilities"]%>';
   var CustomFeedAccess = '<%= Session["CustomFeed"]%>';
   var CommunityPracticeAccess = '<%= Session["CommunityOfPractice"]%>';
   var UserWorkspaceAccess = '<%= Session["UserWorkspace"]%>';
   var HelpDeskAccess = '<%= Session["HelpDesk"]%>';
   var roleId = '<%=  Session["RoleId"] %>';
</script>