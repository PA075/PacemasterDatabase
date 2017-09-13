<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<PharmaACE.ForecastApp.Models.UserInfo>>" %>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Admin</title>
<%-- <link type="text/css" href="../../Content/CSS/adminuserbootstrap.min.css" rel="stylesheet" />
  <link type="text/css" href="../../Content/CSS/adminuseranimate.min.css" rel="stylesheet" />
  <link type="text/css" href="../../Content/CSS/adminusercustom.css" rel="stylesheet" />
  <link type="text/css" href="../../Content/CSS/green.css" rel="stylesheet" />--%>
<%: Styles.Render( "~/Content/AdminCSS")  %>
<link type="text/css" href="../../Content/CSS/adminuserfont-awesome.min.css" rel="stylesheet" />


<%--<script type="text/javascript" src="../../Scripts/lib/jquery/jquery.min.js"></script>
 <script src="../../Scripts/lib/jquery/jquery.nicescroll.min.js"></script>
  <script type="text/javascript" src="../../Scripts/lib/bootstrap/bootbox.js"></script>
  <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
  <script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>
  <script src="../../Scripts/lib/jquery/bootstrap.min.js"></script>
 <script src="../../Scripts/lib/jquery/icheck.min.js"></script>
 <script src="../../Scripts/lib/jquery/custom.js"></script>
 <script src="../../Scripts/custom/bootbox.js"></script>
  <script src="../../Scripts/lib/jquery/jquery.dataTables.js"></script>--%>
<%: Scripts.Render ( "~/Scripts/AdminIndexScript") %>
<%Html.RenderPartial("_Notification"); %>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Notification.js"></script>
<style>
    #leftSubscriber li:before{height:0px;}
    #leftSubscriber li{height:30px;}
    #leftSubscriber li .subspan1{margin-left:-14px; position:absolute; z-index:99;top:-5px;}
    #leftSubscriber li .subspan2{padding-left:10px;}



</style>
<body class="nav-md">
<div class="header navbar navbar-inverse " id="headerbar">
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
<div class="username"><%:Session["FirstName"].ToString()%></div>
<div class="status">Administrator</div>
</div>
</div>
          <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
            <div class="menu_section">
              <ul class="nav side-menu">
                <li><a href="../home/index"><i class="fa fa-home" title=""></i> Home</a>
                </li>
                </ul>
            </div>
              <div class="menu_section">
              <ul class="nav side-menu">
                <li><a onclick="showIndicationRef();"  style="cursor: pointer;"><i class="fa fa-plus-square-o" title=""></i>Indication Reference</a>
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
              <%if (Session["RoleId"].ToString() == "3")
                      { %>
              <div class="menu_section">
                <ul class="nav side-menu" id="leftSubscriber">
                    <li><a><i class="fa fa-user" id="leftSubscriberLi"></i>Subscribers <span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu" id="leftSubscriberUl" style="display: none">
                            <%--<li><span class="subspan1"><input type="checkbox" /></span><span class="subspan2"><a href="../Admin/ViewUser">View Users</a></span> </li>
                            <li><span class="subspan1"><input type="checkbox" /></span><span class="subspan2"><a href="../Admin/ViewUser">View Users</a></span> </li>
                            <li><span class="subspan1""><input type="checkbox" /></span><span class="subspan2"><a href="../Admin/ViewUser">View Users</a></span> </li>
                            <li><span class="subspan1"><input type="checkbox" /></span><span class="subspan2"><a href="../Admin/ViewUser">View Users</a></span> </li>
                        --%>
                            
                        </ul>
                       
                    </li>
                    
                </ul>
                  
            </div>
            <%} %>


          </div>
        </div>
<%--                      <div style="margin-left: 25px;margin-top: 26px;"><button type="button" class="btn btn-default" onclick="showIndicationRef();">Indication Reference</button></div>--%>

      </div>
          <div id="UserListDiv" class="right_col">
          </div>
       <%-- <footer id="footer">
          <div class="copyright-info">
            <p class="pull-right">
© 2016 <a href="https://pacehomepage.com" target="_blank">PharmaACE</a>. All Rights Reserved. 
            </p>
          </div>
          <div class="clearfix"></div>
        </footer>--%>
      </div>
    </div>
      <footer class="midnight-blue" id="footer">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                © 2016 <a title="PharmaAce" href="#" target="_blank">PharmaACE</a>. All Rights Reserved.
            </div>
        </div>
    </div>
</footer>
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
    </div>
</div>
    </body>
    <script>


        $(document).ready(function () {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/SubscriberListForSuperAdmin", null,
          function (result) {
              if (result.success) {
                 
                  getSubscriberList(result.subscriberInfo);
              }
          },
          function (result) {

          });

            
        });


        function getSubscriberList(subscriberInfo) {
            if (subscriberInfo.SubscriberList.length == 0)
                return;
            var str = "";
            var element = "";

            $('#leftSubscriberUl').empty();
            for (var i = 1; i < subscriberInfo.SubscriberList.length; i++) {
                str += '<li><span class="subspan1"><input type="checkbox" class="classSubscriber"  name="' + subscriberInfo.SubscriberList[i].Value + '"/></span><span class="subspan2">' + subscriberInfo.SubscriberList[i].Text + '</span> </li>';
               
            }
            element = document.getElementById('leftSubscriberUl');
            str += '<li> <button class=" " type="button"  onclick="getSelectedSubscriber()">Ok</button></li>';
            if (element)
            {
                element.innerHTML = str;
            }   
        }

        function getSelectedSubscriber() {
            var SubscriberIds = [];
            $('input:checkbox[class="classSubscriber"]').each(function () {
                //$('input:checkbox[class="classSubscriber"]:(:checked)').each(function () {
                //alert(this);
                if (this.checked) {

                    var subscriberId = this.getAttribute('name');
                    SubscriberIds.push(subscriberId);
                }

            });
            var postData = JSON.stringify({ 'SubscriberIds': SubscriberIds, });
            //var postData = JSON.stringify(SubscriberIds);
            PHARMAACE.FORECASTAPP.SERVICE.postHtmlData("/Admin/UserList", postData,
         function (data) {
             document.getElementById('UserListDiv').innerHTML = data;
         },
             function (status) {
                 alert(status);
             });
        
        }

            
         //start Notification code
        jQuery(document).ready(function () {
            //start Notification code
            window.setInterval(function () {
                GetNotifications()
            }, 5000);
            //Ends Notification code
        });
        function GetNotifications() {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/GetUserNotification", null,
                function (result) {
                    if (result.success) {
                        PHARMAACE.FORECASTAPP.UTILITY.populateNotificationList(result.notifications)
                    }
                });
        } 
        function showIndicationRef() {
            PHARMAACE.FORECASTAPP.SERVICE.getHtmlData("/Admin/IndicationReference", {},
                                         function (result) {
                                             if (result) {

                                                 $('#UserListDiv').html(result);
                                                 summerEditor();

                                             }
                                             else
                                                 PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed: " + result.errors.join(), '');
                                         },
                                           function (result) {
                                               PHARMAACE.FORECASTAPP.UTILITY.popalert("Fetching contents failed! " + result.responseText, '');
                                           }
                                         );
        }
        function saveIndicatinReference() {
            var Indication = document.getElementById('indiName');
            var indicationname = Indication.options[Indication.selectedIndex].value;
            var Section = document.getElementById('sectionname');
            var sectionid = Section.options[Section.selectedIndex].value;
            var reference = PHARMAACE.FORECASTAPP.UTILITY.htmlEncode($('.note-editable').html());
           
            //if (type == 'button') {
            //    $("#submitEdited").attr("type", "submit");
            //}
            if (!indicationname || !sectionid) {
                $("#submitEdited").attr("type", "submit");
                return false;
            } else
            if (!reference) {
                var type = $("#submitEdited").attr('type');
                if (type == 'submit') {
                    $("#submitEdited").attr("type", "button");
                }
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter reference", '');
                return false;
            }
            else {
                
                $("#submitEdited").attr("type", "button");
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/SaveIndicationReference", { indicationname: indicationname, sectionid: sectionid, reference: reference },
                        function (result) {
                            if (result.success) {
                                if (result.outparam == 1) {
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Indication reference saved successfully ", '');
                                }
                                else if (result.outparam == 2) {
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Data added successfully", '');
                                }
                            }
                            else {
                                if (result.outparam == 3) {
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Please enter all fields", '');
                                }
                                else
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to save indication reference", '');
                            }

                        },
                        function (status) {

                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Fail to save indication reference", '');
                        });

                clearInput();
            }
        }

        function clearInput() {
            $('.note-editable.panel-body').html('');
            $('#sectionname').val('');
            $('#indiName').val('');
            $('#addindication').val('');
        }
        function addIndication() {
            var reference = document.getElementById('addindication').value;
            var status = false;
            var type = $("#addindi").attr('type');
            if (type == 'button') {
                $("#addindi").attr("type", "submit");
            }
            if (reference != "") {
                $("#addindi").attr("type", "button");
                var Indication = document.getElementById('indiName');
                for (var i = 1; i < Indication.length; i++) {
                    if (Indication[i].value.toLowerCase() == reference.toLowerCase()) {
                        status = true;
                        break;
                    }

                }
                if (!status) {
                    $('#indiName').append($("<option />").attr("value", reference).text(reference));
                    $('#indiName option:contains(' + reference + ')').prop({ selected: true });
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Indication name added successfully", '');
                }
                else
                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Indication name already present", '');
                $('#addindication').val('');
            }
            else {

                return false;
            }

        }
        function fetchReference() {
            var Indication = document.getElementById('indiName');
            var indicationname = Indication.options[Indication.selectedIndex].value;
            var Section = document.getElementById('sectionname');
            var sectionid = Section.options[Section.selectedIndex].value;

            if (!indicationname || !sectionid) {
                return false;
            }
            else {
                PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Admin/FetchIndicationReference", { indicationname: indicationname, sectionid: sectionid },
                                       function (result) {
                                           if (result.success) {
                                               var reference1 = PHARMAACE.FORECASTAPP.UTILITY.htmlDecode(result.outparam);
                                               $('.note-editable.panel-body').html(reference1);

                                           }
                                           else {
                                               $('.note-editable.panel-body').html('');
                                               PHARMAACE.FORECASTAPP.UTILITY.popalert("No data available", '');
                                           }

                                       },
                                       function (status) {

                                           PHARMAACE.FORECASTAPP.UTILITY.popalert("Fail to Fetch indication reference", '');
                                       });
            }
        }
        function summerEditor() {
            var $placeholder = $('.placeholder');
            $('#reference').summernote({
                height: 130,
                codemirror: {
                    mode: 'text/html',
                    htmlMode: true,
                    lineNumbers: true,
                    theme: 'monokai'
                },
                callbacks: {
                    onInit: function () {
                        $placeholder.show();
                    },
                    onFocus: function () {
                        $placeholder.hide();
                    },
                    onBlur: function () {
                        var $self = $(this);
                        setTimeout(function () {
                            if ($self.summernote('isEmpty') && !$self.summernote('codeview.isActivated')) {
                                $placeholder.show();
                            }
                        }, 100);
                    }
                }

            });
        }
    </script>



