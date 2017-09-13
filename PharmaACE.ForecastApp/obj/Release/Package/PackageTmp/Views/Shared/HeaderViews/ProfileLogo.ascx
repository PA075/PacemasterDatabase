<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div id="UserProfile" class="modal" tabindex="-1">
    <div class="modal-dialog gpDiv1">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">User Profile</h4>
            </div>
                <form role="form" id="profileform">
                  <div class="modal-body">
                <div class="gpDiv2">
                    <table class="table table-user-information" id="user_table" data-toggle="table" data-click-to-select="true">
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
                </form>
            <div class="modal-footer">
                <button id="btnEdit" type="button" class="btn btn-primary gpDiv4"  onclick="EditProfile();" style="display:none;">Edit</button>
                <button id="btnSave" type="button" class="btn btn-primary gpDiv3"  onclick="SaveProfile();" style="display:none; ">Save</button>
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
                    <input type="submit" class="btn btn-primary gpDiv4"  value="Update" />
                </div>
            </form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
  <ul class="nav navbar-nav navbar-left">
    <div class="pull-left top-menu">
        <button id="btnprofile" value='<%:Session["UserId"]%>' type="button" data-toggle="dropdown" class=" profile-ava btn-circle" title="">

           <%:Session["FirstName"].ToString().Substring(0,1) +""+ Session["LastName"].ToString().Substring(0,1)%>

        </button>
        <div id="fnid" hidden="hidden"><%:Session["FirstName"]%></div>
        <div id="lnid" hidden="hidden"><%:Session["LastName"]%></div>
        <ul class="dropdown-menu" id="myprofileid">
          
        </ul>
    </div>
</ul>


 
<script type="text/javascript">
    var userDetails = {};
    $(document).ready(function () {
        $('.img-zoom').removeClass('opac');
        var tooltiptitle = '<%= Session["User"] %>';
        $("#btnprofile").attr("title", tooltiptitle);
        //$("#btnprofile").tooltip({ selector: '[data-tool-tip=tooltip]' });
        var firstname = '<%=  Session["FirstName"] %>';
        var lastname = '<%=  Session["LastName"] %>';
        var roleId = '<%=  Session["RoleId"] %>';
        var tableRef = document.getElementById('myprofileid');
        var str1 = '<li class="eborder-top">' + '<a data-toggle="modal" role="button" id="profile" href="#myprofile"><i class="icon_profile"></i>My Profile</a>' + '</li>';
        var str2 = '<li class="eborder-top">' + '<a data-toggle="modal" role="button" href="#edit1"><i class="icon_profile" id="liid"></i>Change Password</a>' + '</li>';
        var str3 = '';
        var str4 = '<li>' + '<a id="logout" href="../Home/logout" onclick="return false" ><i class="icon_key_alt"></i>Log Out</a>' + '</li>';
        if (roleId == 2 || roleId == 3) {
            str3 = ' <li class="eborder-top">' + '<a href="../Admin/index"><i class="icon_profile"></i> Manage Users </a>' + '</li>';
        }
        tableRef.innerHTML = str1 + str2 + str3 + str4;
    $('#profile').click(function () {
        $('#UserProfile').show();
        var tableRef = document.getElementById('user_table').getElementsByTagName('tbody')[0];
        var fname = '<%= Session["FirstName"] %>';
        var lname = '<%= Session["LastName"] %>';
        if (userDetails) {
            if (userDetails.fname)
                fname = userDetails.fname;
            if (userDetails.lname)
                lname = userDetails.lname;
        }
        var str = '';
        str += '<tr class="">';
        str += '<td class="Lable">First Name:</td>';
        str += '<td id="fname"> ' + fname + ' </td></tr>';
        str += '<tr class="">';
        str += '<td class="Lable">Last Name:</td>';
        str += '<td id="lname"> ' + lname + '</td></tr>';
        str += '<tr class="">';
        str += '<td class="Lable" >Email:</td>';
        str += '<td id="emailid"> ' + '<%= Session["User"] %>' + '</td></tr>';
        str += '<tr class="">';
        tableRef.innerHTML = str;
        $('#UserProfile').modal('show');
        $('#btnEdit').css("display", "block");
        $('#btnSave').css("display", "block");
       // $('.modal-backdrop').css("display", "none");
        $('#btnSave').prop('disabled', true);
    });
        $('#logout').click(function (e) {
            e.preventDefault();
            var lHref = $('#logout').attr('href');
            // var msg = 'Do You Want To Log Out ?';
            bootbox.confirm({
                size: 'small',
                message: 'Do you want to log out ?',
                buttons: {
                    'confirm': {
                        label: 'Yes',
                        className: 'btn-danger pull-right'
                    },
                    'cancel': {
                        label: 'No',
                        className: 'btn-default pull-left'
                    }
                },
                callback: function (result) {
                    if (result) {
                        window.location.href = lHref;
                    }
                    else {
                    }
                }
            })
        });
    });
    function EditProfile() {
        $('#btnSave').prop('disabled', false);
       // $('input[id="btnSave"]').prop('disabled', false);        
        //document.getElementById("btnEdit").style.display = 'block';
        //document.getElementById("btnSave").style.display = 'block';
        document.getElementById("fname").innerHTML = "<input type='text'  placeholder='{0}' />".replace('{0}', $.trim($('#fname').text()));
        document.getElementById("lname").innerHTML = "<input type='text' placeholder='{0}' />".replace('{0}', $.trim($('#lname').text()));
        $('#fname>input').val($.trim($('#fname>input').attr('placeholder')));
        $('#lname>input').val($.trim($('#lname>input').attr('placeholder')));
    }
    function SaveProfile()
    {
        var fname = $('#fname>input').val();       
        var lname = $('#lname>input').val();
        var emailid = '<%= Session["User"] %>';
        if(fname!=null && fname!=undefined && fname!=""){
            if (lname != null && lname != undefined && lname!="") {
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdateUserProfile", { firstname: fname, lastname: lname, email: emailid },
                    function (result) {
                        if (result.success) {
                           // $('#UserProfile').hide();
                            $('#UserProfile').modal('hide');
                            var userName = fname.charAt(0) + lname.charAt(0);
                            $('#btnprofile').html(userName);
                            userDetails.fname = fname;
                            userDetails.lname = lname;
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Profile Updated Successfully", "UserProfile");
                        }
                        else {
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Updation Failed", "UserProfile");
                        }
                    },
                         function (result) {
                             PHARMAACE.FORECASTAPP.UTILITY.popalert(" Please try again.", "");
                             $('.modal-backdrop').css("display", "none");
                         });
            } else {
                PHARMAACE.FORECASTAPP.UTILITY.popalert("Last Name Can not be blanked", "UserProfile");
            }
        } else {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("First Name Can not be blanked", "UserProfile");
        }
       // return false;
    }
    $('#updatepasswordid').submit(function () {
        var email = '<%= Session["User"] %>';
        var currentPassword = $('#CurrentPassword').val();
        var newPassword = $('#NewPassword').val();
        var confirmedPassword = $('#ConfirmedPassword').val();
        if (newPassword == confirmedPassword) {
            PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdatePassword", { email: email, currentPassword: currentPassword, newPassword: newPassword },
                        function (result) {
                            if (result.success) {
                                $('#edit1').modal('hide');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert(result.status, "");
                                window.location.href = "/Home/logout";
                            }
                            else {
                                // $('#edit1').hide();
                                $('#edit1').modal('hide');
                                PHARMAACE.FORECASTAPP.UTILITY.popalert(result.status, "");
                                document.getElementById('CurrentPassword').value = "";
                                document.getElementById('NewPassword').value = "";
                                document.getElementById('ConfirmedPassword').value = "";
                                window.location.href = "/Home/logout";


                            }
                        },
                        function (result) {
                            $('#edit1').modal('hide');
                            PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not update password", "");
                        });
            return false;

        }
        else {
            PHARMAACE.FORECASTAPP.UTILITY.popalert("New password and ConfirmedPassword does not match", "");
           
            document.getElementById('CurrentPassword').value = "";
            document.getElementById('NewPassword').value = "";
            document.getElementById('ConfirmedPassword').value = "";
            window.location.href = "/Home/logout";
        }
    });
</script>
