<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<PharmaACE.ForecastApp.Models.ForgotPassword>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Reset Password</title>
   <script src="../../Scripts/lib/jquery/jquery.min.js"></script>
<script src="../../Scripts/lib/jquery/jquery.cookie.js"></script>
<script src="../../Scripts/custom/PharmaACE.ForecastApp.Utility.js"></script>
 <script src="../../Scripts/custom/PharmaACE.ForecastApp.Validator.js"></script>
 <script src="../../Scripts/lib/bootstrap/bootbox.js"></script>
 <script src="../../Scripts/lib/bootstrap/bootstrap.min.js"></script>
 <%--<script src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>--%>
 <script src="../../Scripts/custom/lib/jquery/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />
<link href="../../Content/CSS/animate.min.css" rel="stylesheet" />
<link href="../../Content/CSS/custom.css" rel="stylesheet" />
    <%: Scripts.Render("~/Scripts/serviceLIB") %>
 <%--<script type="text/javascript" src="../../Scripts/custom/PharmaACE.ForecastApp.Service.js"></script>--%>

</head>
    <body>
   <header id="header">
    <nav class="navbar navbar-inverse fixed affix-top" role="banner" id="headerbar">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12 ">
                    <div class="col-md-3 col-xs-3 col-sm-3 logo " id="">
                        <div class="pull-left left-bar">
                            <%--<input type="text" name="name" id="Guid"  value="" />--%>
                            <a href="<%=Url.Action("Index", "Home")%>" class="">
                                <img class="user-image img-responsive-logo" src="../../Content/img/logos.png">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6 tagline" id="">
                        <div id="mid-tablet">
                        <h2 id="hmpage"><span style="">PACE Homepage</span></h2>
                            </div>
                    </div>
                     <div id="popalert" class="alert-info" style="display: none;"><span class="close" data-dismiss="alert">&times;</span><p style="text-align: center"></p>
                     </div>
                </div>
            </div>
            <!--/.container-->
        </div>
    </nav>
    <!--/nav-->
</header>

        <div class="Css-Centre">
    <div class="modal-dialog animated bounceInDown ">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title custom_align" id="Heading">Reset Password</h4>
            </div>
          <form id="frm_reset_pwd" action="#" method="post" class="form" role="form">       
            <div class="modal-body">
                  <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label">Email:</label>
                        </div>
                        <div class="col-md-8">
                            <input  class="form-control" placeholder="Email" type="email" id="email" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label">New Password:</label>
                        </div>
                        <div class="col-md-8">
                            <input  class="form-control" placeholder="New Password" type="password" id="newpassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$" />
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <label class="control-label">Confirm Password:</label>
                        </div>
                        <div class="col-md-8">
                            <input  class="form-control " placeholder="Confirm Password" type="password" id="confirmedpassword" title="Password must contain at least 6 characters, including UPPER/lowercase and numbers and at least one special character" required pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,}$" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer ">
                <button type="submit" class="btn btn-primary" >Reset Password</button>
            </div>
         </form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
        </div>

          <div class="container" id="contentbox" style="min-height:575px;">

            <div class="row">
               <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 app-bar wow fadeInDown">
                    <div class="row" id="">
                        </div></div></div></div>

    

  <footer class="midnight-blue" id="footer">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                © 2016 <a title="PharmaAce" href="#" target="_blank">PharmaACE</a>. All Rights Reserved.
            </div>
        </div>
    </div>
</footer>
</body>
</html>


 
<script type="text/javascript">
    var GUID = "";
    $(document).ready(function () {

        var email = PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('email');
        GUID = PHARMAACE.FORECASTAPP.UTILITY.getQueryStringValue('uid');
        document.getElementById("email").value = email;
        document.getElementById("email").readOnly = true;
        document.getElementById("newpassword").onchange = validatePassword;
        document.getElementById("confirmedpassword").onchange = validatePassword;
    });
    function validatePassword() {
        var pass2 = document.getElementById("confirmedpassword").value;
        var pass1 = document.getElementById("newpassword").value;
        if (pass1 != pass2)
            document.getElementById("confirmedpassword").setCustomValidity("Passwords don't match");
        else
            document.getElementById("confirmedpassword").setCustomValidity('');
    }
    $('#frm_reset_pwd').submit(function () {
        var password = $("#newpassword").val();
        var confirmPassword = $("#confirmedpassword").val();
        var email = $("#email").val();// passed as parameters to Index details Method
        if (password == confirmPassword) {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/ResetPassword/SetNewPassword", { email: email, password: password,uid: GUID },
                            function (result) {
                                if (result.success) {
                                    //$('#frm_reset_pwd').hide();
                                    document.getElementById("newpassword").value = '';
                                    document.getElementById("confirmedpassword").value = '';
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("Password Updated Successfully", "ForgotPassword Form");
                                    window.location.href = "<%=Url.Action("Index", "Home")%>";
                                } else if (result.outparam == 4) {
                                    document.getElementById("newpassword").value = '';
                                    document.getElementById("confirmedpassword").value = '';
                                    PHARMAACE.FORECASTAPP.UTILITY.popalert("New password cannot be same as current", "ForgotPassword Form");
                                }
                                else {
                                    if (result.status == false)
                                    {
                                        document.getElementById("newpassword").value = '';
                                        document.getElementById("confirmedpassword").value = '';
                                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Password already updated", "ForgotPassword Form");
                                    }
                                    else {
                                        document.getElementById("newpassword").value = '';
                                        document.getElementById("confirmedpassword").value = '';
                                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to update password", "ForgotPassword Form");
                                    }
                                    
                                }
                            },
                            function (result) {
                                document.getElementById("newpassword").value = '';
                                document.getElementById("confirmedpassword").value = '';
                                PHARMAACE.FORECASTAPP.UTILITY.popalert("Failed to update password", "ForgotPassword Form");
                            });
            return false;
        }
        else
        {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("New password and ConfirmedPassword does not match", "");
            document.getElementById("newpassword").value = '';
            document.getElementById("confirmedpassword").value = '';
        }
        });
    
    </script>
