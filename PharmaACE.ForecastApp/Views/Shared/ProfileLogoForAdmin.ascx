<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
  <ul class="nav navbar-nav navbar-right">
    <div class="pull-right top-menu">
        <button id="btnprofile" value='' type="button" data-toggle="dropdown" class=" profile-ava btn-circle" title="">
           <%:Session["FirstName"].ToString().Substring(0,1) +""+ Session["LastName"].ToString().Substring(0,1)%>
        </button>
        <div id="fnid" hidden="hidden"><%:Session["FirstName"]%></div>
        <div id="lnid" hidden="hidden"><%:Session["LastName"]%></div>
        <ul class="dropdown-menu" id="myprofileid">
            <%--<li class="eborder-top"><a role="button" id="profile" href="#UserProfile"><i class="icon_profile"></i>My Profile</a> </li>
            <li><a id="logout" href="../Home/logout" onclick="return false"><i class="icon_key_alt"></i>Log Out</a></li>--%>
        </ul>
    </div>
</ul>
<script type="text/javascript">
    $(document).ready(function () {
        $('.img-zoom').removeClass('opac');
        var tooltiptitle = '<%= Session["User"] %>';
        $("#btnprofile").attr("title", tooltiptitle);
        $("#btnprofile").attr("value", '<%= Session["UserId"] %>');
        $("#btnprofile").tooltip({ selector: '[data-tool-tip=tooltip]' });
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
        var str = '';
        str += '<tr class="">';
        str += '<td class="Lable">First Name:</td>';
        str += '<td id="fname"> ' + '<%= Session["FirstName"] %>' + ' </td></tr>';
        str += '<tr class="">';
        str += '<td class="Lable">Last Name:</td>';
        str += '<td id="lname"> ' + '<%= Session["LastName"] %>' + '</td></tr>';
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
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdateUserProfile", { firstname: fname, lastname: lname, email: emailid },
                    function (result) {
                        if (result.success) {
                            $('#UserProfile').hide();
                            //alert("Profile Updated Successfully");
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
       // return false;
    }
    $('#updatepasswordid').submit(function () {
        var email = '<%= Session["User"] %>';
        var currentPassword = $('#CurrentPassword').val();
        var newPassword = $('#NewPassword').val();
        var confirmedPassword = $('#ConfirmedPassword').val();
        PHARMAACE.FORECASTAPP.SERVICE.getJsonData("/Home/UpdatePassword", { email: email, currentPassword: currentPassword, newPassword: newPassword },
                    function (result) {
                        if (result.success) {
                            $('#edit1').hide();
                            PHARMAACE.FORECASTAPP.UTILITY.popalert(result.status, "");
                        }
                        else {
                            $('#edit1').hide();
                            PHARMAACE.FORECASTAPP.UTILITY.popalert(result.status, "");
                        }
                    },
                    function (result) {
                        $('#edit1').hide();
                        PHARMAACE.FORECASTAPP.UTILITY.popalert("Could not update password", "");
                    });
        return false;
    });
</script>
